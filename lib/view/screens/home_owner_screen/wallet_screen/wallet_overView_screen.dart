import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tidybayte/helper/time_converter/time_converter.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class WalletOverviewScreen extends StatefulWidget {
  const WalletOverviewScreen({super.key});

  @override
  State<WalletOverviewScreen> createState() => _WalletOverviewState();
}

class _WalletOverviewState extends State<WalletOverviewScreen> {
  DateTime dateTime = DateTime.now();

  // Sample data source for demonstration purposes
  final List<ChartData> chartData = [
    ChartData('Housing', 300, 200),
    ChartData('Shopping', 400, 300),
    ChartData('Food', 500, 400),
  ];

  Future<void> selectYearMonth(BuildContext context) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Year and Month'),
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
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(dateTime);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (picked != null) {
      setState(() {
        dateTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
                text: DateConverter.estimatedDate(dateTime),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SfCartesianChart(
              backgroundColor: Colors.white, // Set the background color

              primaryXAxis: const CategoryAxis(),
              primaryYAxis: const NumericAxis(minimum: 0, maximum: 1000, interval: 50),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<ChartData, String>>[
                ColumnSeries<ChartData, String>(
                  width: 0.2,
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y1,
                  name: 'Budget',
                  color: AppColors.blue300, // Use a suitable color
                ),
                ColumnSeries<ChartData, String>(
                  width: 0.2,
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y2,
                  name: 'Expense',
                  color: AppColors.bhdColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Sample ChartData class
class ChartData {
  final String x;
  final double y1;
  final double y2;

  ChartData(this.x, this.y1, this.y2);
}
