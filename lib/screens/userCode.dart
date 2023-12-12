import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'homeScreen.dart';


class UserCode extends StatefulWidget {
  static const String idScreen = "VerifyUserCode";
  const UserCode({super.key});

  @override
  State<UserCode> createState() => _UserCodeState();
}

class _UserCodeState extends State<UserCode> {
  OtpFieldController otpController = OtpFieldController();
  TextEditingController userCodeController = TextEditingController();
  String text = '';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          //TODO: App Logo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Entrer votre code secret'),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              ),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue.shade50,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),

                  counterText: '',
                  hintText: '****'

              ),
              controller: userCodeController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.none,
              showCursor: false,
              maxLength: 4,
              obscureText: true,

            ),
          ),
          NumericKeyboard(
              onKeyboardTap:(value){
                  setState(() {
                  if(text.length<4) {
                  text = text + value;
                  userCodeController.text = text;
                  }
              });
                  if(text.length==4){
                    //TODO: redirect to Home Screen
                   Navigator.pushNamed(context, HomeScreen.idScreen);
                  }
          },
            rightButtonFn: (){
              if (text.length>0){
                setState(() {
                  text = text.substring(0,text.length-1);
                  userCodeController.text = text;
                });
                print(userCodeController.text);
              }
            },
            rightIcon: Icon(
              Icons.backspace,
              color: Colors.black,
            ),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
    )

        ],
      ),
    );
  }
}
