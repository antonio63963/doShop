class ErrorAlert {
  final String title;
  final String message;
  final Function() onClose;
  const ErrorAlert({
    required this.title,
    required this.message,
    required this.onClose,
  });
}

class InfoAlert {
  final String title;
  final String message;
  final Function()? onClose;
  final Function()? onSubmit;
  const InfoAlert(
      {required this.title,
      required this.message,
      this.onClose,
      required this.onSubmit});
}
