import 'dart:io';

import 'package:collection/collection.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:shopfeeforemployee/core/common/extension/order_type_extension.dart';
import 'package:shopfeeforemployee/core/common/models/payment_type.dart';
import 'package:shopfeeforemployee/core/config/app_dimen.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/utils/format_util.dart';
import 'package:shopfeeforemployee/core/utils/pdf_util.dart';
import 'package:shopfeeforemployee/features/pos/domain/entities/customer.dart';
import 'package:shopfeeforemployee/features/pos/domain/entities/order_bill_entity.dart';

class PdfGenerator {
  static var font = GlobalData.ins.font;
  static var textFont = pw.TextStyle(font: font);
  static Future<File> generate(OrderBillEntity orderBill) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildTitle(orderBill),
        Divider(),
        buildBody(orderBill),
        buildInvoice(orderBill),
        Divider(),
        buildTotal(orderBill),
      ],
      footer: (context) => buildFooter(orderBill),
    ));

    return PdfUtil.saveDocument(name: 'order_${orderBill.id}.pdf', pdf: pdf);
  }

  // static Widget buildHeader(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 1 * PdfPageFormat.cm),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             buildSupplierAddress(invoice.supplier),
  //             Container(
  //               height: 50,
  //               width: 50,
  //               child: BarcodeWidget(
  //                 barcode: Barcode.qrCode(),
  //                 data: invoice.info.number,
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 1 * PdfPageFormat.cm),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             buildCustomerAddress(invoice.customer),
  //             buildInvoiceInfo(invoice.info),
  //           ],
  //         ),
  //       ],
  //     );

  static Widget buildBody(OrderBillEntity orderBill) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInvoiceInfo(orderBill),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildReceiverInformation(orderBill),
            ],
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: textFont.copyWith(fontWeight: FontWeight.bold)),
          Text(customer.address, style: textFont),
        ],
      );

  static Widget buildInvoiceInfo(OrderBillEntity orderBill) {
    final titles = <String>['Order Id:', 'Date:', 'Cashier:'];
    final data = <String>[
      orderBill.id,
      "${FormatUtil.formatTime(orderBill.createdAt)} - ${FormatUtil.formatDate2(orderBill.createdAt)}",
      "${orderBill.employee?.id ?? ""}-${orderBill.employee?.name ?? ""}",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];
        return buildText(title: title, value: value);
      }),
    );
  }

  static Widget buildReceiverInformation(OrderBillEntity orderBill) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${orderBill.orderType.getFormattedName()}", style: textFont.copyWith(
                  fontSize: AppDimen.normalText, fontWeight: FontWeight.bold)),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Row(children: [
            Text("${orderBill.receiverInformation.recipientName}", style: textFont.copyWith(fontWeight: FontWeight.bold)),
            Text(
              "  |  ",
            ),
            Text("${orderBill.receiverInformation.phoneNumber}", style: textFont),
          ]),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text("${orderBill.receiverInformation.detail}", style: textFont),
        ],
      );

  static Widget buildTitle(OrderBillEntity orderBill) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Shopfee', style: textFont.copyWith(
                fontSize: AppDimen.mediumTitle, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Text("Adress: ${orderBill.branch.address}", style: textFont.copyWith(
                fontSize: AppDimen.normalText,
                font: font,
              ),
              textAlign: TextAlign.center),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          Text("Order Bill", style: textFont.copyWith(
                  fontSize: AppDimen.largeTitle, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(OrderBillEntity orderBill) {
    final headers = [
      'No',
      'Item',
      'Options',
      'Quantity',
      'Unit Price',
      'Discount',
      'Total'
    ];
    final data = orderBill.itemList.mapIndexed((index, item) {
      return [
        "${index + 1}",
        item.name,
        '${item.itemDetail.size}${item.itemDetail.toppingOrderString.isNotEmpty ? "\n${item.itemDetail.toppingOrderString}" : ""}',
        '${item.itemDetail.quantity}',
        '${FormatUtil.formatDecimal(item.itemDetail.total)}',
        '${item.itemDetail.productDiscount != 0 ? item.itemDetail.productDiscount : ""}',
        '${FormatUtil.formatDecimal(item.itemDetail.totalAfterDiscount)}',
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: textFont.copyWith(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(
          border: pw.Border(
              top: pw.BorderSide(),
              left: pw.BorderSide(),
              right: pw.BorderSide(),
              bottom: pw.BorderSide())),
      cellHeight: 30,
      headerAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
      },
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.centerLeft,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
      },
      cellDecoration: (_, __, ___) {
        return const BoxDecoration(
            border: pw.Border(
                top: pw.BorderSide(),
                left: pw.BorderSide(),
                right: pw.BorderSide(),
                bottom: pw.BorderSide()));
      },
    );
  }

  static Widget buildTotal(OrderBillEntity orderBill) {
    return Column(
      children: [
        buildText(
          title: 'Item Price',
          value: FormatUtil.formatMoney(orderBill.totalItemPrice),
          unite: true,
        ),
        if (orderBill.shippingFee != 0)
          buildText(
            title: 'Shipping Fee',
            value: FormatUtil.formatMoney(orderBill.shippingFee),
            unite: true,
          ),
        if (orderBill.shippingDiscount != 0)
          buildText(
            title: 'Shipping Fee Discount',
            value: "- ${FormatUtil.formatMoney(orderBill.shippingDiscount)}",
            unite: true,
          ),
        if (orderBill.orderDiscount != 0)
          buildText(
            title: 'Order Discount',
            value: "- ${FormatUtil.formatMoney(orderBill.orderDiscount)}",
            unite: true,
          ),
        if (orderBill.coin != 0)
          buildText(
            title: 'Applied Coin',
            value: "- ${FormatUtil.formatMoney(orderBill.coin)}",
            unite: true,
          ),
        Divider(),
        buildText(
          title: 'Total',
          titleStyle: textFont.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          value: FormatUtil.formatMoney(orderBill.totalPayment),
          unite: true,
        ),
        SizedBox(height: 2 * PdfPageFormat.mm),
        Container(height: 1, color: PdfColors.grey400),
        SizedBox(height: 1 * PdfPageFormat.mm),
        buildText(
          title: 'Payment Method',
          value: "${PaymentType.getFormattedName(orderBill.transaction.type!)}",
          unite: true,
        ),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Container(height: 1, color: PdfColors.grey400),
      ],
    );
  }

  static Widget buildFooter(OrderBillEntity orderBill) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text("Thank you & See you again", style: textFont.copyWith(fontWeight: FontWeight.bold)),
          // buildSimpleText(title: 'Address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          // Text("Contact: 0334901237"),
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = textFont.copyWith(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? textFont;

    return Container(
        width: width,
        child: Column(children: [
          Row(
            children: [
              Expanded(child: Text(title, style: style)),
              Text(value, style: unite ? style : null),
            ],
          ),
          SizedBox(width: 5 * PdfPageFormat.mm),
        ]));
  }
}
