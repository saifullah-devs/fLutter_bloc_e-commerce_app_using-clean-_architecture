import '../utils/enum.dart';

class ApiResponse<T> {
  final FetchStatus status;
  final T? data;
  final String? message;

  const ApiResponse._({required this.status, this.data, this.message});

  const ApiResponse.initial() : this._(status: FetchStatus.initial);
  const ApiResponse.loading() : this._(status: FetchStatus.loading);

  const ApiResponse.completed(T data)
    : this._(status: FetchStatus.complete, data: data);

  const ApiResponse.error(String message)
    : this._(status: FetchStatus.error, message: message);

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}
