import 'package:carousel_slider/carousel_slider.dart';
import 'package:counterfeit_detector/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CharacteristicsView extends StatefulWidget {

  final String category;
  const CharacteristicsView({super.key, this.category = ""});

  @override
  State<CharacteristicsView> createState() => _CharacteristicsViewState();
}

class _CharacteristicsViewState extends State<CharacteristicsView> {
  Map<String, dynamic> currencyData = {};  // Lista para almacenar los datos del JSON
  List characteristics = [];

  Future<void> loadCurrencies() async {
    String jsonText = await rootBundle.loadString('assets/currencies.json');
    
    setState(() {
      currencyData = jsonDecode(jsonText);
      characteristics = currencyData[widget.category];
    });

    //print(currencyData.keys.elementAt(0));
    //print(currencyData[widget.category]);
  }

  @override
  void initState() {
    super.initState();
    loadCurrencies(); // Cargar los datos del JSON cuando se inicializa el widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              widget.category,
              style: const TextStyle(
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
        options: CarouselOptions(height: 650.0, viewportFraction: 0.9, enlargeCenterPage: true, enlargeFactor: 0.15),
        items: characteristics.map((e) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: const Color.fromARGB(255, 1, 8, 7),
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
                            e['img']?? "http://multimedia.bcrp.gob.pe/docs/billetes/images/100-hilo-de-seguridad.gif",
                            fit: BoxFit.fitWidth,
                          )
                        ),
                      ),
                      const SizedBox(height: 20,),                     
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e['name']?? "Titulo",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(                        
                          children: [
                            Container(
                              alignment: Alignment.center,                   
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: alternative,
                              ),
                              child: Text(
                                "${e['amount']?? 'Monto en'} ${widget.category.toLowerCase()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Container(
                              alignment: Alignment.center,                   
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                              ),
                              child: Text(
                                "${e['edition']?? 'Edición'}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          e['description']?? "Hilo de seguridad con movimiento de anillos, que cambian de color fucsia a verde y el texto 100 BCRP calado. El hilo contiene elementos magnéticos por lo que es detectable por máquina.",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color.fromARGB(255, 235, 235, 235),
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