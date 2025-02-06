import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model/home/payment_slip_model.dart';

class PaymentSlipPdfScreen extends StatelessWidget {
  final PaySlip paymentSlip;

  const PaymentSlipPdfScreen({super.key, required this.paymentSlip});

  Future<void> _generatePdf(BuildContext context) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            final earnings = paymentSlip.salaryElements
                .where((element) => element.type.contains('Earning'))
                .toList();
            final deductions = paymentSlip.salaryElements
                .where((element) => element.type.contains('Deduction'))
                .toList();

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Payment Slip',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                _buildPdfRow('Name', paymentSlip.employeeName),
                _buildPdfRow('Date Generated', paymentSlip.dateGenerated),
                _buildPdfRow('Slot Name', paymentSlip.slot.slotName),
                _buildPdfRow('Shift Date', paymentSlip.slot.shiftDate),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Earnings',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                ...earnings.map(
                    (e) => _buildPdfRow(e.name, e.amount.toStringAsFixed(2))),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Deductions',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                ...deductions.map(
                    (d) => _buildPdfRow(d.name, d.amount.toStringAsFixed(2))),
                pw.Divider(),
                _buildPdfRow(
                    'Net Salary',
                    paymentSlip.salaryElements
                        .firstWhere((e) => e.name == 'Net Salary')
                        .amount
                        .toStringAsFixed(2)),
              ],
            );
          },
        ),
      );

      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/payment_slip.pdf');
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF downloaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }

  pw.Widget _buildPdfRow(String title, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(value),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

 
}
