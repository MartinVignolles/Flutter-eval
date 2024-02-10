import 'dart:convert';

import 'package:appli_mobile/components/distribution_card.dart';
import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:appli_mobile/donnees/model/evenement.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  HistoriquePageState createState() => HistoriquePageState();
}

class HistoriquePageState extends State<HistoriquePage> {
  bool loaded = false;
  late List<Evenement> evenements;
  @override
  void initState() {
    super.initState();
    loadEvenement();
  }

  Future<void> loadEvenement() async {
    try {
      final jsonData = await fetchDataFromMockaroo(apiKey, 15);
      setState(() {
        evenements = jsonData.map((json) => Evenement.fromJson(json)).toList();
        loaded = true;
      });
    } catch (e) {
      print('Erreur lors du chargement des données: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const MyText(
              hintText: "Historique généré aléatoirement", fontSize: 20),
          backgroundColor: couleurAffichageSombre,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(child: buildEvent()),
          ],
        ));
  }

  Future<List<Map<String, dynamic>>> fetchDataFromMockaroo(
      String apiKey, int rowCount) async {
    final apiUrl =
        'https://api.mockaroo.com/api/2372ff70?count=$rowCount&key=$apiKey';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data from Mockaroo API');
    }
  }

  Widget buildEvent() {
    if (!loaded) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: evenements.length,
        itemBuilder: (context, index) {
          return DistributionCard(
              animalName: evenements[index].name,
              heure: evenements[index].heure,
              onPressed: () {},
              numProgramme: 2,
              isActivate: evenements[index].activate);
        },
      );
    }
  }
}
