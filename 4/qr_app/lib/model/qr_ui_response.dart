import 'package:equatable/equatable.dart';
import 'package:qr_app/model/history.dart';

sealed class ResponseQR extends Equatable {
  final History message;

  const ResponseQR({required this.message});

  @override
  List<Object?> get props => [message];
}

class LinkResponseQR extends ResponseQR {
  const LinkResponseQR({required super.message});
}

class SimpleResponseQR extends ResponseQR {
  const SimpleResponseQR({required super.message});
}
