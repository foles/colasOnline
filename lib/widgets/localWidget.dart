import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class LocalWidget extends StatelessWidget {
  String nombre, direccion, tipo;
  int tiempoAtencion;
  bool estado;
  LocalWidget(
      this.nombre, this.direccion, this.tiempoAtencion, this.tipo, this.estado);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Center(
              child: DottedBorder(
                  color: Colors.blue,
                  dashPattern: [100, 4],
                  strokeWidth: 2,
                  strokeCap: StrokeCap.round,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  child: Container(
                    height: 90,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[50],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 7,
                          left: 11,
                          child: Image.asset(
                            'assets/store.png',
                            height: 70,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 90,
                          child: Text(
                            nombre,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blueAccent[700]),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 10,
                          child: estado
                              ? Text(
                                  "Abierto",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.green),
                                )
                              : Text(
                                  "Cerrado",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.red),
                                ),
                        ),
                        Positioned(
                          top: 25,
                          left: 90,
                          child: Text(
                            'Tipo: ${tipo}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Positioned(
                          top: 45,
                          left: 90,
                          child: Text(
                            'Dirección: ${direccion}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Positioned(
                          top: 65,
                          left: 90,
                          child: Text(
                            'Tiempo de Atención (Aprox): ${tiempoAtencion} min.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ));
  }
}
