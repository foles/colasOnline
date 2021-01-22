import 'package:colasOnline/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/queue.png',
            height: 150,
          ),
          Text(
            "Colas Online\n",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
                fontSize: 30),
          ),
          Center(
            child: Container(
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Ingrese su correo';
                        }
                      },
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Ingrese su contraseña';
                        }
                      },
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                    ),
                    Text("\n\n"),
                    RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          context.read<AuthenticationService>().signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        },
                        child: Text(
                          'INICIAR SESION',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
