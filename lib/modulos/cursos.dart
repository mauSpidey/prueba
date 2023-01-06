import 'package:flutter_application_1/modulos/principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class cursos extends StatefulWidget {
  const cursos({super.key});

  @override
  State<cursos> createState() => _cursosState();
}

class _cursosState extends State<cursos> {
  @override
  Widget build(BuildContext context) {
    Future refresh() async {
      bool isConnected = await UserServices().getConnectionCheck();
      if (isConnected) {
        print("Internet");
        String updateCursos =
            await UserServices().getCursosfromInternet(cod_carrera1);
        //List listNoticias = List.from(json.decode(updateNoticias));
        setState(() {
          jsonCursos1 = updateCursos;
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

    return Scaffold(
        appBar: AppBar(title: Text("CURSOS")),
        body: FutureBuilder(
          future: UserServices().getCursosOffline(jsonCursos1),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            color: Colors.lightBlue,
                            width: 350,
                            child: ListTile(
                              title: Text(
                                snapshot.data![i].curso,
                                style: TextStyle(
                                    fontSize: 30, fontStyle: FontStyle.italic),
                              ),
                              subtitle: Text(
                                snapshot.data![i].nombre_profesor +
                                    " " +
                                    snapshot.data![i].apellido_profesor +
                                    "\n" +
                                    snapshot.data![i].correo_profesor,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: snapshot.data!.length,
                  ),
                  onRefresh: refresh);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        /*ListView.builder(
            itemCount: lcursos1.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 100,
                    width: 300,
                    color: Color.fromARGB(255, 61, 201, 201),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        lcursos1[index],
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              );
            }),*/
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
