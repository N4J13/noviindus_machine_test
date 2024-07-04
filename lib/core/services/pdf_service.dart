import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:noviindus_machine_test/features/branch/domain/entity/branch.dart';
import 'package:noviindus_machine_test/features/patient/domain/entity/patient_invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  Future<pw.Image?> _loadImage(String assetPath) async {
    try {
      final img = await rootBundle.load(assetPath);
      final imageBytes = img.buffer.asUint8List();
      pw.Image image1 = pw.Image(
        pw.MemoryImage(imageBytes),
      );
      return image1;
    } catch (e) {
      return null;
    }
  }

  Future<void> generateAndPrintPDF(PatientInvoiceRequest patient) async {
    final pdf = pw.Document();

    final sign = await _loadImage('assets/images/sign.png');
    final logo = await _loadImage('assets/images/logo.png');
    final smallLogo = await _loadImage('assets/images/logo.png');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack(children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 100,
                      height: 100,
                      child: smallLogo ?? pw.Container(),
                    ),
                    _buildCompanyAddress(context, patient.branch),
                  ],
                ),
                pw.SizedBox(height: 15),
                pw.Container(
                  width: double.infinity,
                  height: 1,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: PdfColor.fromInt(0xFFCBCBCB),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Patient Details',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: const PdfColor.fromInt(0xFF00A64F),
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: _buildPersonalInfo(context, patient),
                    ),
                    pw.Expanded(
                      child: _buildBookingInfo(context, patient),
                    ),
                  ],
                ),
                pw.SizedBox(height: 15),
                _buildDottedBorder(context),
                pw.SizedBox(height: 15),
                _buildInvoiceTable(context, patient),
                pw.SizedBox(height: 15),
                _buildDottedBorder(context),
                pw.SizedBox(height: 15),
                _buildTotal(context, patient),
                pw.SizedBox(height: 15),
                _buildThankYou(context, sign: sign),
                pw.Spacer(),
                _buildDottedBorder(context),
                pw.SizedBox(height: 15),
                pw.Center(
                  child: pw.Text(
                    'Booking amount is non-refundable, and it\'s important to arrive on the allotted time for your treatment',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColor.fromInt(0xFFCBCBCB),
                    ),
                  ),
                ),
              ],
            ),
            _buildWatermark(context, logo),
          ]);
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget _buildDottedBorder(pw.Context context) {
    return pw.Container(
      width: double.infinity,
      height: 1,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColor.fromInt(0xFFCBCBCB),
            width: 1,
            style: pw.BorderStyle.dashed,
          ),
        ),
      ),
    );
  }

  pw.Widget _buildWatermark(pw.Context context, pw.Image? logo) {
    return pw.Positioned(
      top: 200,
      left: 100,
      child: pw.Opacity(
        opacity: 0.1,
        child: pw.Container(
          width: 350,
          height: 350,
          child: logo ?? pw.Container(),
        ),
      ),
    );
  }

  pw.Widget _buildThankYou(pw.Context context, {pw.Image? sign}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Container(
          width: 250,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'Thank you for choosing us',
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: 16,
                  color: const PdfColor.fromInt(0xFF006837),
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                "Your well-being is our commitment, and we're honored you've entrusted us with your health journey",
                overflow: pw.TextOverflow.clip,
                textAlign: pw.TextAlign.right,
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromInt(0xFF9A9A9A),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                width: 80,
                height: 100,
                child: sign ?? pw.Container(),
              )
            ],
          ),
        )
      ],
    );
  }

  pw.Widget _buildTotal(pw.Context context, PatientInvoiceRequest patient) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Column(
          children: [
            pw.Row(
              children: [
                pw.Text(
                  'Total Amount: ',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(width: 30),
                pw.Text(
                  "Rs. ${patient.totalAmount.toString()}  ",
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Text(
                  'Discount Amount',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
                pw.SizedBox(width: 30),
                pw.Text(
                  "Rs. ${patient.discountAmount.toString()} ",
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColor.fromInt(0xFF9A9A9A),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Text(
                  'Advance Amount',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
                pw.SizedBox(width: 30),
                pw.Text(
                  "Rs. ${patient.advanceAmount.toString()}",
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColor.fromInt(0xFF9A9A9A),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Container(
              width: 130,
              height: 1,
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: PdfColor.fromInt(0xFFCBCBCB),
                    width: 1,
                    style: pw.BorderStyle.dashed,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Text(
                  'Balance Amount',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(width: 30),
                pw.Text(
                  "Rs. ${patient.balanceAmount.toString()} ",
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  pw.Widget _buildCompanyAddress(pw.Context context, Branch branch) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          branch.name.toUpperCase(),
          textAlign: pw.TextAlign.right,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          "${branch.location}, ${branch.address},",
          textAlign: pw.TextAlign.right,
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColor.fromInt(0xFF9A9A9A),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'email : ${branch.mail}',
          textAlign: pw.TextAlign.right,
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColor.fromInt(0xFF9A9A9A),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Mob : ${branch.phone}',
          textAlign: pw.TextAlign.right,
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColor.fromInt(0xFF9A9A9A),
          ),
        ),
        pw.SizedBox(height: 4),
        branch.gst.isNotEmpty
            ? pw.Text(
                'GST : ${branch.gst.toUpperCase()}',
                textAlign: pw.TextAlign.right,
                style: const pw.TextStyle(
                  fontSize: 12,
                  color: PdfColor.fromInt(0xFF9A9A9A),
                ),
              )
            : pw.Container(),
      ],
    );
  }

  pw.Widget _buildInvoiceTable(
    pw.Context context,
    PatientInvoiceRequest patient,
  ) {
    return pw.TableHelper.fromTextArray(
      context: context,
      cellAlignment: pw.Alignment.centerLeft,
      headerAlignment: pw.Alignment.centerLeft,
      cellHeight: 30,
      border: null,
      headerHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerLeft,
        4: pw.Alignment.centerLeft,
      },
      headerStyle: pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        color: const PdfColor.fromInt(0xFF00A64F),
      ),
      cellStyle: const pw.TextStyle(
        fontSize: 14,
        color: PdfColor.fromInt(0xFF9A9A9A),
      ),
      headers: <String>[
        'Treatment',
        "Price",
        "Men",
        "Women",
        "Total",
      ],
      data: <List<String>>[
        ...patient.treatmentData.map((treatment) {
          final priceAsInt = int.tryParse(treatment.treatment.price) ?? 0;
          final totalPatients =
              treatment.noOfMalePatients + treatment.noOfFemalePatients;
          final totalPrice = priceAsInt * totalPatients;
          return [
            treatment.treatment.name,
            treatment.treatment.price,
            treatment.noOfMalePatients.toString(),
            treatment.noOfFemalePatients.toString(),
            "\$ $totalPrice",
          ];
        }),
      ],
    );
  }

  pw.Widget _buildPersonalInfo(
    pw.Context context,
    PatientInvoiceRequest patient,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                'Name',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                patient.name,
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromInt(0xFF9A9A9A),
                ),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                'Address',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                patient.address,
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromInt(0xFF9A9A9A),
                ),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                'WhatsApp Number',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                patient.phone,
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromInt(0xFF9A9A9A),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildBookingInfo(
    pw.Context context,
    PatientInvoiceRequest patient,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                'Booked On',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                "${patient.createdDate} | ${patient.createdTime}",
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromInt(0xFF9A9A9A),
                ),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                'Treatment Date',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                patient.date,
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromInt(0xFF9A9A9A),
                ),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                'Treatment Time',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Text(
                patient.time,
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromInt(0xFF9A9A9A),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
