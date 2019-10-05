class Validation {
  // make this a singleton class
  Validation._privateConstructor();
  static Validation instance() {
    return Validation._privateConstructor();
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "field is Required";
    } else if (!regExp.hasMatch(value)) {
      return "value must be a-z and A-Z";
    }
    return null;
  }

  String validateNumber(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "zipcode is Required";
    } else if (!regExp.hasMatch(value)) {
      return "code must be digits";
    }
    return null;
  }

  String validateAlphaNumeric(String value) {
    String patttern = r"^[a-zA-Z0-9]+$";
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "zipcode is Required";
    } else if (!regExp.hasMatch(value)) {
      return "only letters and numbers";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 4)
      return 'Atleast 4 characters';
    else
      return null;
  }
}
