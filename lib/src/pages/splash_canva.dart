import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/pre_login.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class SplashCanva extends StatefulWidget {
  SplashCanva({Key? key}) : super(key: key);

  @override
  State<SplashCanva> createState() => _SplashCanvaState();
}

class _SplashCanvaState extends State<SplashCanva> {
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
      body: SafeArea(
        child: _stackSplash(size),
      ),
    );
  }

  Stack _stackSplash(Size size) {
    return Stack(
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/image.png',
            repeat: ImageRepeat.repeatX,
            fit: BoxFit.contain,
          ),
          Container(
            padding: EdgeInsets.only(bottom: size.height * 0.0001),
            child: CustomPaint(
              painter: _SplashCanvasTop(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.77),
            // height: size.height * 0.2,
            child: CustomPaint(
              painter: _SplashCanvasBottom(),
            ),
          )
        ]);
  }

  _SplashChange() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => preLogin())); //Aqui agregan la vista de login
  }
}

class _SplashCanvasTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = const Color(0xff68C34E);
    paint.style = PaintingStyle.fill;

    paint.strokeWidth = 5;

    final path = Path();

    path.lineTo(0, size.height * 0.10);

    path.quadraticBezierTo(size.width * 0.17, size.height * 0.20,
        size.width * 0.35, size.height * 0.12);

    path.quadraticBezierTo(size.width * 0.45, size.height * 0.07,
        size.width * 0.57, size.height * 0.11);

    path.quadraticBezierTo(
        size.width * 0.91, size.height * 0.17, size.width, size.height * 0.11);

    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SplashCanvasTop oldDelegate) => true;
}

class _SplashCanvasBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint2 = Paint();
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );
    const textSpan =
        TextSpan(text: "BIENVENIDOS A SU APLICACIÓN VACORO.", style: textStyle);

    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start);
    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final x = (size.width) * 0.1;
    final y = (size.height - textPainter.height) * 0.8;

    final offset = Offset(x, y);

    paint2.color = const Color(0xff68C34E);

    paint2.style = PaintingStyle.fill;

    paint2.strokeWidth = 5;

    final path2 = Path();

    paint2.color = const Color(0xff68C34E);
    paint2.style = PaintingStyle.fill;
    paint2.strokeWidth = 1;

    path2.moveTo(0, size.height);
    path2.lineTo(0, size.height * 0.0980000);
    path2.quadraticBezierTo(size.width * 0.0483500, size.height * 0.0005000,
        size.width * 0.1996000, 0);
    path2.cubicTo(
        size.width * 0.3509000,
        size.height * -0.0038000,
        size.width * 0.4223000,
        size.height * 0.2590000,
        size.width * 0.5008000,
        size.height * 0.2664000);
    path2.cubicTo(
        size.width * 0.5862000,
        size.height * 0.2692000,
        size.width * 0.6562000,
        size.height * -0.0116000,
        size.width * 0.8016000,
        0);
    path2.quadraticBezierTo(size.width * 0.9522000, size.height * -0.0142000,
        size.width, size.height * 0.0368000);
    path2.lineTo(size.width, size.height);

    canvas.drawPath(path2, paint2);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_SplashCanvasBottom oldDelegate) => true;
}
