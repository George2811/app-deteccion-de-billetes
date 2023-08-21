// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class CameraView extends StatefulWidget {
//   const CameraView({super.key});

//   @override
//   State<CameraView> createState() => _CameraViewState();
// }

// class _CameraViewState extends State<CameraView> {
//   late CameraController _controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _controller = CameraController(cameras[0], ResolutionPreset.max);
//     _controller.initialize().then((_) {
//       if(!mounted){
//         return;
//       }
//       setState((){});
//     }).catchError((Object e){
//       if(e is CameraException){
//         switch(e.code){
//           case 'CameraAccessDenied':
//             print("Acceso denegado");
//             break;
//           default:
//             print(e.description);
//             break;
//         }

//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             child: CameraPreview(_controller),
//           )
//         ],
//       ),
//     );
//   }
// }