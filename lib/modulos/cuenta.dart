import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modulos/principal.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cuenta extends StatefulWidget {
  const cuenta({super.key});

  @override
  State<cuenta> createState() => _cuentaState();
}

class _cuentaState extends State<cuenta> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("CUENTA")),
        body: cuerpo7(context),
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

Widget cuerpo7(BuildContext contexto) {
  return ListView(
    children: [
      SizedBox(
        height: 30,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          labelusuario(),
          SizedBox(
            height: 15,
          ),
          labelcorreo(),
          SizedBox(
            height: 15,
          ),
          labeldni(),
          SizedBox(
            height: 400,
          ),
          boton(contexto)
        ],
      )
    ],
  );
}

Widget labelcorreo() {
  return Text(
    "Correo: " + correo1,
    style: TextStyle(fontSize: 25),
  );
}

Widget labeldni() {
  return Text(
    "Dni: " + dni1,
    style: TextStyle(fontSize: 25),
  );
}

Widget labelusuario() {
  return Text(
    "Usuario: " + nombre1 + " " + apellido1,
    style: TextStyle(fontSize: 25),
  );
}

Widget boton(BuildContext contexto) {
  return CupertinoButton(
      color: Colors.blue,
      child: Text("Cerrar Sesion"),
      onPressed: () => {borrar(contexto)});
}

Future<void> borrar(BuildContext contexto) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Navigator.of(contexto).pushReplacementNamed("/login");
}
