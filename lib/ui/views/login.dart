import 'package:counterfeit_detector/ui/views/home.dart';
import 'package:counterfeit_detector/ui/views/register.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //bool _loading = false;
  //final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


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
                  image: AssetImage("assets/cover.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), // Ajusta el nivel de opacidad aquí
                    BlendMode.darken, // El modo de mezcla, puedes ajustarlo según tus necesidades
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
                        text: 'Inicia sesión con\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      TextSpan(
                        text: 'tu cuenta',
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
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    cursorColor: const Color.fromARGB(255, 1, 24, 7),
                    decoration: InputDecoration(
                      labelText: "Correo",
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 1, 24, 7),
                      ),
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
                    cursorColor: const Color.fromARGB(255, 1, 24, 7),                  
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 1, 24, 7),
                      ),
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
                        // En verdad debe redirigir a una vista qye tenga el bottom_navbar, ya q ese gestiona todo
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
                      },
                      child: const Text(
                        "Ingresar",
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
                      const Text("¿No tienes una cuenta? "),
                      InkWell(
                        child: const Text(
                          "Regístrate",
                          style: TextStyle(
                            color: Color.fromARGB(255, 1, 24, 7),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          // Redirigir a register view
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
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