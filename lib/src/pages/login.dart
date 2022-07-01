import 'package:flutter/material.dart';

import '../style/colors/colorview.dart';

//Login para ingresar correo y contraseña

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          child: IconButton(
            splashRadius: 15,
            icon: const Icon(
              Icons.arrow_back,
              color: ColorSelect.color7,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: ColorSelect.color5,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height - 500,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png')),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    margin: const EdgeInsets.only(right: 210),
                    child: const Text(
                      'Correo electrónico',
                      style: TextStyle(
                          color: ColorSelect.color1,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 12, left: 11),
                    child: TextField(
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 15, color: ColorSelect.color1),
                      decoration: const InputDecoration(
                        fillColor: Colors.amber,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Ingrese su correo electrónico',
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 260, top: 20, bottom: 15),
                    child: const Text(
                      'Contraseña',
                      style: TextStyle(
                          color: ColorSelect.color1,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 12, left: 11),
                    child: TextField(
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 15, color: ColorSelect.color1),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Ingrese su contraseña',
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text(
                        '¿Haz olvidado tu contraseña?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorSelect.color5,
                            fontSize: 16),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 35),
                    child: SizedBox(
                      width: size.width - 50,
                      height: 50,
                      child: ElevatedButton(
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: ColorSelect.color5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("¿Todavía no tienes una cuenta?",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.left),
                        TextButton(
                          child: const Text(
                            'Regístrate',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorSelect.color5,
                                fontSize: 16),
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
