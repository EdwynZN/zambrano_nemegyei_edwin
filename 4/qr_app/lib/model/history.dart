import 'package:equatable/equatable.dart';

class History extends Equatable {
  final String message;
  final DateTime date;

  const History({
    required this.message,
    required this.date,
  });

  factory History.now(String message) => History(
    message: message,
    date: DateTime.now(),
  );
  
  @override
  List<Object?> get props => [message, date];

  
}
