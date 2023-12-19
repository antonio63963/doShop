class Validator {
  static String? title(value) {
    if(value == null || value.isEmpty) {
      return 'Введите название*';
    }
    return null;
  }


}
