import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Hola!",
          style: TextStyle( // Corrected TextStyle declaration
            color: Colors.black54,
            fontWeight:  FontWeight.bold 
          ),
        ),
        automaticallyImplyLeading: false,
        leading:
          Builder(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(6),
                child: FloatingActionButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  child: ClipOval(
                    child:Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/d/d1/CARLOS-WARD-PERFIL.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}