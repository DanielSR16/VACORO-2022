import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

Drawer drawer(nombre, correo, imageUsuario) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
            color: ColorSelect.color5,
          ),
          accountName: RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.person,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: "Nombre " + nombre,
                ),
              ],
            ),
          ),
          accountEmail: RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.email,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: " Correo electrónico " + correo,
                ),
              ],
            ),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(imageUsuario),
            //backgroundImage: AssetImage('assets/images/image.png'),
          ),
        ),
        ListTile(
          title: const Text('Ver vacas'),
          onTap: () {},
          leading: const Image(
            image: AssetImage('assets/images/vaca.png'),
            width: 30,
          ),
        ),
        ListTile(
          title: const Text('Ver toros'),
          onTap: () {},
          leading: const Image(
            image: AssetImage('assets/images/toro.png'),
            width: 30,
          ),
        ),
        ListTile(
          title: const Text('Ver becerros'),
          onTap: () {},
          leading: const Image(
            image: AssetImage('assets/images/becerro.png'),
            width: 30,
          ),
        ),
        ListTile(
          title: const Text('Agregar medicamentos'),
          onTap: () {},
          leading: const Image(
            image: AssetImage('assets/images/Icon_syringe.png'),
            width: 40,
          ),
        ),
        ListTile(
          title: const Text('Agregar categorias'),
          onTap: () {},
          leading: const Image(
            image: AssetImage('assets/images/Icon_Carpeta.png'),
            width: 27,
          ),
        ),
        ListTile(
          title: const Text('Generar reporte'),
          onTap: () {},
          leading: const Image(
            image: AssetImage('assets/images/Icon_Report.png'),
            width: 30,
          ),
        ),
        const Divider(
          height: 5,
          thickness: 2,
          color: ColorSelect.color1,
        ),
        ListTile(
          title: const Text('Editar perfil'),
          onTap: () {},
          leading: const Image(
            image: AssetImage('assets/images/Icon_settings.png'),
            width: 35,
          ),
        ),
        ListTile(
          title: const Text('Ver anuncio'),
          onTap: () {},
          leading: const Image(
            image: AssetImage('assets/images/Icon_anuncio.png'),
            width: 30,
          ),
        ),
        ListTile(
          title: const Text('Cerrar sesión'),
          onTap: () {},
          leading: const Image(
            image: AssetImage('assets/images/Icon_salida.png'),
            width: 25,
          ),
        ),
      ],
    ),
  );
}
