import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Hola!",
            style: TextStyle(
              color: Colors.black54,
              fontWeight:  FontWeight.bold 
            ),
          ),
          automaticallyImplyLeading: false,
          leading:
            Builder(
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(7),
                  child: FloatingActionButton(
                    onPressed: () => {},
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
      ),
    );
  }
}