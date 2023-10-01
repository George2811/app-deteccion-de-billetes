import 'package:counterfeit_detector/state/auth.dart';
import 'package:counterfeit_detector/ui/views/control.dart';
import 'package:counterfeit_detector/ui/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? errorMessage = '';
  bool loading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  bool passenable = true; // Ocultar password
  bool passenable2 = true; // Ocultar password 2


  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    try {
      final emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if(_emailController.text.trim().isEmpty || !_emailController.text.contains(emailValid)){
        throw const FormatException('Favor, ingrese un correo valido (Ejemplo: abc@gmail.com)');
      }
      if(_passwordController.text != _password2Controller.text){
        throw const FormatException('Las contraseñas no coinciden');
      }
      setState(() {
        loading = true;
      });
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _password2Controller.text
      );
      setState(() {
        loading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ControlView()));

    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        errorMessage = 'Error: No se ha podido registrar el usuario.';
        loading = false;
      });
      var snackBar = SnackBar(content: Text(errorMessage?? 'Error', style: const TextStyle(color: Color.fromARGB(255, 255, 81, 68)),),backgroundColor: const Color.fromARGB(255, 0, 0, 0),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FormatException catch (msg){
      var snackBar = SnackBar(content: Text(msg.message, style: const TextStyle(color: Color.fromARGB(255, 255, 81, 68)),),backgroundColor: const Color.fromARGB(255, 0, 0, 0),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

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
                    obscureText: passenable,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      suffixIcon: IconButton(
                        icon: Icon(passenable== true? Icons.remove_red_eye : Icons.visibility_off, size: 20, color: const Color.fromARGB(197, 10, 10, 10)),
                        splashRadius: 15,
                        onPressed: (){
                          setState(() => passenable = !passenable);
                        },
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
                    controller: _password2Controller,
                    obscureText: passenable2,
                    decoration: InputDecoration(
                      labelText: "Repite tu contraseña",
                      suffixIcon: IconButton(
                        icon: Icon(passenable2== true? Icons.remove_red_eye : Icons.visibility_off, size: 20, color: const Color.fromARGB(197, 10, 10, 10)),
                        splashRadius: 15,
                        onPressed: (){
                          setState(() => passenable2 = !passenable2);
                        },
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
                        if(!loading){
                          createUserWithEmailAndPassword(context);
                        } else {
                          //return null;
                        }
                      },
                      child: loading?
                        const CircularProgressIndicator(color: Colors.black, strokeWidth: 3,)
                        :
                        const Text(
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
                            fontWeight: FontWeight.bold
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