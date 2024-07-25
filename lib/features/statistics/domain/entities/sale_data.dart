import 'package:shopfeeforemployee/features/statistics/domain/entities/chart_line_data.dart';

class SaleData {
  final int totalOrderCount;
  final double totalItemPrice;
  final List<ChartLineData> chartOrderCountData;
  final List<ChartLineData> chartItemPriceData;

  const SaleData({
    required this.totalOrderCount,
    required this.totalItemPrice,
    required this.chartOrderCountData,
    required this.chartItemPriceData,
  });
}