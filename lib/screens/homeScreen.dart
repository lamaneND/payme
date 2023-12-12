import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:payme/screens/detailsTransaction.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = "HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 1234567.54;
  String? mobileMoney;
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50, //this
        /*leadingWidth: 100,
        //leading: Icon(Icons.person,color: Colors.indigo,),
        leading: const CircleAvatar(backgroundColor: Colors.white38,
          child: InkWell(
            child: Icon(Icons.account_circle_rounded,color: Colors.indigo,size: 40,),
            //onTap: (){print("Click on avatar icon");},
          ),
          radius: 30,),*/
        centerTitle: true,
        backgroundColor: Colors.white24,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //TODO: show user balance
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text(balance.toString()+' FCFA'),
                    subtitle: Text('Balance'),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
              ),
              //TODO: button showing popup for transafering to mobile money
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Retirer',style: TextStyle(
                   // backgroundColor: Colors.blue,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  onPressed: (){
                    showModalBottomSheet(
                        isScrollControlled:true,
                        enableDrag: true,
                        context: context,
                        builder: (BuildContext context){
                          return Container(
                            height: MediaQuery.of(context).size.height*0.8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(child: InkWell(child: Icon(Icons.close,), onTap: (){
                                      mobileMoney=null;
                                      Navigator.pop(context);
                                    },
                                    ),alignment: Alignment.topRight,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                             // Image.asset("images/logos/wave.png",fit:BoxFit.cover,height: 40,),
                                              //ImageIcon(AssetImage("images/logos/wave.png"),color: Colors.blue,size:100)
                                              RadioListTile(title: Image.asset("images/logos/wave.png",fit:BoxFit.cover,height: 40,) ,value: "wave", groupValue: mobileMoney, onChanged:(value){
                                                    setState(() {
                                                      mobileMoney = value;
                                                    });
                                                  }),
                                            ],
                                          ),

                                        ),
                                        Expanded(
                                          child: RadioListTile(title:Image.asset("images/logos/orangeMoney.png",fit:BoxFit.cover,height: 40,),value: "orangeMoney", groupValue: mobileMoney, onChanged:(value){
                                            setState(() {
                                              mobileMoney = value;
                                            });
                                          }),
                                        ),

                                      ],
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          IntlPhoneField(
                                            controller: phoneNumberController,

                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                            initialCountryCode: 'SN',
                                            //  countries: [],
                                            onChanged: (phoneNumber){
                                              setState(() {
                                                // phone=phoneNumber.completeNumber;
                                              });
                                            },
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                                            decoration:InputDecoration(
                                              labelText: 'Montant',
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(width: 3),
                                              ),
                                            ),
                                            validator: (value){
                                              if(value == null || value.isEmpty){
                                                return 'Merci de donner un numero de telephone';
                                              }
                                            },
                                          ),
                                          ElevatedButton(

                                            child: Text('Transferer') ,

                                            onPressed: (){
                                              if(_formKey.currentState!.validate()){
                                                // if all information are validated
                                              }
                                            },
                                          ),
                                        ],
                                      ),

                                    ),


                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  },),

              ),
              //TODO: Showing user transactions
              Container(
                width : double.infinity,
                height : 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text('Mes transactions',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: ListView.builder(
                            itemCount:10,
                            itemBuilder: (BuildContext context, int index){
                              return  GestureDetector(
                                child: ListTile(
                                    trailing: Text(Random().nextInt(10000000).toString()+' F CFA'),
                                    title:Text('Description $index'),
                                    subtitle: Text('Date $index'),
                                ),
                                onTap: (){
                                    Navigator.pushNamed(context,DetailsTransaction.idScreen);

                                },
                              );
                            }
                        ),
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
