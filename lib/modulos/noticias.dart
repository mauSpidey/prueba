import 'package:flutter/material.dart';
import 'package:flutter_application_1/modulos/principal.dart';
import 'package:flutter_application_1/services/noticia.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class noticias extends StatefulWidget {
  const noticias({super.key});

  @override
  State<noticias> createState() => _noticiasState();
}

class _noticiasState extends State<noticias> {
  Future refresh() async {
    bool isConnected = await UserServices().getConnectionCheck();
    if (isConnected) {
      print("Internet");
      String updateNoticias =
          await UserServices().getNoticiasfromInternet(cod_carrera1);
      //List listNoticias = List.from(json.decode(updateNoticias));
      setState(() {
        jsonNoticias1 = updateNoticias;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("NOTICIAS")),
        body: FutureBuilder<List<noticia>>(
          future: UserServices().getNoticiasOffline(jsonNoticias1),
          builder: (context, snap) {
            if (snap.hasData) {
              return RefreshIndicator(
                  child: ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              color: Colors.lightBlue,
                              width: 350,
                              child: ListTile(
                                title: Text(
                                  snap.data![i].titular,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontStyle: FontStyle.italic),
                                ),
                                subtitle: Text(
                                  "\n" +
                                      snap.data![i].contenido +
                                      "\n\n" +
                                      snap.data![i].fecha,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  onRefresh: () async {
                    refresh();
                  });
            }
            if (snap.hasError) {
              return const Center(
                child: Text("Revisa tu conexion"),
              );
            }
            return Center(child: const CircularProgressIndicator());
          },
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

  Widget ejemplo() {
    int a = 2;
    var b;
    if (a == 1) {
      b = Text("Hola");
    } else {
      b = Text("null");
    }
    return b;
  }

  Widget cuerpo6() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[label6(), ejemplo()],
    );
  }

  Widget label6() {
    return Text("AQUI IRAN NOTICIAS");
  }
}
