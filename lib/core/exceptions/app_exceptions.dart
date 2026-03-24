class AppExceptions implements Exception {
  final String message;
  final String? prefix;
  final int? statusCode;

  AppExceptions({required this.message, this.prefix, this.statusCode});

  @override
  String toString() => "${prefix ?? ''}$message";
}

/// Thrown when the server returns a 400 range error
class BadRequestException extends AppExceptions {
  BadRequestException([String? message, int? statusCode])
    : super(
        message: message ?? 'Invalid request parameters.',
        prefix: 'Bad Request: ',
        statusCode: statusCode,
      );
}

/// Thrown when the server returns a 401 or 403
class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String? message, int? statusCode])
    : super(
        message: message ?? 'Access denied. Please login again.',
        prefix: 'Unauthorized: ',
        statusCode: statusCode,
      );
}

/// Thrown during socket or connection timeouts
class NetworkException extends AppExceptions {
  NetworkException([String? message])
    : super(
        message: message ?? 'No internet connection or server unreachable.',
        prefix: 'Network Error: ',
      );
}

/// Internal parsing errors (e.g., JSON mismatch)
class DataParsingException extends AppExceptions {
  DataParsingException([String? message])
    : super(
        message: message ?? 'Failed to process data from the server.',
        prefix: 'Parsing Error: ',
      );
}
