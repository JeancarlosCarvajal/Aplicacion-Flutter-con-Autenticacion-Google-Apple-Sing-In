import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_auth_app/services/google_signin_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('AuthApp - Google - Apple'),
          actions: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.doorOpen),
              onPressed: () async{
                print('jean: SignOut with Google');
                // Singout
                await GoogleSignInService.signOut();
              }, 
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    minWidth: double.infinity,
                    height: 40,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(FontAwesomeIcons.google, color: Colors.white),
                        Text( '   SignIn with Google', style: TextStyle(color: Colors.white, fontSize: 25) )
                      ],
                    ),
                    onPressed: () async {
                      print('jean: SingIn with Google'); 
                      // SignIn with Google
                      await GoogleSignInService.signInWithGooogle();
                      
                    }
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