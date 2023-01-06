import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modulos/principal.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatelessWidget {
  const home({super.key});
  Future refresh() async {
    bool isConnected = await UserServices().getConnectionCheck();
    if (isConnected) {
      UserServices().refreshUser(matricula1);
    } else {
      print("SIN INTERNET");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("BIENVENIDO")),
        body: RefreshIndicator(
            child: ListView(children: [Cuerpo3(context)]), onRefresh: refresh),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  accountName: Text(nombre1),
                  accountEmail: Text(correo1)),
              ListTile(
                  title: Text("INICIO"),
                  leading: Icon(Icons.home),
                  onTap: (() {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/home');
                  })),
              ListTile(
                  title: Text("CURSOS"),
                  leading: Icon(Icons.book),
                  onTap: (() {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, "/cursos");
                  })),
              ListTile(
                title: Text("ASISTENCIA"),
                leading: Icon(Icons.list),
                onTap: (() {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, "/asistencia");
                }),
              ),
              ListTile(
                title: Text("NOTICIAS"),
                leading: Icon(Icons.newspaper),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, "/noticias");
                },
              ),
              ListTile(
                title: Text("CUENTA"),
                leading: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, "/cuenta");
                },
              )
            ],
          ),
        ));
  }
}

Widget Cuerpo3(BuildContext contexto) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      LabelWelcome(),
      SizedBox(
        height: 100,
      ),
      LabelMsg(),
      SizedBox(
        height: 100,
      ),
      botonHistorial(contexto)
    ],
  );
}

Widget LabelWelcome() {
  return Text(
    "Bienvenido de nuevo, " + nombre1,
    style: TextStyle(
        fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
  );
}

Widget LabelMsg() {
  return Text(
    "Esta es una aplicacion de gestion de Asistencias!",
    style: TextStyle(fontSize: 20, color: Colors.grey),
  );
}

Widget botonHistorial(BuildContext context) {
  return CupertinoButton(
      color: Colors.lightBlueAccent,
      child: const Text("SESIONES GUARDADAS",
          style: TextStyle(color: Colors.black)),
      onPressed: () {
        Navigator.pushNamed(context, "/historial");
      });
}
