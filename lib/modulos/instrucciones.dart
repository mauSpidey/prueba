import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modulos/home.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class instrucciones extends StatelessWidget {
  const instrucciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INSTRUCCIONES"),
      ),
      body: Cuerpo2(context),
    );
  }
}

Widget Cuerpo2(BuildContext contexto) {
  return Column(
    children: [
      Image(
        image: NetworkImage(
            "https://img.freepik.com/vector-gratis/ilustracion-tarjeta-identificativa_23-2147823343.jpg"),
        width: 150.0,
        height: 150.0,
      ),
      Label2(),
      SizedBox(
        height: 15.0,
      ),
      LabelResult(),
      SizedBox(
        height: 15.0,
      ),
      boton2(contexto)
    ],
  );
}

Widget Label2() {
  return Text(
    "Por favor asegurese de escanear correctamente el codigo de barras de su DNI",
    textAlign: TextAlign.center,
  );
}

Widget LabelResult() {
  return Text(dni);
}

String dni = "";
Widget boton2(BuildContext contexto) {
  return CupertinoButton(
      color: Colors.black,
      child: Text(
        "ESCANEAR",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => {_scan(contexto)});
}

Future<String> _scan(BuildContext contexto) async {
  return FlutterBarcodeScanner.scanBarcode(
    "#000000",
    "Cancel",
    true,
    ScanMode.BARCODE,
  ).then((value) => metodo(value, contexto));
}

Future<String> metodo(String value, BuildContext contexto) {
  dni = value;
  if (dni == '76010300') {
    Fluttertoast.showToast(
        msg: "DETECTADO",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.amber,
        textColor: Colors.black,
        fontSize: 15);
    saveData(dni);
    Navigator.pushNamed(contexto, "home");
  } else {
    Fluttertoast.showToast(
        msg: "NO DETECTADO",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.amber,
        textColor: Colors.black,
        fontSize: 15);
  }
  throw "a";
}

Future<void> saveData(String dni2) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("dni", dni2);
}
