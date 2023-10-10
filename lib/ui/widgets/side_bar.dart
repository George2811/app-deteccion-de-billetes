import 'package:counterfeit_detector/colors.dart';
import 'package:counterfeit_detector/state/auth.dart';
import 'package:counterfeit_detector/ui/views/detections.dart';
import 'package:counterfeit_detector/ui/views/login.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String? email = Auth().currentUser?.email;

  Future<void> signOut() async {
    await Auth().signOut(); 
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(email??"correo.com", style: const TextStyle(color: Colors.white)),
            accountEmail: const Text(""),
            currentAccountPicture: ClipOval(
              child:Image.asset(
                "assets/rounded_logo_b.png",
                fit: BoxFit.cover,
              )
            ),
            decoration: const BoxDecoration(
              color: dark,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.compare),
            title: Text(
              "Mis detecciones",
              style: TextStyle(
                color: dark[200],
              ),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DetectionsView()));
            },
          ),         
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text("Cerra sesión", style: TextStyle(color: dark[200]),),
            onTap: (){
              signOut();
              Navigator.of(context, rootNavigator: true)
                .pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LoginView();
                    },
                  ),
                  (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}