class FieldValidator {
  static bool isEmail(String? valor) {
    if (valor == null || valor.isEmpty) return false;

    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(valor);
  }

  static bool isStrongPassword(String? value) {
    if (value == null || value.isEmpty) return false;

    final regex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return regex.hasMatch(value);
  }

  static bool areLettersOnly(String? value) {
    if (value == null || value.isEmpty) return false;

    final regex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$');
    return regex.hasMatch(value);
  }

  static bool areNumbersOnly(String? value) {
    if (value == null || value.isEmpty) return false;

    final regex = RegExp(r'^\d+$');
    return regex.hasMatch(value);
  }

  static bool isUsername(String? value) {
    if (value == null || value.isEmpty) return false;

    final regex = RegExp(r'^[a-zA-Z0-9_-]{3,20}$');
    return regex.hasMatch(value);
  }

  static bool isName(String? value) {
    if (value == null || value.isEmpty) return false;
    final regex = RegExp(
        r"^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžæÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$"
    );

    return regex.hasMatch(value);
  }
}
