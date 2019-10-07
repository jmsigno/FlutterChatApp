class Validation {
  /**
   * This class is used to validate the user input fields.
   * When a user input field is need to be validated create a object from this class and
   * called to require method
   */
  // make this a singleton class
  Validation._privateConstructor();
  static Validation instance() {
    return Validation._privateConstructor();
  }

// validta a name where itshoud contain only letters
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

  // validta a email where there should be a email form.something likde "abc@dfdf.com"
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

// validta a name where itshoud contain only letters
  String validatePassword(String value) {
    if (value.length < 4)
      return 'Atleast 4 characters';
    else
      return null;
  }
}
