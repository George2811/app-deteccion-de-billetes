import 'package:counterfeit_detector/ui/widgets/detection_card.dart';
import 'package:flutter/material.dart';

class DetectionsView extends StatefulWidget {
  const DetectionsView({super.key});

  @override
  State<DetectionsView> createState() => _DetectionsViewState();
}

class _DetectionsViewState extends State<DetectionsView> with TickerProviderStateMixin{
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
            margin: const EdgeInsets.symmetric(horizontal: 38),
            height: 640,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: const <Widget>[
                    DetectionCard(),
                    DetectionCard(),
                    DetectionCard(),
                    DetectionCard(),
                  ],
                ),
                ListView(
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