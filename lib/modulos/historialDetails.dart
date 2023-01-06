import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/modulos/historial.dart';
import 'package:flutter_application_1/modulos/arguments.dart';
import 'package:flutter_application_1/modulos/principal.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class historialDetails extends StatelessWidget {
  historialDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final sesion =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    print(sesion);
    DateFormat formatter = DateFormat('H:m  dd/mm/y');
    DateTime sesionDate = DateTime.parse(sesion.sesiones[3]);
    String formateado = formatter.format(sesionDate);

    return Scaffold(
      appBar: AppBar(
        title: Text("SESION ${sesion.sesiones[1]}"),
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
            "\nINFORMACIÓN",
            style: TextStyle(fontSize: 35),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            color: Colors.lightBlueAccent,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            width: MediaQuery.of(context).size.width - 10,
            child: Column(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "SESION: ${sesion.sesiones[1]}",
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    "HORA DE REGISTRO: ${formateado}",
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    "TIPO DE SESION: ${sesion.sesiones[2]}",
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40),
                          backgroundColor: Colors.black),
                      child: const Text("REGISTRARME"),
                      onPressed: () async {
                        bool isConnected = false;
                        bool borrarRegistro = false;
                        isConnected = await UserServices().getConnectionCheck();
                        if (isConnected) {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("CONFIRMAR REGISTRO"),
                                  content: const Text(
                                      "Una vez te registres, esta sesion se borrara del historial"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          borrarRegistro = false;
                                        },
                                        child: const Text("NO, VOLVER")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          borrarRegistro = true;
                                        },
                                        child: const Text("ACEPTAR"))
                                  ],
                                );
                              });
                          isConnected =
                              await UserServices().getConnectionCheck();
                          if (borrarRegistro && isConnected) {
                            List list =
                                await UserServices().asistirAndGetStatus(
                              sesion.sesiones[0],
                              sesion.sesiones[1],
                              sesion.sesiones[2],
                              sesion.sesiones[3],
                            );
                            listHistorial.remove(sesion.sesiones);
                            String jsonHistorialafterRemove =
                                json.encode(listHistorial);
                            guardarHistorial(jsonHistorialafterRemove);
                            Navigator.pushReplacementNamed(context, "/home");
                            Navigator.pushNamed(context, "/historial");
                            UserServices().Reporte(
                                list[0]["estadoUsuario"],
                                list[0]["estadoServer"],
                                nombre1,
                                apellido1,
                                dni1,
                                sesion.sesiones[1],
                                context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Row(
                                                children: const [
                                                  Text(
                                                    "SIN INTERNET  ",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Icon(
                                                    Icons.wifi_off,
                                                    size: 35,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          "Todavia no tienes conexion!\nNo te preocupes, intentalo más tarde",
                                          style: TextStyle(fontSize: 20),
                                        )
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("ACEPTAR"))
                                    ],
                                  );
                                });
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "SIN INTERNET  ",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(
                                                  Icons.wifi_off,
                                                  size: 35,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const Text(
                                        "Todavia no tienes conexion!\nNo te preocupes, intentalo más tarde",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("ACEPTAR"))
                                  ],
                                );
                              });
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40),
                          backgroundColor: Colors.black),
                      child: const Text("BORRAR"),
                      onPressed: () async {
                        bool borrar = false;
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Borrar"),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          "¿Estas seguro de que quieres borrar ${sesion.sesiones[1]}?")
                                    ]),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        borrar = false;
                                      },
                                      child: const Text("NO, VOLVER")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        borrar = true;
                                      },
                                      child: const Text("SI"))
                                ],
                              );
                            });

                        if (borrar) {
                          print(borrar);
                          listHistorial.remove(sesion.sesiones);
                          String jsonHistorialafterRemove =
                              json.encode(listHistorial);
                          guardarHistorial(jsonHistorialafterRemove);
                          Navigator.pushNamedAndRemoveUntil(context, "/home",
                              (Route<dynamic> route) => false);
                          Navigator.pushNamed(context, "/historial");
                          Fluttertoast.showToast(
                              msg: "SESION BORRADA",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.amber,
                              textColor: Colors.black,
                              fontSize: 15);
                        }
                      }),
                ],
              )
            ]),
          )
        ],
      )),
    );
  }
}
