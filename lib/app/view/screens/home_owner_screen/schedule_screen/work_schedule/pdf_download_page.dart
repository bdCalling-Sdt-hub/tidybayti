import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:tidybayte/app/controller/owner_controller/download_controller/download_controller.dart';
import 'package:tidybayte/app/data/model/owner_model/work_schedule/user_task_model.dart';

class WorkScheduleDownloadScreen extends StatefulWidget {
  const WorkScheduleDownloadScreen({super.key});

  @override
  State<WorkScheduleDownloadScreen> createState() =>
      _WorkScheduleDownloadScreenState();
}

class _WorkScheduleDownloadScreenState
    extends State<WorkScheduleDownloadScreen> {
  final DownloadController downloadController = Get.find<DownloadController>();

  @override
  void initState() {
    super.initState();
    downloadController.getUserTask(dayName: "All"); // ✅ Fetch work schedule
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Work Schedule PDF')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PdfPreview(
              build: (format) => generatePDF(), // ✅ Generate the PDF
            ),
          ),
        ],
      ),
    );
  }

  final PdfColor containerColor = PdfColor.fromInt(0xffB5D8EE); // ✅ Light Blue
  final PdfColor cardColor = PdfColor.fromInt(0xffF5F5F5); // ✅ Light Gray
  final PdfColor headerColor = PdfColor.fromInt(0xff4A90E2); // ✅ Blue Header

  /// ✅ Generates the PDF File with Improved Card Design
  Future<Uint8List> generatePDF() async {
    final pdf = pw.Document();

    /// ✅ Fetch the latest task data from the controller
    UserTaskData userTaskData = downloadController.userTaskData.value;

    if (userTaskData.result == null || userTaskData.result!.isEmpty) {
      return pdf.save(); // ✅ Return empty PDF if no tasks are available
    }

    final PdfPageFormat pageFormat = PdfPageFormat.a4;

    /// ✅ Function to build each task card
    pw.Widget buildTaskCard(Result task) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(12),
        margin: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: pw.BoxDecoration(
          color: cardColor,
          borderRadius: pw.BorderRadius.circular(10),
          border: pw.Border.all(color: PdfColors.grey400, width: 1),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            /// ✅ Task Title
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                color: headerColor,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Text(
                task.taskName ?? "No Task Name",
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              ),
            ),
            pw.SizedBox(height: 8),

            /// ✅ Assigned To
            pw.Text(
              "Assigned To: ${task.assignedTo?.firstName ?? "N/A"} ${task.assignedTo?.lastName ?? ""}",
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.black),
            ),
            pw.SizedBox(height: 4),

            /// ✅ Task Details
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Start Time: ${task.startTimeStr ?? "N/A"}", style: pw.TextStyle(fontSize: 12)),
                    pw.Text("End Time: ${task.endTimeStr ?? "N/A"}", style: pw.TextStyle(fontSize: 12)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Room: ${task.room ?? "N/A"}", style: pw.TextStyle(fontSize: 12)),
                    pw.Text("Status: ${task.status ?? "N/A"}", style: pw.TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 8),
          ],
        ),
      );
    }

    /// ✅ Generate all task cards
    List<pw.Widget> taskCards = userTaskData.result!.map((task) => buildTaskCard(task)).toList();

    /// ✅ Add Pages with Task Cards
    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        build: (pw.Context context) => taskCards,
      ),
    );

    return pdf.save();
  }
}
