import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modulos/principal.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'dart:convert';

class asistencia extends StatefulWidget {
  const asistencia({super.key});

  @override
  State<asistencia> createState() => _asistenciaState();
}

class _asistenciaState extends State<asistencia> {
  double latitudG = 0;
  double longitudG = 0;
  String rango = "NO";

  @override
  Widget build(BuildContext context) {
    Future refresh() async {
      bool isConnected = await UserServices().getConnectionCheck();
      if (isConnected) {
        print("Internet");
        String updateCursos =
            await UserServices().getCursosNombrefromInternet(cod_carrera1);
        //List listNoticias = List.from(json.decode(updateNoticias));
        String updateSesiones =
            await UserServices().getSesionesfromInternet(dni1);
        setState(() {
          jsonCursoLite1 = updateCursos;
          jsonSesiones1 = updateSesiones;
          sesiones =
              UserServices().getSesionesOffline(updateSesiones, valueSelect);
          /*
          valueSelect = "Seleccionar";
          sesiones = [];
          */
        });
        Fluttertoast.showToast(
            msg: "ACTUALIZADO",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.amber,
            textColor: Colors.black,
            fontSize: 15);
      } else {
        Fluttertoast.showToast(
            msg: "NO TIENES INTERNET",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.amber,
            textColor: Colors.black,
            fontSize: 15);
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text("ASISTENCIAS")),
        body: RefreshIndicator(
          child: ListView(children: [Cuerpo5()]),
          onRefresh: refresh,
        ),
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

  Future<Position> getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    latitudG = position.latitude;
    longitudG = position.longitude;
    return position;
  }

  void checkGPS(double lat, double lon) async {
    //Position pos = await getLocation();
    const double errorLat = 0.00001841075145590610;
    const double errorLon = 0.00003330947955916131;

    const double radio = 0.00012; //12 metros

    const double latPromedio = -17.652569472;
    const double lonPromedio = -71.342031668;

    const double margenLat = errorLat + radio;
    const double margenLon = errorLon + radio;

    double diferenciaLat = (lat - latPromedio).abs();
    double diferenciaLon = (lon - lonPromedio).abs();
    //print("Margen para Latitud:$margenLat\nMargen para Longitud:$margenLon");
    /*Fluttertoast.showToast(
        msg: "Dif Lat:$diferenciaLat\nDif Lon:$diferenciaLon",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.amber,
        textColor: Colors.black,
        fontSize: 15);
*/
    if (diferenciaLat <= margenLat) {
      if (diferenciaLon <= margenLon) {
        setState(() {
          rango = "SI";
        });
      } else {
        setState(() {
          rango = "NO";
        });
      }
    } else {
      setState(() {
        rango = "NO";
      });
    }
    /*
    double latitud = pos.latitude;
    double longitud = pos.longitude;
    */

    //var difflat = (latcasa - latitud).abs();
    //var difflon = (loncasa - longitud).abs();
    /*
    if (lat < 0) {
      if (lat < 0) {
        //Lat negativo y long negativo

        if (lat <= latcasa1 && lat >= latcasa2) {
          if (lon <= loncasa1 && lon >= loncasa2) {
            setState(() {
              rango = " SI";
            });
          } else {
            setState(() {
              rango = "NO";
            });
          }
        } else {
          setState(() {
            rango = "NO";
          });
        }
      } else {
        //Lat negativo y long positivo
        if (lat <= latcasa1 && lat >= latcasa2) {
          if (lon >= loncasa1 && lon <= loncasa2) {
            print("ESTAS EN CASA!");
          }
        }
      }
    } else {
      if (lon < 0) {
        //Lat positivo y long negativo
        if (lat >= latcasa1 && lat <= latcasa2) {
          if (lon <= loncasa1 && lon >= loncasa2) {
            print("ESTAS EN CASA!");
          }
        }
      } else {
        //Lat positivo y long positivo
        if (lat >= latcasa1 && lat <= latcasa2) {
          if (lon >= loncasa1 && lon <= loncasa2) {
            print("ESTAS EN CASA!");
          }
        }
      }
    }
    */

    //print("Diferencia en latitudes: $difflat \nDiferencia en longitudes: $difflon");
  }

  Widget Cuerpo5() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        comboBox(),
        SizedBox(
          height: 50,
        ),
        comboBox2(),
        SizedBox(
          height: 50,
        ),
        comboBox3(),
        SizedBox(
          height: 50,
        ),
        botonR(context),
        SizedBox(
          height: 50,
        ),
        boton(),
        SizedBox(
          height: 50,
        ),
        coords()
      ],
    );
  }

  Widget boton() {
    return CupertinoButton(
        child:
            Text("OBTENER COORDENADAS", style: TextStyle(color: Colors.black)),
        color: Colors.cyanAccent,
        onPressed: () async {
          Position pos = await getLocation();

          checkGPS(pos.latitude, pos.longitude);
        });
  }

  String valueSelect = "Seleccionar";
  String valueSelectB = "No hay Sesiones";
  String valueSelectC = "Seleccionar";
  List sesiones = [];
  List entOsal = [];
  List hora = [];
  String estado = "";
  List cursosa = UserServices().getCursosNombreOffline(jsonCursoLite1);

  Widget comboBox() {
    print("JSON: " + jsonCursoLite1);
    return DropdownButton(
      hint: Text(valueSelect),
      items: cursosa
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: (value) async {
        sesiones = [];
        entOsal = [];
        valueSelect = value.toString();
        sesiones =
            UserServices().getSesionesOffline(jsonSesiones1, valueSelect);

        print("=======${sesiones}");
        print(sesiones);
        print(value);
        if (sesiones.length == 0) {
          valueSelectB = "No hay Sesiones";
        } else {
          valueSelectB = "Seleccionar";
          if (valueSelectB != "Seleccionar" ||
              valueSelectB != "No hay Sesiones") {
            valueSelectC = "Seleccionar";
          } else {
            valueSelectC = "Seleccionar";
          }
        }
        setState(() {
          comboBox();
          comboBox2();
          comboBox3();
        });
      },
    );
  }

  Widget comboBox2() {
    return DropdownButton(
      hint: Text(valueSelectB),
      items: sesiones
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: (value) async {
        valueSelectB = value.toString();
        if (valueSelectB != "Seleccionar" && valueSelectB != "No hay datos") {
          entOsal = await UserServices().getEoS();
        }
        setState(() {
          comboBox2();
          comboBox3();
        });
        print(value);
      },
    );
  }

  Widget comboBox3() {
    return DropdownButton(
      hint: Text(valueSelectC),
      items: entOsal
          .map((e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ))
          .toList(),
      onChanged: (value) async {
        valueSelectC = value.toString();

        setState(() {
          comboBox3();
        });
      },
    );
  }

  late List datos;

  Widget botonR(BuildContext contexto) {
    return CupertinoButton(
        color: Colors.cyanAccent,
        child: Text("ASISTIR", style: TextStyle(color: Colors.black)),
        onPressed: () {
          print(valueSelectB);

          if (valueSelectB != "Seleccionar" &&
              valueSelectB != "No hay Sesiones" &&
              valueSelectB != "" &&
              valueSelectC != "Seleccionar") {
            showDialog(
                context: contexto,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,

                      //Ventana Modal que aparece dando indicaciones para escanear el dni (falta mejorar la imagen)
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "$valueSelectB",
                                style: const TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    isConnected = await UserServices()
                                        .getConnectionCheck();
                                    if (isConnected) {
                                      hora = await UserServices()
                                          .getHora(valueSelectC, valueSelectB);
                                      DateTime sessiondate =
                                          DateTime.parse(hora[0]);

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Fecha Esperada: " +
                                                          hora[0] +
                                                          "\n",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    TimerBuilder.periodic(
                                                      Duration(seconds: 1),
                                                      builder: (context) {
                                                        var currentTime =
                                                            DateTime.now();
                                                        String seconds = currentTime
                                                                    .second <
                                                                10
                                                            ? "0${currentTime.second}"
                                                            : "${currentTime.second}";
                                                        String minutes = currentTime
                                                                    .minute <
                                                                10
                                                            ? "0${currentTime.minute}"
                                                            : "${currentTime.minute}";
                                                        String hour = currentTime
                                                                    .hour <
                                                                10
                                                            ? "0${currentTime.hour}"
                                                            : "${currentTime.hour}";
                                                        String day = currentTime
                                                                    .day <
                                                                10
                                                            ? "0${currentTime.day}"
                                                            : "${currentTime.day}";
                                                        String month = currentTime
                                                                    .month <
                                                                10
                                                            ? "0${currentTime.month}"
                                                            : "${currentTime.month}";
                                                        String year = currentTime
                                                                    .year <
                                                                10
                                                            ? "0${currentTime.year}"
                                                            : "${currentTime.year}";
                                                        DateTime now =
                                                            DateTime.parse(
                                                                "$year-$month-$day $hour:$minutes:$seconds");
                                                        if (now.isBefore(
                                                            sessiondate)) {
                                                          estado = "TEMPRANO";
                                                        } else {
                                                          estado = "TARDE";
                                                        }
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Hora Actual: $year-$month-$day $hour:$minutes:$seconds\n",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                            Text(
                                                              "Estado: " +
                                                                  estado +
                                                                  "\n",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ]),
                                              actions: [
                                                Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              contexto);
                                                        },
                                                        child: const Text(
                                                            "CERRAR"))
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "SIN INTERNET!",
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      const Icon(
                                                          Icons.wifi_off),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  const Text(
                                                    "Necesitas de Internet para acceder a los datos de esta sesión",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "CERRAR"))
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                      print("========CONEXION=$isConnected");
                                    }
                                  },
                                  icon: const Icon(Icons.info)),
                            ]),
                        const Text(
                          "\nQue deseas hacer?",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        /*
                        TimerBuilder.periodic(
                          Duration(seconds: 5),
                          builder: (context) {
                            getLocation();
                            checkGPS(latitudG, longitudG);
                            /*print(
                                    "LATITUD: $latitudG\tLONGITUD: $longitudG");*/

                            return Text(
                                "Latitud:$latitudG\nLongitud:$longitudG\nDentro del rango:$rango");
                          },
                        )*/
                      ],
                    ),
                    actions: <Widget>[
                      //Boton que cierra la ventana modal
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(contexto);
                              },
                              child: const Text("CERRAR")),
                          SizedBox(
                            width: 30,
                          ),
                          TextButton(
                              onPressed: () async {
                                bool gpsBool =
                                    await Geolocator.isLocationServiceEnabled();
                                print("GPS: $gpsBool");
                                if (gpsBool) {
                                  getLocation();
                                  checkGPS(latitudG, longitudG);
                                  if (rango == "SI") {
                                    print("LATITUD: $latitudG");
                                    print("LONGITUD: $longitudG");
                                    Fluttertoast.showToast(
                                        msg: "ESTAS DENTRO DEL AREA",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.amber,
                                        textColor: Colors.black,
                                        fontSize: 15);
                                  } else {
                                    print("LATITUD: $latitudG");
                                    print("LONGITUD: $longitudG");
                                    if (latitudG == 0 && longitudG == 0) {
                                      Fluttertoast.showToast(
                                          msg: "CALIBRANDO...",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.amber,
                                          textColor: Colors.black,
                                          fontSize: 15);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "NO ESTAS DENTRO DEL AREA",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.amber,
                                          textColor: Colors.black,
                                          fontSize: 15);
                                    }
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "POR FAVOR ACTIVA TU GPS",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.amber,
                                      textColor: Colors.black,
                                      fontSize: 15);
                                  getLocation();
                                }
                                /*
                                getLocation();
                                checkGPS(latitudG, longitudG);
                                if (rango == "SI") {
                                  Fluttertoast.showToast(
                                      msg: "HABILITADO",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.amber,
                                      textColor: Colors.black,
                                      fontSize: 15);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "NO HABILITADO",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.amber,
                                      textColor: Colors.black,
                                      fontSize: 15);
                                }
                                */
                              },
                              child: const Text("CHECK GPS")),
                          TextButton(
                              onPressed: () async {
                                DateTime now = DateTime.now();
                                DateFormat formatter =
                                    DateFormat('yyyy-MM-dd hh:mm');
                                String formateado = formatter.format(now);
                                datos = [
                                  matricula1,
                                  valueSelectB,
                                  valueSelectC,
                                  formateado
                                ];
                                print(datos);
                                bool gpsBool =
                                    await Geolocator.isLocationServiceEnabled();
                                if (gpsBool) {
                                  getLocation();
                                  checkGPS(latitudG, longitudG);

                                  if (rango == "SI") {
                                    isConnected = await UserServices()
                                        .getConnectionCheck();
                                    if (isConnected) {
                                      List list = await UserServices()
                                          .asistirAndGetStatus(datos[0],
                                              datos[1], datos[2], datos[3]);
                                      UserServices().Reporte(
                                          list[0]["estadoUsuario"],
                                          list[0]["estadoServer"],
                                          nombre1,
                                          apellido1,
                                          dni1,
                                          valueSelectB,
                                          context);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "SIN INTERNET!",
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        const Icon(
                                                            Icons.wifi_off)
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Text(
                                                      "Lo sentimos $nombre1, detectamos que no tienes conexion, pero no te preocupes, podemos guardar los datos y que lo puedas introducir cuando tengas conexion!",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )
                                                  ]),
                                              actions: [
                                                Row(children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                          "NO, GRACIAS")),
                                                  TextButton(
                                                      onPressed: () {
                                                        listHistorial
                                                            .add(datos);
                                                        jsonHistorial1 =
                                                            json.encode(
                                                                listHistorial);
                                                        guardarHistorial(
                                                            jsonHistorial1);
                                                        Navigator.pop(context);
                                                        Fluttertoast.showToast(
                                                            msg: "GUARDADO",
                                                            toastLength: Toast
                                                                .LENGTH_LONG,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                2,
                                                            backgroundColor:
                                                                Colors.amber,
                                                            textColor:
                                                                Colors.black,
                                                            fontSize: 15);
                                                      },
                                                      child: const Text(
                                                          "GUARDAR DATOS"))
                                                ])
                                              ],
                                            );
                                          });
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "CHECK GPS",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.amber,
                                        textColor: Colors.black,
                                        fontSize: 15);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "CHECK GPS",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.amber,
                                      textColor: Colors.black,
                                      fontSize: 15);
                                }
                              },
                              child: const Text(
                                "ASISTIR",
                              )),
                        ],
                      )
                    ],
                  );
                });
          } else {
            Fluttertoast.showToast(
                msg: "Selecciona los campos",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.amber,
                textColor: Colors.black,
                fontSize: 15);
          }
        });
  }

  bool isConnected = false;
  /*
  checkConnection() async {
    var connection = await Connectivity().checkConnectivity();

    if (connection == ConnectivityResult.vpn) {
      print("DESACTIVA LA VPN");

      print("========CONEXION VPN =$isConnected");
    }



    if (connection != ConnectivityResult.none) {
      isConnected = await InternetConnectionChecker().hasConnection;
      print("========CONEXION A RED =$isConnected");
    } else {
      isConnected = false;
      print("========CONEXION A UNA RED =$isConnected");
    }
    
  }
  */
  Future<Widget> coords2() async {
    Position pos = await getLocation();
    double lat = pos.latitude;
    double lon = pos.longitude;
    return Text("data");
  }

  Widget coords() {
    return Text(
      "Latitud Actual: $latitudG\n\nLongitud Actual: $longitudG\n\nDentro del rango:$rango",
      style: TextStyle(fontSize: 30),
    );
  }
}
