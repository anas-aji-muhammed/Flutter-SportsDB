import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_food_store/animations/fade_animations.dart';
import 'package:fresh_food_store/screens/authentication/sign_in.dart';
import 'package:fresh_food_store/screens/authentication/sign_up.dart';
import 'package:get/get.dart';
import 'package:fresh_food_store/state_manage/auth_state.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInPage(),
    );
  }
}

class SignInPage extends StatelessWidget {
  final authStateManage= Get.put(AuthStateController());
  TextEditingController textEditingControllerMobile = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeAnimation(1, Text("Login", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),)),
                    SizedBox(height: 20,),
                    FadeAnimation(1.2, Text("Login to your account", style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]
                    ),)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(1.3, makeInput(label: "Mobile")),
                    ],
                  ),
                ),
                FadeAnimation(1.4, Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        if(authStateManage.mobileNumber != null){
                          authStateManage.mobileNumber = textEditingControllerMobile.text.toString();
                          authStateManage.authenticate();
                          // showDialog(
                          //     context: context,
                          //     builder: (_) => OtpAlert(message: "Enter Verification Code.", type: "Valid")
                          // );
                        }
                        else{
                          // showDialog(
                          //     context: context,
                          //     builder: (_) => OtpAlert(message: "Please enter your mobile number.", type: "Error")
                          // );
                        }



                      },
                      color: Colors.greenAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("Login", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),),
                    ),
                  ),
                )),
                FadeAnimation(1.5, Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    GestureDetector(
                      child: Text("Sign up", style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18
                      ),),
                      onTap: (){
                        Get.off(SignUp());
                      },
                    ),
                  ],
                ))
              ],
            ),
          ),
          FadeAnimation(1.2, Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover
                )
            ),
          ))
        ],
      ),
    );
  }
  Widget makeInput({label, obscureText = false, type = TextInputType.name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          controller: textEditingControllerMobile,
          keyboardType:type,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  Widget OtpAlert({message, type}){
    return AlertDialog(
      title: Text(message),
      content: type == "Valid" ?
          Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: authStateManage.textEditingControllerOtp,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400])
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400])
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    authStateManage.smsCode = authStateManage.textEditingControllerOtp.text;
                    authStateManage.signInWithOTP();
                  },
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Login", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),),
                )

              ],
            ),
          )

          :Text("Oops")
    );
  }
}

