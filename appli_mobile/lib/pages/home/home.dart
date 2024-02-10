import 'dart:convert';

import 'package:appli_mobile/components/animal_card.dart';
import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:appli_mobile/donnees/model/animal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  AnimalListScreenState createState() => AnimalListScreenState();
}

class AnimalListScreenState extends State<HomePage> {
  late List<Animal> animals;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    loadAnimalData();
  }

  Future<void> loadAnimalData() async {
    String jsonString =
        await rootBundle.loadString('lib/donnees/json/animal_data.json');
    List<dynamic> jsonList = await json.decode(jsonString);
    setState(() {
      animals = jsonList.map((json) => Animal.fromJson(json)).toList();
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const MyText(hintText: "Bienvenue", fontSize: 25),
          centerTitle: true,
          backgroundColor: couleurAffichageSombre,
        ),
        body: buildAnimalList());
  }

  Widget buildAnimalList() {
    if (!loaded) {
      // Afficher un indicateur de chargement ou un message d'erreur si nécessaire
      return const Center(child: CircularProgressIndicator());
    } else {
      // Afficher la liste des cartes d'animaux
      return ListView.builder(
        itemCount: animals.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              AnimalCard(
                animalName: animals[index].name,
                age: animals[index].age,
                onPressed: () {
                  Navigator.pushNamed(context, '/infos',
                      arguments: animals[index].idGamelle);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
