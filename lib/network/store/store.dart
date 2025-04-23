import 'package:equatable/equatable.dart';

sealed class Store<T> {
  final T data;
  const Store({required this.data});
}

class Idle<T> extends Store<T> {
  Idle({required super.data});
}

class Success<T> extends Store<T> {
  const Success({required super.data});
}

class Error<T> extends Store<T> {
  final String errorMessage;
  const Error({required super.data, required this.errorMessage});
}

class Loading<T> extends Store<T> implements Equatable {
  final String message;
  const Loading({required this.message, required super.data});

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}
