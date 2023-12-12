import 'package:flutter/material.dart';
import 'package:payme/screens/loadingPage.dart';
import 'package:payme/screens/login.dart';
import 'package:payme/screens/userCode.dart';
import 'package:payme/screens/userRegistration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:payme/screens/detailsTransaction.dart';
import 'package:payme/screens/homeScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      debugShowCheckedModeBanner: false,
      home:  FutureBuilder<bool>(
        future: getUserId(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
          if(snapshot.connectionState==ConnectionState.done){
              if(snapshot.hasData && snapshot.data!){
              return HomeScreen();
              }
              else return LoginScreen();
          }

          return LoadingPage() ;
        }
        ,
    ),

      routes: {
        HomeScreen.idScreen: (context) => HomeScreen(),
        DetailsTransaction.idScreen: (context) => DetailsTransaction(),
        UserCode.idScreen: (context) =>UserCode(),
      },
    );
  }
  Future<bool> getUserId() async{
    final _prefs = await SharedPreferences.getInstance();
    final String? userId =  _prefs.getString('userId');
    if(userId !=null){
      return true;
    }

    return false;
  }
}

