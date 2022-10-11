import 'dart:convert';

import 'package:admin_app/http/custom_http_request.dart';
import 'package:admin_app/widget/brand_colors.dart';
import 'package:admin_app/widget/custom_TextField.dart';
import 'package:admin_app/widget/widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  Future<bool>check() async{
  var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
  return true;
  // I am connected to a mobile network.
} else if (connectivityResult == ConnectivityResult.wifi) {
  return true;
  // I am connected to a wifi network.
}
showInToast("No Internet");
return false;
  }

  getRegister() async{
    check().then((internet) async{
      if(internet != null && internet){
        var map=Map<String,dynamic>();
    map["name"]=nameController.text.toString();
    map["email"]=emailController.text.toString();
    map["password"]=passwordController.text.toString();
    map["password_confirmation"]=confirmPasswordController.text.toString();
    var responce= await http.post(Uri.parse("https://apihomechef.antopolis.xyz/api/admin/create/new/admin",),body: map,headers: CustomHttpRequest.defaultHeader);

    print("${responce.body}");
    final data=jsonDecode(responce.body);
    if(responce.statusCode==201){
      showInToast("Registration Successfull");
    }
    else{
      showInToast("Registration Failed");
    }
      }
      // else{
      //   showInToast("No Internet Connection");
      // }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
       body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [   
              CustomTextField(
                controller: nameController,
                hintText: "Enter your Name",
                 
              ),
              CustomTextField(
                controller: emailController,
                hintText: "Enter your Email",
                 
              ),
              CustomTextField(
                controller: passwordController,
                hintText: "Enter your Password",
                 
              ),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: "Enter Confirm Password",
                 
              ),
              MaterialButton(onPressed: (){
               getRegister();
              },
              color: Colors.red,
              child: Text("Submit"),
              ),
            ],
          ),
        ),
       ),
    );
  }
}