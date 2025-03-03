import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:tidybayte/app/controller/owner_controller/wallet_controller/wallet_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class WalletOverviewScreen extends StatefulWidget {
  const WalletOverviewScreen({super.key});

  @override
  State<WalletOverviewScreen> createState() => _WalletOverviewState();
}

class _WalletOverviewState extends State<WalletOverviewScreen> {
  DateTime dateTime = DateTime.now();
  final WalletController controller = Get.find<WalletController>();

  @override
  void initState() {
    super.initState();
    _fetchDataForSelectedDate();
  }

  /// Function to fetch API data based on selected date
  void _fetchDataForSelectedDate() {
    String selectedMonth = DateFormat('MMMM').format(dateTime); // Full month name (e.g., "February")
    String selectedYear = DateFormat('yyyy').format(dateTime); // Year as string

    controller.getOverView(month: selectedMonth, year: selectedYear);
  }

  ///============================= Calendar Dialog =====================
  Future<void> selectYearMonth(BuildContext context) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(AppStrings.selectYearAndMonth.tr),
          content: SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.monthYear,
              initialDateTime: dateTime,
              minimumYear: 2023,
              maximumYear: 2101,
              onDateTimeChanged: (DateTime newDateTime) {
                dateTime = newDateTime;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:  Text(AppStrings.cancel.tr),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(dateTime);
              },
              child:  Text(AppStrings.ok.tr),
            ),
          ],
        );
      },
    );

    if (picked != null) {
      setState(() {
        dateTime = picked;
      });
      _fetchDataForSelectedDate(); // Refresh data for selected month & year
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ///============================= Calendar Box =====================
          IconButton(
            onPressed: () => selectYearMonth(context),
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomText(
                color: AppColors.dark500,
                text: DateFormat('MMMM yyyy').format(dateTime), // Show full month name
              ),
            ),
          ),
          const SizedBox(height: 20),

          ///============================= Chart =====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              final overviewData = controller.overViewData.value;

              // Check if there is data available
              if (overviewData.result == null || overviewData.result!.isEmpty) {
                return const Center(child: Text("No data available"));
              }

              // Convert API data to chart format
              final List<ChartData> chartData = overviewData.result!.map((item) {
                return ChartData(
                  item.category ?? 'Unknown',
                  item.amount?.toDouble() ?? 0.0,
                  item.currentExpense?.toDouble() ?? 0.0,
                );
              }).toList();

              return SfCartesianChart(
                primaryXAxis: const CategoryAxis(
                  labelRotation: 45,
                  arrangeByIndex: true,
                  autoScrollingMode: AutoScrollingMode.start,
                  autoScrollingDelta: 5,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                ),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: (chartData.isNotEmpty)
                      ? chartData.map((e) => e.y1).reduce((a, b) => a > b ? a : b) + 100
                      : 1000,
                  interval: 50,
                ),
                series: <CartesianSeries<ChartData, String>>[
                  ///============================= Budget Series =====================
                  ColumnSeries<ChartData, String>(
                    width: 0.6,
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y1,
                    name: 'Budget',
                    color: AppColors.employeeCardColor,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.top,
                      textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),

                  ///============================= Expense Series =====================
                  ColumnSeries<ChartData, String>(
                    width: 0.6,
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y2,
                    name: 'Expense',
                    color: AppColors.bhdColor,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.outer, // Ensures both values are visible
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

// Model to hold chart data
class ChartData {
  final String x;
  final double y1;
  final double y2;

  ChartData(this.x, this.y1, this.y2);
}
