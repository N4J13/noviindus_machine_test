import 'package:noviindus_machine_test/features/branch/domain/entity/branch.dart';
import 'package:noviindus_machine_test/features/treatment/domain/entity/treatment_data.dart';

class PatientInvoiceRequest {
  final String name;
  final String id;
  final String phone;
  final String address;
  final String executive;
  final Branch branch;
  final String date;
  final String time;
  final String createdDate;
  final String createdTime;
  final List<TreatmentData> treatmentData;
  final String totalAmount;
  final String discountAmount;
  final String advanceAmount;
  final String balanceAmount;
  final String payment;

  PatientInvoiceRequest({
    required this.name,
    required this.id,
    required this.phone,
    required this.address,
    required this.executive,
    required this.branch,
    required this.date,
    required this.time,
    required this.createdDate,
    required this.createdTime,
    required this.treatmentData,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.payment,
  });
}
