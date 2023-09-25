import 'package:camera/camera.dart';
import 'package:counterfeit_detector/state/appdata.dart';
import 'package:counterfeit_detector/ui/views/home.dart';
import 'package:counterfeit_detector/ui/views/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: BottomNavBar(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromARGB(255, 1, 24, 7),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 1, 24, 7)),
          suffixIconColor: Color.fromARGB(255, 1, 24, 7),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if(!mounted){
        return;
      }
      setState((){});
    }).catchError((Object e){
      if(e is CameraException){
        switch(e.code){
          case 'CameraAccessDenied':
            print("Acceso denegado");
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: CameraPreview(_controller),
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
              width: 40,
              margin: const EdgeInsets.only(top: 30, right: 15),
                child: IconButton(
                onPressed: (){
                  setState(() {
                    appData.showNavBar = false;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeView()));
                  });
                },
                icon: const Icon(Icons.close_rounded, color: Colors.white, size: 30,)),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: () async {
                  // Toma la foto :)
                  if(!_controller.value.isInitialized){
                    return null;
                  }
                  if(!_controller.value.isTakingPicture){
                    return null;
                  }
      
                  try {
                    await _controller.setFlashMode(FlashMode.auto);
                    XFile picture = await _controller.takePicture();
                    print(picture);
                    // Aqui debemos enviar picture a la API (chequemos el foramto de la imagen)
                    
                  } on CameraException catch(e){
                    debugPrint("Error al tomar la foto: $e");
                    return null;
                  }
                },
                backgroundColor: const Color.fromARGB(255, 9, 20, 16),
                child:const Icon(
                  Icons.compare, 
                  color: Color.fromARGB(255, 0, 234, 37),),
              ),
            ),
          )
        ],
      ),
    );
  }
}