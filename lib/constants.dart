import 'package:flutter/material.dart';
import 'package:swp409/size_config.dart';

// const kPrimaryColor = Color(0xFF00BF6D);
// const kSecondaryColor = Color(0xFFFE9901);
// const kContentColorLightTheme = Color(0xFF1D1D35);
// const kContentColorDarkTheme = Color(0xFFF5FCF9);
// const kWarninngColor = Color(0xFFF3BB1C);
// const kErrorColor = Color(0xFFF03738);
//
const kDefaultPadding = 20.0;

const kPrimaryColor = Color(0xFFEB2F64);
const kPrimaryLightColor = Color(0xFFFFFFFF);
const kPrimaryAppbar = Color(0xFFEB2F64);
const kPrimaryBackground = Color(0xFFFDD2DB);
const kPrimaryColorLight = Color(0xFFFC628B);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF3ED2FF), Color(0xFF006CBE)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please enter email";
const String kInvalidEmailError = "Email is invalid";
const String kPassNullError = "Please enter password";
const String kShortPassError = "Password must be at least 8 character";
const String kMatchPassError = "Password doesn't match";
const String kNamelNullError = "Please enter name";
const String kPhoneNumberNullError = "Please enter phone number";
const String kAddressNullError = "Please enter address";
const String kUsernameNullError = "Please enter username";
const String kUsernameValid = "Username doesn't exist";
const String kUsernameExist = "Username exist";
const String kPasswordValid = "Email or password aren't valid";
const String ServerIP = "http://192.168.1.18:8000";
final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
