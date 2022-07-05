import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/homepage.dart';
import 'package:vacoro_proyect/src/services/authFacebook.dart';
import 'package:vacoro_proyect/src/services/authGoogle.dart';

class autenticacion extends StatefulWidget {
  const autenticacion({Key? key}) : super(key: key);

  @override
  State<autenticacion> createState() => _autenticacion();
}

class _autenticacion extends State<autenticacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:(
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                TextButton(
                  child: Text('Facebook Inicio Sesion'),
                  onPressed: () {
                    String user;
                    try {
                      signInWithFacebook().then((value) =>{
                        user = value.user!.displayName!,
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage(nombre: user)));
                      }
                        // ignore: avoid_print
                      );
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                  }
                ),
                TextButton(
                  child: Text('Google Inicio Sesion'),
                  onPressed: () {
                    String user;
                    try {
                      signInWithGoogle().then((value) =>{
                        user = value.user!.displayName!,
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage(nombre: user)));
                      }
                        // ignore: avoid_print
                      );
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                  }
                )
              ],
            ),
          )
        )
      )
    );
  }
}
