class PatientRequest {
  final String name;
  final String phone;
  final String executive;
  final String address;
  final String payment;
  final double totalAmount;
  final double discountAmount;
  final double advanceAmount;
  final double balanceAmount;
  final String dateAndTime;
  final String id;
  final List<int> male;
  final List<int> female;
  final int branch;
  final List<int> treatments;

  PatientRequest({
    required this.name,
    required this.phone,
    required this.executive,
    required this.address,
    required this.payment,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateAndTime,
    required this.id,
    required this.branch,
    required this.female,
    required this.male,
    required this.treatments,
  });
}
