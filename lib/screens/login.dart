import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'otpVerification.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  late String phone;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: Colors.white24,
      ),
      body: Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize:MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Connectez vous'),
           // VerticalSpace(h: 5),
            Text('Saisissez votre numero de telephone'),
         //   VerticalSpace(h: 5),
            Form(
              key:_formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisSize:MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IntlPhoneField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          initialCountryCode: 'SN',
                        //  countries: ['SN'],
                          onChanged: (phoneNumber){
                            setState(() {
                              phone=phoneNumber.completeNumber;
                            });
                          },
                        ),
                      ),

                    ],
                  ),
               //   VerticalSpace(h: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60)
                    ),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        phone.replaceAll(' ', '');
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((c)=>OtpVerification(phoneNumber: phone))));
                      }


                    },
                    child: Text('Se connecter'),
                  )
                ],
              ),
            )
          ],
        ),
      )

      ),

    );
  }
}
