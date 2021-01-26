import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/pages/admin.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateLocal extends StatelessWidget {
  final TextEditingController nombreC = TextEditingController();
  final TextEditingController tiempoAtencionC = TextEditingController();
  final TextEditingController direccionC = TextEditingController();
  final TextEditingController tipoC = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
        appBar: AppBar(title: Text("Registrar Local")),
        drawer: MenuLateral(),
        body: ListView(
          children: [
            SizedBox(height: 15),
            Center(
              child: Container(
                width: 300,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/store.png',
                        height: 150,
                      ),
                      Text(""),
                      TextFormField(
                        controller: nombreC,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Nombre del Local';
                          }
                        },
                        decoration:
                            InputDecoration(labelText: 'Nombre del Local'),
                      ),
                      TextFormField(
                        controller: tiempoAtencionC,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Ingrese horario';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Tiempo de Atención Aprox (min)'),
                      ),
                      TextFormField(
                        controller: tipoC,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Nombre del Local';
                          }
                        },
                        decoration: InputDecoration(labelText: 'Tipo'),
                      ),
                      TextFormField(
                        controller: direccionC,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Nombre del Local';
                          }
                        },
                        decoration: InputDecoration(labelText: 'Dirección'),
                      ),
                      Text("\n\n"),
                      RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            addLocal(
                                nombreC.text.trim(),
                                int.parse(tiempoAtencionC.text),
                                firebaseUser.uid,
                                direccionC.text.trim(),
                                tipoC.text.trim());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Registrar Local',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

addLocal(String nombre, int tiempoAtencion, String uid, String direccion,
    String tipo) {
  Map<String, dynamic> demoData = {
    "nombre": "$nombre",
    "tiempoAtencion": tiempoAtencion,
    "uid": "$uid",
    "tipo": "$tipo",
    "estado": true,
    "direccion": "$direccion"
  };

  CollectionReference cr = FirebaseFirestore.instance.collection('locales');
  cr.add(demoData);
}
