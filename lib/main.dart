import 'package:flutter/material.dart';
import 'package:flutter_application_1/modulos/asistencia.dart';
import 'package:flutter_application_1/modulos/cuenta.dart';
import 'package:flutter_application_1/modulos/cursos.dart';
import 'package:flutter_application_1/modulos/historial.dart';
import 'package:flutter_application_1/modulos/historialDetails.dart';
import 'package:flutter_application_1/modulos/noticias.dart';
import 'package:flutter_application_1/modulos/principal.dart';
import 'package:flutter_application_1/modulos/home.dart';


void main() {
  
  runApp(MaterialApp(
    
    
    routes: {
      '/login': (context) => Inicio(),
      '/home': (context) => home(),
      '/cursos': (context) => cursos(),
      '/asistencia': (context) => asistencia(),
      '/noticias': ((context) => noticias()),
      '/cuenta': ((context) => cuenta()),
      '/historial': ((context) => historial()),
      '/historialDetails': ((context) => historialDetails())
    },
    initialRoute: '/login',
  ));
}


