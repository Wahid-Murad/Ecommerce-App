import 'dart:convert';

import 'package:admin_app/http/custom_http_request.dart';
import 'package:admin_app/tab_item/bottom_nav.dart';
import 'package:admin_app/widget/brand_colors.dart';
import 'package:admin_app/widget/custom_TextField.dart';
import 'package:admin_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  SharedPreferences ? sharedPreferences;
  String loginlink="https://apihomechef.antopolis.xyz/api/admin/sign-in";
  String ? token;
  getLogin() async{
    sharedPreferences = await SharedPreferences.getInstance();
    var map=Map<String, dynamic>();
    map["email"]=emailController.text.toString();
    map["password"]=passwordController.text.toString();
    var responce = await http.post(Uri.parse(loginlink),
    body: map,
    //headers: CustomHttpRequest.defaultHeader,
    );
    final data=jsonDecode(responce.body);
    if(responce.statusCode==200){
    setState(() {
      sharedPreferences!.setString("token", data["access_token"]);
    });
    token=sharedPreferences!.getString("token");
    print("Token Saved $token");
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav()));
      showInToast("Login Successful");
    }else{
      showInToast("Login Failed");
    }
  }
  isLogin() async{
    sharedPreferences = await SharedPreferences.getInstance();
    token=sharedPreferences!.getString("token");
    try{
    if(token!.isNotEmpty){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav()));
    }
    else{
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
         print("Token is Null"); 
    }
    }
    catch(e){
      print("Exception is $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
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
                controller: emailController,
                hintText: "Enter your Email",
                 
              ),
              CustomTextField(
                controller: passwordController,
                hintText: "Enter your Password",
                 
              ),
              MaterialButton(onPressed: (){
                getLogin();
              },
              color: Colors.red,
              child: Text("Login"),
              ),
            ],
          ),
        ),
       ),
    );
  }
}