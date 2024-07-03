import 'package:noviindus_machine_test/features/patient/domain/entity/patient_invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  Future<void> generateAndPrintPDF(PatientInvoiceRequest patient) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Patient Report',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Name: ${patient.name}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('ID: ${patient.id}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('Phone: ${patient.phone}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('Address: ${patient.address}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 10),
              pw.Text('Executive: ${patient.executive}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('Branch: ${patient.branch}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('Date and Time: ${patient.date} ${patient.time}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 20),
              pw.Header(
                level: 1,
                child: pw.Text('Treatment Information',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
              ),
              // pw.Text('Treatments: ${patient.treatments.join(", ")}',
              //     style: pw.TextStyle(fontSize: 16)),
              // pw.Text('Male Treatments: ${patient.male.join(", ")}',
              //     style: pw.TextStyle(fontSize: 16)),
              // pw.Text('Female Treatments: ${patient.female.join(", ")}',
              //     style: pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 20),
              pw.Header(
                level: 1,
                child: pw.Text('Payment Information',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
              ),
              pw.Text('Total Amount: \$${patient.totalAmount}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('Discount Amount: \$${patient.discountAmount}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('Advance Amount: \$${patient.advanceAmount}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('Balance Amount: \$${patient.balanceAmount}',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('Payment Method: ${patient.payment}',
                  style: const pw.TextStyle(fontSize: 16)),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
