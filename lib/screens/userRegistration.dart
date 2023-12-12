import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/foundation.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Creez votre compte'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Enter first named'),
                        MinLengthValidator(3,
                            errorText: 'Minimum 4 caracteres'),
                      ]),
                      decoration: InputDecoration(
                          hintText: 'Nom',
                          labelText: 'Nom',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.lightBlue,
                          ),
                          errorStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                              BorderRadius.all(Radius.circular(9.0)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Entrez votre code secret'),
                        MinLengthValidator(4,
                            errorText: 'Minimum 4 charecter filled name'),
                    ],),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      //obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Code secret',
                          labelText: 'Code secret',
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: Colors.lightBlue,
                          ),
                          errorStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                              BorderRadius.all(Radius.circular(9.0)))),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Confirmer le code secret'),
                        MinLengthValidator(4,
                            errorText: 'Minimum 4 caracteres'),
                      ],),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      //obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Confirmer le code secret',
                          labelText: 'Confirmer le code secret',
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: Colors.lightBlue,
                          ),
                          errorStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                              BorderRadius.all(Radius.circular(9.0)))),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width:MediaQuery.of(context).size.width,
                        child: ElevatedButton(onPressed: (){
                          if(_formKey.currentState!.validate()){
                            print('Form sumitted');
                          }
                        },
                            child: Text('Enregistrer'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
