import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CharacteristicsView extends StatefulWidget {
  const CharacteristicsView({super.key});

  @override
  State<CharacteristicsView> createState() => _CharacteristicsViewState();
}

class _CharacteristicsViewState extends State<CharacteristicsView> {
  List<dynamic> currencies = []; // Lista para almacenar los datos del JSON

  Future<void> loadCurrencies() async {
    String jsonText = await rootBundle.loadString('assets/currencies.json');
    setState(() {
      currencies = json.decode(jsonText);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCurrencies(); // Cargar los datos del JSON cuando se inicializa el widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Soles",
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
      body: CarouselSlider(
        options: CarouselOptions(height: 500.0, viewportFraction: 0.9),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 0.0),
                decoration: const BoxDecoration(
                  //color: Colors.amber
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            "http://multimedia.bcrp.gob.pe/docs/billetes/images/100-hilo-de-seguridad.gif",
                            fit: BoxFit.fitWidth,
                          )
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Hilo de seguridad intersaliente",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(
                          "Hilo de seguridad con movimiento de anillos, que cambian de color fucsia a verde y el texto 100 BCRP calado. El hilo contiene elementos magnéticos por lo que es detectable por máquina.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              );
            },
          );
        }).toList(),
      )
    );
  }
}