import 'dart:convert';

import 'package:appli_mobile/components/historique_card.dart';
import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:appli_mobile/donnees/model/historique_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  HistoriquePageState createState() => HistoriquePageState();
}

class HistoriquePageState extends State<HistoriquePage> {
  bool loaded = false;
  late List<HistoriqueModel> historique;
  @override
  void initState() {
    super.initState();
    loadEvenement();
  }

  Future<void> loadEvenement() async {
    String jsonString =
        await rootBundle.loadString('lib/donnees/json/historique.json');
    List<dynamic> jsonList = await json.decode(jsonString);
    setState(() {
      historique =
          jsonList.map((json) => HistoriqueModel.fromJson(json)).toList();
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: const MyText(hintText: "Historique", fontSize: 25),
            backgroundColor: couleurAffichageSombre,
            centerTitle: true,
            automaticallyImplyLeading: false),
        body: Column(
          children: [
            Expanded(child: buildEvent()),
          ],
        ));
  }

  Widget buildEvent() {
    if (!loaded) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: historique.length,
        itemBuilder: (context, index) {
          return HistoriqueCard(
            gamelle: historique[index].gammelle,
            heure: historique[index].heure,
            jour: historique[index].jour,
            numProgramme: historique[index].programme,
            distribution: historique[index].distribution,
          );
        },
      );
    }
  }
}
