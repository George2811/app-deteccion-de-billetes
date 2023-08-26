import 'package:counterfeit_detector/state/auth.dart';
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
            accountName: Text(email??"correo.com"),
            accountEmail: const Text(""),
            currentAccountPicture: ClipOval(
              child:Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/d/d1/CARLOS-WARD-PERFIL.png",
                fit: BoxFit.cover,
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.black
            ),
          ),
          ListTile(
            leading: const Icon(Icons.compare),
            title: const Text("Mis detecciones"),
            onTap: (){},
          ),         
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text("Cerra sesión"),
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