import '../../features/language/presentation/provider/language_provider.dart';

final RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

bool validEnglish(String value) {
  RegExp regex = RegExp(r'/^[A-Za-z0-9]*$');
  return (regex.hasMatch(value));
}

String? validateEmail(String? value) {
  if (!emailValid.hasMatch(value!)) {
    if (value.isEmpty) {
      return LanguageProvider.translate("validation", "empty_email");
    } else {
      return LanguageProvider.translate("validation", "incorrect_email");
    }
  }
  return null;
}


String? validateEmailORUser(String? value) {
    if (value!.isEmpty) {
      return LanguageProvider.translate("validation", "empty_email_user");
    }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return LanguageProvider.translate("validation", "empty_password");
  }

  if (value.length < 6) {
    return LanguageProvider.translate("validation", "password_min_length");
  }

  // if (!RegExp(r'[A-Z]').hasMatch(value)) {
  //   return LanguageProvider.translate("validation", "password_uppercase");
  // }
  //
  // if (!RegExp(r'[a-z]').hasMatch(value)) {
  //   return LanguageProvider.translate("validation", "password_lowercase");
  // }

  return null;
}String? validateOtp(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "otp_check");
  }
  return null;
}
String? validateCheckPhone(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "phone_check");
  }
  return null;
}

String? validateBio(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "empty_about_me");
  }
  return null;
}

String? validateConfirmPassword(String? value, String? confirmPassword) {
  if (value != confirmPassword) {
    return LanguageProvider.translate("validation", "confirm_password");
  }
  return null;
}

String? validateName(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "empty_name");
  }
  return null;
}

String? validateAddress(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "empty_address");
  }
  return null;
}

String? validateDate(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "select_date");
  }
  return null;
}

String? validateAdTitle(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "ad_title");
  }
  return null;
}

String? validateAuctionTitle(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "auction_title");
  }
  return null;
}

String? validateDescription(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "description");
  }
  return null;
}

String? validatePrice(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "price");
  }
  return null;
}

String? validateCategory(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "choose_category");
  }
  return null;
}
String? validateSubCategory(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "choose_sub_category");
  }
  return null;
}

String? validateCity(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "choose_city");
  }
  return null;
}
String? validateArea(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "choose_area");
  }
  return null;
}

String? validateFilter(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "add_filter");
  }
  return null;
}


String? validatePriceType(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "add_price_type");
  }
  return null;
}


String? validateMap(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "add_map_address");
  }
  return null;
}


String? validatePhone(String? value) {
  if (value!.isEmpty) {
    return LanguageProvider.translate("validation", "empty_phone");
  }
  if (validEnglish(value)) {
    return LanguageProvider.translate("validation", "english_phone");
  }
  return null;
}