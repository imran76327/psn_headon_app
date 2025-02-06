class InputValidator {
  static String? nonEmptyValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter some text';
    }

    return null;
  }

  static String? emailValidator(String? text) {
    final nonEmptyError = nonEmptyValidator(text);
    if (nonEmptyError != null) {
      return nonEmptyError;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(text!)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? phoneNumberValidator(String? text) {
    final nonEmptyError = nonEmptyValidator(text);
    if (nonEmptyError != null) {
      return nonEmptyError;
    }

    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(text!)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  static String? passwordValidator(String? text) {
    final nonEmptyError = nonEmptyValidator(text);
    if (nonEmptyError != null) {
      return nonEmptyError;
    }

    if (text!.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  static String? passwordWithConfirmPasswordValidator(
    String? password,
    String? otherPassword,
  ) {
    String? passwordError = passwordValidator(password);
    if (passwordError != null) {
      return passwordError;
    }

    if (password != otherPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}
