class FailureException {
  FailureException({
    required this.message,
    this.data,
  });

  final String message;
  final dynamic data;
}
