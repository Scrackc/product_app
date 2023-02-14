import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get  isLoading => _isLoading;
  set isLoading(bool value ){
    _isLoading = value;
    notifyListeners();
  } 


  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }



  // LoginFormProvider({
  //   required this.email,
  //   required this.password,
  // });


  // factory LoginFormProvider.fromRawJson(String str) =>
  //     LoginFormProvider.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  // factory LoginFormProvider.fromJson(Map<String, dynamic> json) =>
  //     LoginFormProvider(
  //       email: json["email"],
  //       password: json["password"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "email": email,
  //       "password": password,
  //     };
}
