import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Patient extends Equatable {
  final int id;
  final String? name;
  final String? treatmentName;
  final DateTime? dateAndTime;
  final String? user;

  const Patient({
    required this.id,
    required this.name,
    required this.treatmentName,
    required this.dateAndTime,
    this.user,
  });

  String get formattedDate {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateAndTime ?? DateTime.now());
  }

  @override
  List<Object?> get props => [id, name, treatmentName, dateAndTime, user];
}
