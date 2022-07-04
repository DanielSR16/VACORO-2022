import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/splash_canva.dart';
// import 'package:vacoro_proyect/src/pages/splash_canva.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _SplashChange();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff68C34E),
      body: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Center(
            child: Container(
              // width: size.width / 2,
              // height: size.height / 2,
              margin: const EdgeInsets.only(top: 0),
              child: const Image(
                image: AssetImage('assets/images/logoVacoro.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _SplashChange() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SplashCanva()));
  }
}
