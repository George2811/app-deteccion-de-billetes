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
      child: InkWell(
        onLongPress: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const DeleteCard();
            },
          );
        },
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          width: 370,
          height: 262,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: Image.network(
                  "https://www.ipe.org.pe/portal/wp-content/uploads/2020/03/retiro-CTS-finanzas.jpg",
                  height: 180,
                  width: 350,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 105,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(234, 4, 43, 14),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: const Text(
                            "\$100 falsos",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          margin: const EdgeInsets.only(left: 2),
                          child: const Text(
                            "28/08/2023 - 14:30 PM",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: const Text(
                        "99.88%",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteCard extends StatelessWidget{
  const DeleteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text(
        "¿Seguro que desea eliminar este registro?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
          fontWeight: FontWeight.bold
        ),
      ),
      content: const Text(
        "Guardado el 28/08/2023 - 14:30 PM",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black54,
          fontWeight: FontWeight.w400
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Colors.black26,
          ),
          child: const Text('Cancelar', style: TextStyle(color: Colors.black87)),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: const Color.fromARGB(232, 220, 37, 37),
          ),
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}