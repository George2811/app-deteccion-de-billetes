import 'package:counterfeit_detector/services/detection_service.dart';
import 'package:counterfeit_detector/ui/widgets/detection_card.dart';
import 'package:flutter/material.dart';

class DetectionsView extends StatefulWidget {
  const DetectionsView({super.key});

  @override
  State<DetectionsView> createState() => _DetectionsViewState();
}

class _DetectionsViewState extends State<DetectionsView> with TickerProviderStateMixin{
  List<Map<String, dynamic>> detections = [];

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> data = await listDetectionsByUser();
      setState(() {
        detections = data;
      });
    } catch (e) {
      print(e);
      // Manejar errores aquí
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }  

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Mis detecciones",
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
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color.fromARGB(255, 2, 41, 12),
              tabs: const [
                Tab(
                  text: "Soles",
                ),
                Tab(
                  text: "Dólares",
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: 610,
            child: TabBarView(
              controller: _tabController,
              children: [
                detections.isNotEmpty?
                ListView.builder(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  itemCount: detections.length,
                  itemBuilder: (context, index) {
                    double percentage = detections[index]['percentage']*100;
                    return DetectionCard(
                      id: detections[index]['id'],
                      image: detections[index]['image_url'],
                      classification: detections[index]['classification'],
                      percentage: percentage.toStringAsFixed(2),
                      date: detections[index]['detection_date'],
                    );
                  },
                )
                :
                ListView(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  children: const <Widget>[
                    Center(child: Text("No se encontraron deteccion guardadas.", style: TextStyle(color: Colors.black54),))
                  ],
                ),
                ListView(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  children: const <Widget>[
                    DetectionCard(),
                    DetectionCard(),
                    DetectionCard(),
                    DetectionCard(),
                  ],
                ),  
              ],
            ),
          ),
        ],
      ),
    );
  }
}