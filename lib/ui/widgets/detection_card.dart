import 'package:flutter/material.dart';

class DetectionCard extends StatelessWidget {
  const DetectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: [0.7, 1],
            colors: [Color.fromARGB(255, 1, 9, 3), Color.fromARGB(255, 2, 38, 12)],
          )
        ),
        width: 300,
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children:  <Widget>[
            SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Deteccion de billetes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Detecta la veracidad de tus billetes.",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 190, 30),
                      ),
                      onPressed: () {
                        // LOS REDIRIGE A LA FUNCIONALIDAD DE DETECCIÓN DE BILLETES
                        //  1. Se aprueban permisos de cámara
                        //  2. Selecciona si es detección de Soles o Dólares
                        //  3. Un mensaje de como funciona?
                        //  4. Se activa la cámara :)
                      },
                      icon: const Icon(
                        Icons.compare,
                        size: 20.0,
                      ),
                      label: const Text('Empezar'),
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                "assets/cover.jpg",
                height: 200,
                width: 150,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}