String? nameValidation (String? val) {
  RegExp nameRegex = RegExp(r'^[a-zA-Z.]+(?:\s[a-zA-Z.]+)+$');
  if (val!.isEmpty) {
    return "Please Enter Name";
  } else if (nameRegex.hasMatch(val) == false) {
    return "Invalid Name";
  }
  return null;
}

// r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$'
String? emailValidation (String? val) {
  RegExp emailRegex = RegExp(r'^[a-zA-Z0-9_-]{3,}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (val!.isEmpty) {
    return "Please Enter Email";
  } else if(emailRegex.hasMatch(val) == false){
    return "Invalid Email";
  }
  return null;
}

String? numberValidation (String? val) {
  RegExp numberRegex = RegExp(r'^(\+88)?01[3-9][0-9]{8}$');
  if (val!.isEmpty) {
    return "Please Enter Mobile Number";
  } else if (numberRegex.hasMatch(val) == false) {
    return "Invalid Number";
  }
  return null;
}

String? passwordValidation (String? val) {
  RegExp passwordRegex =
  RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{6,}$');
  if (val!.isEmpty) {
    return "Please Enter Password";
  } else if (passwordRegex.hasMatch(val) == false) {
    return "At least 1 uppercase, lowercase and number with length 6";
  }
  return null;
}

String? textValidation(String? value) {
  if (value!.trim().isEmpty) return "Please fill the field.";
  return null;
}

String? amountValidation(String? value){
  RegExp numberRegex = RegExp(r'^[0-9.]+$');
  if(value!.trim().isEmpty) {
    return "Please fill the field";
  } else if(numberRegex.hasMatch(value.trim()) == false) {
    return "Only 0-9 and . is allowed";
  }
  return null;
}