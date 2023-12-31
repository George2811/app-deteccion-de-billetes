import 'dart:io';
import 'package:flutter/material.dart';

class SelectCurrency extends StatefulWidget {
  const SelectCurrency({super.key});

  @override
  State<SelectCurrency> createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  Color _backgroundColor1 = Colors.black.withOpacity(0.7);
  Color _backgroundColor2 = Colors.black.withOpacity(0.7);

  void _changeSelectedColor(int num) {
    setState(() {
      if(num == 1){
        _backgroundColor1 = const Color.fromARGB(255, 32, 90, 34).withOpacity(0.5);

      } else {
        _backgroundColor2 = const Color.fromARGB(255, 32, 90, 34).withOpacity(0.5);
      }

    });
  }
  void _changeUnSelectedColor(int num) {
    setState(() {
      if(num == 1){
        _backgroundColor1 = Colors.black.withOpacity(0.7);

      } else {
        _backgroundColor2 = Colors.black.withOpacity(0.7);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Moneda",
              style: TextStyle(
                color: Colors.black54,
                fontWeight:  FontWeight.bold 
              ),
            ),
            automaticallyImplyLeading: false,
            leading: Container(
              margin: const EdgeInsets.only(left: 25.0),
              child: const Icon(
                Icons.menu,
                color: Colors.black54,
              )
            ),
          ),
          Container(
            width: 300,
            margin: const EdgeInsets.only(top: 10, bottom: 15),
            child: const Text(
              "Favor, selecciona el tipo de moneda a detectar",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: (){
                _changeSelectedColor(1);
                // redirige a la funcionalidad de detección
              },
              child: Container(
                height: 160,
                width: 300,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: const AssetImage("assets/soles.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      _backgroundColor1,
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Soles\t\t\t',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                       TextSpan(
                        text: 'S/\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Moneda Nacional del Perú',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14,),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: (){
                _changeSelectedColor(2);
                // redirige a la funcionalidad de detección
              },
              child: Container(
                height: 160,
                width: 300,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: const AssetImage("assets/dollars.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      _backgroundColor2,
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Dolares\t\t\t',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                       TextSpan(
                        text: '\$\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Moneda Oficial de los Estados Unidos',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}