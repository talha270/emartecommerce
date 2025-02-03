
emailvalidate(String ?value){
  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
    return 'Enter a valid email';
  }else if(!value.contains("@")){
    return "Enter a valid email";
  }else{
    return null;
  }
}

passwordvalidate(String ?value){
  if(value!.isEmpty||value.toString()==""){
    return "This is required.";
  }else{
    return null;
  }
}
matchpassword(value,passwordcontroller){
  if (value !=
      passwordcontroller.text.toString()) {
    return "Password not match.";
  } else if (value == null || value.isEmpty) {
    return 'Password is required';
  } else {
    return null;
  }
}

createpasswordvaliator(value){
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (value.length < 7) {
    return "At least 7 character password is required.";
  } else {
    return null;
  }
}
namevalidator(value){
  if (value == null || value.isEmpty) {
    return "Name is required.";
  } else if (value!.length < 5) {
    return "Name Must be greater than 5 characters.";
  } else {
    return null;
  }
}