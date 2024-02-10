import 'dart:convert';

import 'package:appli_mobile/components/animal_card.dart';
import 'package:appli_mobile/components/heure_card.dart';
import 'package:appli_mobile/components/my_button.dart';
import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/decoration/decoration.dart';
import 'package:appli_mobile/donnees/model/animal.dart';
import 'package:appli_mobile/donnees/model/dernier_evenement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfosPage extends StatefulWidget {
  const InfosPage({Key? key, required this.idGamelle}) : super(key: key);

  final String idGamelle;

  @override
  InfosPageState createState() => InfosPageState();
}

class InfosPageState extends State<InfosPage> {
  late Animal animal;
  late List<DernierEvenement> evenement;
  bool loadedAnimal = false;
  bool loadedEvent = false;
  int selectedItem = 0;

  @override
  void initState() {
    super.initState();
    loadAnimalData(widget.idGamelle);
  }

  Future<void> loadAnimalData(String idGamelle) async {
    String jsonString =
        await rootBundle.loadString('lib/donnees/json/animal_data.json');

    List<dynamic> jsonData = await json.decode(jsonString);

    // Rechercher l'animal correspondant à l'ID de la gamelle
    Map<String, dynamic>? selectedAnimal = jsonData.firstWhere(
        (animal) => animal['idGamelle'] == idGamelle,
        orElse: () => null);

    String jsonStringHour =
        await rootBundle.loadString('lib/donnees/json/dernieres_heures.json');

    List<dynamic> jsonDataHour = await json.decode(jsonStringHour);

    setState(() {
      if (selectedAnimal != null) {
        animal = Animal.fromJson(selectedAnimal);
        loadedAnimal = true;
      }
      evenement =
          jsonDataHour.map((json) => DernierEvenement.fromJson(json)).toList();
      loadedEvent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          const SizedBox(
            height: 20,
          ),
          buildAnimalInfos(),
          const SizedBox(
            height: 16,
          ),
          Expanded(child: buildHistorique()),
          MyButton(
              onPressed: () => {HapticFeedback.mediumImpact()},
              fontSize: 15,
              text: "Distribution Manuelle"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const Icon(Icons.bug_report, color: Colors.red)
            ],
          ),
        ]));
  }

  Widget buildAnimalInfos() {
    if (!loadedAnimal) {
      // Afficher un indicateur de chargement ou un message d'erreur si nécessaire
      return const Center(child: CircularProgressIndicator());
    } else {
      // Afficher la liste des cartes d'animaux
      return Center(
        child: AnimalCard(
          animalName: animal.name,
          age: animal.age,
          showModifyButton: true,
          showInformationButton: false,
          onPressed: () {},
        ),
      );
    }
  }

  Widget buildHistorique() {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidthPercentage = 0.90;
    if (!loadedEvent) {
      // Afficher un indicateur de chargement ou un message d'erreur si nécessaire
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
        decoration: GradientContainer.blueGradient,
        width: screenWidth * containerWidthPercentage,
        child: Column(
          children: [
            const MyText(
              hintText: 'Dernière 24 heures',
              fontSize: 25,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: evenement.length,
                    itemBuilder: (context, index) {
                      return HeureCard(
                          heure: evenement[index].heure,
                          distribution: evenement[index].distribution);
                    }))
          ],
        ),
      );
    }
  }
}
