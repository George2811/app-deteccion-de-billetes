import 'package:flutter/material.dart';

class DetectionCard extends StatelessWidget {
  const DetectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: 320,
        height: 255,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              child: Image.network(
                "https://www.ipe.org.pe/portal/wp-content/uploads/2020/03/retiro-CTS-finanzas.jpg",
                height: 180,
                width: 320,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 165,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$100 falsos",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "99.88%",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(172, 0, 0, 0),
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "28/08/2023 - 14:30 PM",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.delete_forever_rounded, color: Color.fromARGB(255, 216, 79, 70),),
                    ),
                  )
                ],
              ),
            )            
          ],
        ),
      ),
    );
  }
}