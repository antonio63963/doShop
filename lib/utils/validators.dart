class Validator {
  static String? title(value) {
    if (value == null || value.isEmpty) {
      return 'Введите название*';
    }
    return null;
  }

  static String? amount(value) {
    if (value == null || value.isEmpty) {
      return 'Введите количество*';
    } else if (double.parse(value) == 0) {
      return 'Значение должно быть больше 0';
    }
    return null;
  }
}
