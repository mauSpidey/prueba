import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modulos/principal.dart';
import 'package:flutter_application_1/services/cursoBean.dart';
import 'package:flutter_application_1/services/noticia.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String error_mensaje = "";

class UserServices {
  Future getLogin(String dni) async {
    try {
      var url =
          Uri.parse('https://proyecto--asistencia.000webhostapp.com/index.php');
      var response = await http.post(url, body: {
        'dni': dni,
      });
      print('Estado: ${response.statusCode}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String _dni = data["dni"];
        String _nombre = data["nombre"];
        String _apellido = data["apellido"];
        String _correo = data["correo"];
        String _cod = data["cod_carrera"];
        String _matricula = data["id"];
        print(data);
        guardar(_dni, _nombre, _apellido, _correo, _cod, _matricula);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future refreshUser(String id) async {
    final url = Uri.parse(
        "https://proyecto--asistencia.000webhostapp.com/refreshUser.php");
    final response = await http.post(url, body: {
      'id': id,
    });
    print('Estado: ${response.statusCode}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String _dni = data["dni"];
      String _nombre = data["nombre"];
      String _apellido = data["apellido"];
      String _correo = data["correo"];
      String _cod = data["cod_carrera"];
      String _matricula = data["id"];
      dni1 = data["dni"];
      nombre1 = data["nombre"];
      apellido1 = data["apellido"];
      correo1 = data["correo"];
      cod_carrera1 = data["cod_carrera"];
      matricula1 = data["id"];
      print(data);
      guardar(_dni, _nombre, _apellido, _correo, _cod, _matricula);
      return data;
    } else {
      return null;
    }
  }

  Future getCursosNombrefromInternet(String cod) async {
    String data = "";
    var url = Uri.parse(
        'https://proyecto--asistencia.000webhostapp.com/cursosAsistencia.php');
    var response = await http.post(url, body: {
      'cod': cod,
    });
    print('Estado: ${response.statusCode}');

    if (response.statusCode == 200) {
      data = response.body;
      guardarCursoNombre(data);
    }
    return data;
  }

  List getCursosNombreOffline(String jsonCursos) {
    final data = List.from(json.decode(jsonCursos));
    List cursos = [];
    data.forEach((element) {
      cursos.add(element);
    });
    return cursos;
  }

  Future<String> getCursosfromInternet(String cod) async {
    String data = "";
    var url =
        Uri.parse('https://proyecto--asistencia.000webhostapp.com/cursos.php');
    var response = await http.post(url, body: {
      'cod': cod,
    });
    print('Estado: ${response.statusCode}');

    if (response.statusCode == 200) {
      data = response.body;
      guardarCursos(data);
      /*
      final data = List.from(json.decode(response.body))
      return data;
      
      data.forEach((element) {
        final cursoBean curso = cursoBean.fromJson(element);

        lcurBean.add(curso);
      });
      */

      //guardarCursos(lcurBean); //creo que no le tendre que pasar eso

    }
    return data;
  }

  Future<List<cursoBean>> getCursosOffline(String stringList) async {
    final data = List.from(json.decode(stringList));
    List<cursoBean> lcurBean = [];
    data.forEach((element) {
      final cursoBean curso = cursoBean.fromJson(element);

      lcurBean.add(curso);
    });
    return lcurBean;
  }

  Future<String> getNoticiasfromInternet(String codigo) async {
    String data = "";

    final url = Uri.parse(
        "https://proyecto--asistencia.000webhostapp.com/noticias.php");
    final response = await http.post(url, body: {
      'carrera': codigo,
    });
    print('Estado: ${response.statusCode}');
    if (response.statusCode == 200) {
      data = response.body;
      guardarNoticias(data);
    }
    return data;
  }

  Future<List<noticia>> getNoticiasOffline(String stringList) async {
    List<noticia> lnoti = [];

    final list = List.from(json.decode(stringList));

    list.forEach((element) {
      final noticia not = noticia.fromJson(element);

      lnoti.add(not);
    });

    return lnoti;
  }

  Future getSesionesfromInternet(String dni) async {
    final url = Uri.parse(
        "https://proyecto--asistencia.000webhostapp.com/sesiones.php");
    final response = await http.post(url, body: {
      'dni': dni,
    });
    print('Estado: ${response.statusCode}');
    if (response.statusCode == 200) {
      String data = response.body;
      guardarSesiones(data);
      return data;
    }
  }

  List getSesionesOffline(String jsonSesiones, String sesion) {
    List filter2 = [];
    final list = List.from(json.decode(jsonSesiones));
    final list_filter1 =
        list.where((element) => element["curso"] == sesion).toList();
    list_filter1.forEach((element) {
      filter2.add(element["nombre"]);
    });
    return filter2;
  }

  Future getEoS() async {
    List e_s = ["ENTRADA", "SALIDA"];
    return e_s;
  }

  Future getHora(String ES, String nombre) async {
    final url =
        Uri.parse("https://proyecto--asistencia.000webhostapp.com/hora.php");
    final response = await http.post(url, body: {
      'nombre': nombre,
      'es': ES,
    });
    print('Estado: ${response.statusCode}');
    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      return list;
    }
  }

  List<List> getHistorial(String jsonHistorial) {
    final list = List.from(json.decode(jsonHistorial));
    List<List> historial = [];
    list.forEach((element) {
      historial.add(element);
    });
    return historial;
  }

  Future getConnectionCheck() async {
    bool estado = false;
    try {
      final url = Uri.parse(
          "https://proyecto--asistencia.000webhostapp.com/checkInternet.php");
      final response = (await http.post(url));
      estado = true;
      return estado;
    } catch (e) {
      print("Error");
      return estado;
    } finally {
      return estado;
    }
  }

  Future<List> asistirAndGetStatus(
      String matricula, String sesion, String e_s, String hora) async {
    final url = Uri.parse(
        "https://proyecto--asistencia.000webhostapp.com/checkEstadoAsistir.php");
    final response = await http.post(url, body: {
      'matricula': matricula,
      'sesion': sesion,
      'es': e_s,
      'hora': hora,
    });
    List list = List.from(json.decode(response.body));
    print('Estado: ${response.statusCode}');

    if (response.statusCode == 200) {
      /*
      Fluttertoast.showToast(
          msg: error_mensaje,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 15);*/
    }
    return list;
  }

  void Reporte(String response1, String response2, String nombre,
      String apellido, String dni, String sesion, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "REPORTE",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "NOMBRE USUARIO: ${nombre} ${apellido}",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "DNI USUARIO: ${dni}",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "SESION: ${sesion}",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "ESTADO USUARIO: ${response1}",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "ESTADO SERVIDOR: ${response2}",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("CERRAR"))
            ],
          );
        });
  }
}
