import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class Ticket extends StatelessWidget {
  String id, you;
  bool estado;
  Color colorTicket;
  Ticket(this.id, this.estado, this.colorTicket, this.you);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Center(
          child: DottedBorder(
        color: colorTicket,
        dashPattern: [80, 4],
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
                child: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 50.0,
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
                right: 5,
                child: estado
                    ? Text(
                        "Atendiendo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      )
                    : Text(
                        "Espera",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ),
              ),
              Positioned(
                bottom: 5,
                left: 80,
                child: Text(
                  you,
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
              color: estado ? Colors.teal[400] : colorTicket),
        ),
      )),
    );
  }
}
