import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final int id;
  final String name;
  final String treatmentName;
  final DateTime dateAndTime;
  final String user;

  const Patient({
    required this.id,
    required this.name,
    required this.treatmentName,
    required this.dateAndTime,
    required this.user,
  });

  @override
  List<Object?> get props => [id, name, treatmentName, dateAndTime, user];
}
