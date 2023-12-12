import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:otp_text_field/style.dart';
import 'package:payme/screens/homeScreen.dart';
import 'package:payme/screens/userRegistration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';


class OtpVerification extends StatefulWidget {
  String? phoneNumber;
  OtpVerification({super.key,required this.phoneNumber});


  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  late String verId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    verifyPhone();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50, //this
        leadingWidth: 100,
        title: Text('Verification code'),
        //leading: Icon(Icons.person,color: Colors.indigo,),
        leading: CircleAvatar(
          backgroundColor: Colors.white38,
          child: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.indigo,
              size: 40,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Entrez le code OTP'),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 40,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    verifyPin(pin);
                  },
                ),
              ),
              InkWell(
                child: Text(
                  'renvoyer le code',
                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                ),
                onTap: () {verifyPhone();},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        FirebaseAuth.instance.signInWithCredential(credential)
            .then((value){
          if(value.user!=null){
            //TODO:get user from database and redirect to homeScreen
          }
          else{
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((c)=>UserRegistration())));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        final snackBar = SnackBar(content: Text("${e.message}"));
        debugPrint(e.message);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          verId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verId = verificationId;
        });
      },
      timeout: const Duration(seconds: 60),
    );
  }


  void verifyPin(String pin) async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);
    try{
      await FirebaseAuth.instance.signInWithCredential(credential)
          .then((value){
        if(value!=null){
        //TODO: get user from api
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((c)=>HomeScreen())));
        }
        else{
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((c)=>UserRegistration())));

        }
      }
      );
    } on FirebaseAuthException catch(e){
      final snackBar = SnackBar(content: Text('code invalide'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
