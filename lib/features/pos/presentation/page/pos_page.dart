import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';
import 'package:shopfeeforemployee/core/config/app_dimen.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/pos/presentation/cubit/pos_cubit.dart';

class PosPage extends StatefulWidget {
  static const String route = "/pos";
  final OrderDetailEntity orderDetail;

  const PosPage({Key? key, required this.orderDetail}) : super(key: key);

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  late PosCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = PosCubit()..getOrderBillPdf(widget.orderDetail);
  }

  @override
  void dispose() {
    _cubit;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Preview"),
            centerTitle: true,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
          ),
          body: BlocBuilder<PosCubit, PosState>(
            builder: (context, state) {
              if (state is PosLoadSuccess) {
                return Column(
                  children: [
                    Expanded(
                      child: PDFView(
                        filePath: state.orderBillPdf.path,
                        enableSwipe: true,
                        autoSpacing: false,
                        pageFling: false,
                        onRender: (_pages) {
                          // setState(() {
                          //   pages = _pages;
                          //   isReady = true;
                          // });
                        },
                        onError: (error) {
                          print(error.toString());
                        },
                        onPageError: (page, error) {
                          print('$page: ${error.toString()}');
                        },
                        onViewCreated: (PDFViewController pdfViewController) {
                          // _controller.complete(pdfViewController);
                        },
                        onPageChanged: (int? page, int? total) {
                          // print('page change: $page/$total');
                        },
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(AppDimen.spacing),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _cubit.printOrderBillPdf();
                          },
                          icon: Icon(Icons.print_outlined),
                          label: Text("Print"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            disabledBackgroundColor: const Color(0xffCACACA),
                            disabledForegroundColor: AppColor.lightColor,
                            textStyle: AppStyle.mediumTextStyleDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ))
                  ],
                );
              }
              return SizedBox();
            },
          )),
    );
  }
}
