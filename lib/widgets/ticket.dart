import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class Ticket extends StatelessWidget {
  String nombre, id, horario, estado;
  Color colorTicket;
  Ticket(this.nombre, this.id, this.horario, this.estado, this.colorTicket);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Center(
          child: DottedBorder(
        color: Colors.white70,
        dashPattern: [8, 4],
        strokeWidth: 2,
        strokeCap: StrokeCap.round,
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: Container(
          height: 60,
          width: 350,
          child: Stack(
            children: [
              Positioned(
                top: 5,
                left: 5,
                child: Text(
                  nombre,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Text(
                  'ID: $id',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 5,
                child: Text(
                  'Horario: $horario',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Text(
                  estado,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorTicket,
          ),
        ),
      )),
    );
  }
}
