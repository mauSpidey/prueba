import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/modulos/historialDetails.dart';
import 'package:flutter_application_1/modulos/principal.dart';
import 'package:flutter_application_1/modulos/arguments.dart';
import 'package:flutter_application_1/services/user_services.dart';

class historial extends StatefulWidget {
  const historial({super.key});

  @override
  State<historial> createState() => _historialState();
}

class _historialState extends State<historial> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      listHistorial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HISTORIAL")),
      body: historialscroll(context),
    );
  }

  Widget historialscroll(context) {
    if (listHistorial.length == 0) {
      return Center(child: Text("no data"));
    } else {
      return ListView.builder(
          itemCount: listHistorial.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listHistorial[index][1]),
              subtitle: Text(
                  "TIPO: ${listHistorial[index][2]}\nHORA: ${listHistorial[index][3]}"),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    print(listHistorial[index]);

                    Navigator.pushNamed(context, "/historialDetails",
                        arguments: ScreenArguments(listHistorial[index]));
                  }),
              leading: Icon(Icons.book_rounded),
            );
          });
    }
  }
}
