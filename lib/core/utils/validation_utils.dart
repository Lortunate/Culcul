/// Utility class for common validation patterns
class ValidationUtils {
  ValidationUtils._();

  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final _upperCaseRegex = RegExp(r'[A-Z]');
  static final _lowerCaseRegex = RegExp(r'[a-z]');
  static final _digitRegex = RegExp(r'\d');
  static final _phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
  static final _alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
  static final _alphabeticRegex = RegExp(r'^[a-zA-Z]+$');
  static final _numericRegex = RegExp(r'^[0-9]+$');

  /// Validates email format
  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  /// Validates password strength (at least 8 chars, 1 uppercase, 1 lowercase, 1 digit)
  static bool isValidPassword(String password) {
    if (password.length < 8) return false;
    if (!_upperCaseRegex.hasMatch(password)) return false;
    if (!_lowerCaseRegex.hasMatch(password)) return false;
    if (!_digitRegex.hasMatch(password)) return false;
    return true;
  }

  /// Validates phone number format
  static bool isValidPhone(String phone) {
    return _phoneRegex.hasMatch(phone);
  }

  /// Validates URL format
  static bool isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  /// Validates if string is not empty and not just whitespace
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Validates if string has minimum length
  static bool hasMinLength(String value, int minLength) {
    return value.length >= minLength;
  }

  /// Validates if string has maximum length
  static bool hasMaxLength(String value, int maxLength) {
    return value.length <= maxLength;
  }

  /// Validates if number is within range
  static bool isInRange(num value, num min, num max) {
    return value >= min && value <= max;
  }

  /// Validates if value is positive
  static bool isPositive(num value) {
    return value > 0;
  }

  /// Validates if value is non-negative
  static bool isNonNegative(num value) {
    return value >= 0;
  }

  /// Validates if string contains only alphanumeric characters
  static bool isAlphanumeric(String value) {
    return _alphanumericRegex.hasMatch(value);
  }

  /// Validates if string contains only alphabetic characters
  static bool isAlphabetic(String value) {
    return _alphabeticRegex.hasMatch(value);
  }

  /// Validates if string contains only numeric characters
  static bool isNumeric(String value) {
    return _numericRegex.hasMatch(value);
  }

  /// Validates if string is a valid integer
  static bool isValidInteger(String value) {
    return int.tryParse(value) != null;
  }

  /// Validates if string is a valid double
  static bool isValidDouble(String value) {
    return double.tryParse(value) != null;
  }

  /// Combines multiple validation rules
  static bool validateAll(List<bool> validations) {
    return validations.every((validation) => validation);
  }

  /// Validates with custom function
  static bool customValidation(String value, bool Function(String) validator) {
    return validator(value);
  }
}
