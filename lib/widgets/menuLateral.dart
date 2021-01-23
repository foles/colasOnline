import 'dart:collection';

import 'package:colasOnline/main.dart';
import 'package:colasOnline/pages/admin.dart';
import 'package:colasOnline/pages/locales.dart';
import 'package:colasOnline/pages/signIn.dart';
import 'package:colasOnline/pages/queue.dart';

import 'package:colasOnline/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("Bienvenido"),
            accountEmail: firebaseUser.email.isNotEmpty
                ? Text(firebaseUser.email)
                : Text(""),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://www.semana.com/resizer/In6yhH79C3gJctAGnf3xwFgHRkE=/1200x675/filters:format(jpg):quality(70)//cloudfront-us-east-1.images.arcpublishing.com/semana/UTNPBRA4XFHNVLFP4DQE5GVT4A.jpg"),
                    fit: BoxFit.cover)),
          ),
          new ListTile(
            selectedTileColor: Colors.black,
            title: Text("LOCALES"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocalesPage(),
                ),
              );
            },
          ),
          new ListTile(
            title: Text("MI LOCAL"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPage(),
                ),
              );
            },
          ),
          new ListTile(
            title: Text("COLA ONLINE"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Queue(),
                ),
              );
            },
          ),
          new ListTile(
            title: Text(
              "CERRAR SESIÓN",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              context.read<AuthenticationService>().signOut().then(
                    (value) => MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
