import 'package:counterfeit_detector/ui/views/control.dart';
import 'package:counterfeit_detector/ui/views/login.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //bool _loading = false;
  //final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/cover.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), // Ajusta el nivel de opacidad aquí
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(25),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hola!\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                       TextSpan(
                        text: 'Crea una cuenta',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),                      
                    ]
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Correo",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 1, 24, 7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 1, 24, 7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _password2Controller,
                    decoration: InputDecoration(
                      labelText: "Repite tu contraseña",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 1, 24, 7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 165, 245, 115),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ControlView()));
                      },
                      child: const Text(
                        "Registrar",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      )
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿Ya tienes una cuenta? "),
                      InkWell(
                        child: const Text(
                          "Inicia sesión",
                          style: TextStyle(
                            color: Color.fromARGB(255, 1, 24, 7),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));
                        }
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}