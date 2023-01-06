import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/cursoBean.dart';
import 'package:flutter_application_1/services/noticia.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  //Atributos a usar durante la clase
  String dni = "";
  String _cursos = "";
  String _nombre = "";
  String _apellido = "";
  String _correo = "";
  String _cod = "";
  String _matricula = "";
  String _noticias = "";
  String _cursosLite = "";
  String _sesiones = "";
  String _historial = "";
  String stringOfJsonCursos = "";
  String stringOfJsonNoticias = "";
  String stringOfJsonCursosLite = "";
  String stringOfJsonSesiones = "";
  String stringOfJsonHistorial = "";

  //Este atributo es para poder usarlo mas adelante en el modulo noticias
  //late Future<List<cursoBean>> lcursobean1;

  @override
  void initState() {
    cargar();
    super.initState();

    //Se cargan los datos de usuario (si es que existen)

    //Es obligatorio inicializarlo
  }

  //--------------------WIDGETS----------------------

  //Widget principal que contiene todo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("INICIAR SESION"),
        ),
        body: Cuerpo(context));
  }

  //Widget que guarda todo en un container

  // ignore: non_constant_identifier_names
  Widget Cuerpo(BuildContext context) {
    return Container(
      //Imagen de fondo que aparece (falta mejorar)

      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://as2.ftcdn.net/v2/jpg/01/62/99/69/1000_F_162996919_PMbfG1X95JoO0vCRKpeGjCrqJKUssuM8.jpg"),
              fit: BoxFit.cover)),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        //Todo el contenido del Widget

        children: <Widget>[
          Label1(),
          const SizedBox(
            height: 15.0,
          ),
          boton(context)
        ],
      )),
    );
  }

  //Widget del boton para escanear

  Widget boton(BuildContext contexto) {
    return CupertinoButton(
        color: Colors.white,
        child: const Text(
          "LOGIN",
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => {
              showDialog(
                  context: contexto,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,

                        //Ventana Modal que aparece dando indicaciones para escanear el dni (falta mejorar la imagen)
                        children: <Widget>[
                          Image.network(
                              "https://img.freepik.com/vector-gratis/ilustracion-tarjeta-identificativa_23-2147823343.jpg"),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                              "Por favor asegurese de Escanear bien su DNI")
                        ],
                      ),
                      actions: <Widget>[
                        //Boton que cierra la ventana modal e inicia el escaner
                        TextButton(
                            onPressed: () =>
                                {Navigator.of(contexto).pop(), _scan(contexto)},
                            child: const Text(
                              "Vale",
                              style: TextStyle(fontSize: 20),
                            ))
                      ],
                    );
                  })
            });
  }

  //Widget que dice Inicia Sesion

  // ignore: non_constant_identifier_names
  Widget Label1() {
    return const Text("INICIA SESIÓN",
        style: TextStyle(
            color: Colors.cyan, fontSize: 25.0, fontWeight: FontWeight.bold));
  }

//Funcion que intentara cargar los datos de los usuarios
  Future<void> cargar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String dni = (await prefs.getString("dni"))!;
    String _cursos = (await prefs.getString("cursos"))!;
    String _nombre = (await prefs.getString("nombre"))!;
    String _apellido = (await prefs.getString("apellido"))!;
    String _correo = (await prefs.getString("correo"))!;
    String _cod = (await prefs.getString("cod_carrera"))!;
    String _matricula = (await prefs.getString("matricula"))!;
    String _noticias = (await prefs.getString("noticias"))!;
    String _cursosLite = (await prefs.getString("cursosNombre"))!;
    String _sesiones = (await prefs.getString("sesiones"))!;
    String _historial = (await prefs.getString("historial"))!;

    if (dni != '') {
      if (dni != null) {
        //Inicializamos una variable que esta fuera de la clase (global)
        dni1 = dni;
      }
    }
    if (_historial != '') {
      if (_historial != null) {
        jsonHistorial1 = _historial;
        listHistorial = UserServices().getHistorial(_historial);
      }
    }
    if (_matricula != '') {
      if (_matricula != null) {
        //Inicializamos una variable que esta fuera de la clase (global)
        matricula1 = _matricula;
      }
    }
    if (_cursosLite != '') {
      if (_cursosLite != null) {
        //Inicializamos una variable que esta fuera de la clase (global)
        jsonCursoLite1 = _cursosLite;
      }
    }
    if (_noticias != '') {
      if (_noticias != null) {
        //Inicializamos una variable que esta fuera de la clase (global)
        jsonNoticias1 = _noticias;
      }
    }
    if (_sesiones != '') {
      if (_sesiones != null) {
        //Inicializamos una variable que esta fuera de la clase (global)
        jsonSesiones1 = _sesiones;
      }
    }
    if (_cursos != '') {
      if (_cursos != null) {
        //Decodificamos el json de la variable se puede imprimir

        jsonCursos1 = _cursos;
      }
    }
    if (_nombre != '') {
      if (_nombre != null) {
        //Inicializamos una variable que esta fuera de la clase (global)

        nombre1 = _nombre;
      }
    }
    if (_apellido != '') {
      if (_apellido != null) {
        //Inicializamos una variable que esta fuera de la clase (global)

        apellido1 = _apellido;
      }
    }
    if (_correo != '') {
      if (_correo != null) {
        //Inicializamos una variable que esta fuera de la clase (global)

        correo1 = _correo;
      }
    }
    if (_cod != '') {
      if (_cod != null) {
        //Inicializamos una variable que esta fuera de la clase (global)

        cod_carrera1 = _cod;
      }
    }
    if (prefs != null) {
      //Inicializamos una variable que esta fuera de la clase (global)

      //lcursobean1 = UserServices().getCursos(_cod);

      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  //Metodo que se ejecutara despues de haber tenido un resultado en el escaner

  Future<String> afterScan(String value, BuildContext contexto) async {
    //Se asigna un valor a la variable declarada dentro de la clase

    dni = value;

    if (dni != '') {
      //Mostrarle al usuario el resultado del escaner

      Fluttertoast.showToast(
          msg: "DETECTADO: $dni",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 15);

      //Almacenar en una variable el json con los datos del usuario, se puede imprimir

      var _userData = await UserServices().getLogin(dni);

      if (_userData != null) {
        nombre1 = _userData["nombre"];
        apellido1 = _userData["apellido"];
        correo1 = _userData["correo"];
        dni1 = _userData["dni"];
        cod_carrera1 = _userData["cod_carrera"];
        matricula1 = _userData["id"];

        stringOfJsonCursos =
            await UserServices().getCursosfromInternet(cod_carrera1);
        jsonCursos1 = stringOfJsonCursos;

        stringOfJsonNoticias =
            await UserServices().getNoticiasfromInternet(cod_carrera1);
        jsonNoticias1 = stringOfJsonNoticias;

        stringOfJsonCursosLite =
            await UserServices().getCursosNombrefromInternet(cod_carrera1);
        jsonCursoLite1 = stringOfJsonCursosLite;

        stringOfJsonSesiones =
            await UserServices().getSesionesfromInternet(dni1);
        jsonSesiones1 = stringOfJsonSesiones;

        stringOfJsonHistorial = "[]";
        guardarHistorial(stringOfJsonHistorial);
        jsonHistorial1 = stringOfJsonHistorial;
        listHistorial = UserServices().getHistorial(stringOfJsonHistorial);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        //Resultado cuando no estas en la base de datos (Se puede custimizar un poco mas creo yo)

        Fluttertoast.showToast(
            msg: "NO ESTAS REGISTRADO",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.amber,
            textColor: Colors.black,
            fontSize: 15);
      }

      //Almacenar en una variable el json con los datos de los cursos del usuario, se pueden imprimir

      //Almacenar en una variable el json con los datos de las noticias del usuario, se pueden imprimir

    }
    //Lanzamos una variable porque sino daba error

    throw "a";
  }

  //Metodo del escaner, retorna un resultado futuro y es usado como parametro en la funcion afterScan

  Future<String> _scan(BuildContext contexto) {
    return FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Cancel",
      true,
      ScanMode.BARCODE,
    ).then((value) => afterScan(value, contexto));
  }
}

//---------Variables que estan fuera de la clase porque es más facil trabajar con ellas al ser publicas----------

String nombre1 = "";
String apellido1 = "";
String correo1 = "";
String dni1 = "";
String cod_carrera1 = "";
String matricula1 = "";
String jsonHistorial1 = "";
String jsonCursoLite1 = "";
String jsonCursos1 = "";
String jsonNoticias1 = "";
String jsonSesiones1 = "";
List<List> listHistorial = [];

//-----------------Metodos fuera de la clase para poder usarlos despues--------------

//Metodo para guardar los datos del usuario en el LocalStorage

Future<void> guardar(String dni3, String nombre2, String apellido2,
    String correo2, String cod_carrera2, String matricula) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dni1 = dni3;
  nombre1 = nombre2;
  apellido1 = apellido2;
  correo1 = correo2;
  cod_carrera1 = cod_carrera2;
  matricula1 = matricula;

  await prefs.setString("dni", dni3);
  await prefs.setString("nombre", nombre2);
  await prefs.setString("apellido", apellido2);
  await prefs.setString("correo", correo2);
  await prefs.setString("cod_carrera", cod_carrera2);
  await prefs.setString("matricula", matricula);
}

//Metodo para guardar los cursos del usuario en el LocalStorage

Future<void> guardarCursos(String jsonCursos) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("cursos", jsonCursos);
  jsonCursos1 = jsonCursos;
}

Future<void> guardarNoticias(String jsonNoticias) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("noticias", jsonNoticias);
  jsonNoticias1 = jsonNoticias;
}

Future<void> guardarCursoNombre(String jsonCursosNombre) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("cursosNombre", jsonCursosNombre);
  jsonCursoLite1 = jsonCursosNombre;
}

Future<void> guardarSesiones(String jsonSesiones) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("sesiones", jsonSesiones);
  jsonSesiones1 = jsonSesiones;
}

Future<void> guardarHistorial(String jsonHistorial) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("historial", jsonHistorial);
  jsonHistorial1 = jsonHistorial;
}
