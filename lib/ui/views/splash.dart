//import 'package:counterfeit_detector/ui/views/login.dart';
import 'package:counterfeit_detector/ui/widgets/widget_tree.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Simula una espera de 3 segundos antes de navegar a la siguiente pantalla.
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WidgetTree()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 450,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: const AssetImage("assets/cover.jpg"),
                fit: BoxFit.cover,
                
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.7, 1],
                  colors: [Color.fromARGB(255, 1, 9, 3), Color.fromARGB(255, 2, 38, 12)],
                )
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(15),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'SafyCash\n\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      TextSpan(
                        text: 'Detecta la veracidad de tus billetes,\n',
                        style: TextStyle(
                          color: Color.fromARGB(255, 190, 190, 190),
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: 'tanto soles peruanos como\n',
                        style: TextStyle(
                          color: Color.fromARGB(255, 190, 190, 190),
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: 'dólares americanos.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 190, 190, 190),
                          fontSize: 15,
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}