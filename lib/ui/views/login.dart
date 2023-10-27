import 'package:counterfeit_detector/colors.dart';
import 'package:counterfeit_detector/state/auth.dart';
import 'package:counterfeit_detector/ui/views/control.dart';
import 'package:counterfeit_detector/ui/views/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? errorMessage = '';
  bool loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool passenable = true; // Ocultar password

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      setState(() {
        loading = true;
      });
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );
      setState(() {
        loading = false;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => const ControlView()));

    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        errorMessage = 'Error: No se ha podido iniciar sesión, valida las credenciales.';

        loading = false;
      });
      var snackBar = SnackBar(content: Text(errorMessage?? 'Error', style: const TextStyle(color: Color.fromARGB(255, 255, 81, 68)),),backgroundColor: const Color.fromARGB(255, 0, 0, 0),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Stack(children: <Widget>[
              Container(
                height: 340.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/portrait.jpg',
                    ),
                  ),
                ),
              ),
              Container(
                height: 340.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.centerLeft,
                        end: FractionalOffset.centerRight,
                        colors: [
                          Colors.black87,
                          Colors.grey.withOpacity(0.0),
                        ],
                        stops: const [
                          0.0,
                          0.8
                        ])),
              ),
              Container(
                height: 340.0,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
                child: RichText(                  
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hola!\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextSpan(
                        text: 'Inicia sesión con\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextSpan(
                        text: 'tu cuenta',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),                      
                    ]
                  ),
                ),
              ),
            ]),  
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
                          color: dark,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: passenable,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      suffixIcon: IconButton(
                        icon: Icon(passenable== true? Icons.remove_red_eye : Icons.visibility_off, size: 20, color: dark),
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
                          color: dark,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: alternative,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: (){                        
                        if(!loading){
                          signInWithEmailAndPassword(context);
                        } else {
                          print("Cargando...");
                          return null;
                        }
                      },
                      child: loading?
                        const CircularProgressIndicator(color: dark, strokeWidth: 3,)
                        :
                        const Text(
                        "Ingresar",
                        style: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("¿No tienes una cuenta? ", style: TextStyle(color: dark[300]),),
                      InkWell(
                        child: const Text(
                          "Regístrate",
                          style: TextStyle(
                            color: dark,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold
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