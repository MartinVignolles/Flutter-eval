import 'dart:convert';
import 'package:appli_mobile/components/distribution_card.dart';
import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/components/text_circle.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:appli_mobile/decoration/decoration.dart';
import 'package:appli_mobile/donnees/model/evenement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalendrierPage extends StatefulWidget {
  const CalendrierPage({super.key});

  @override
  CalendrierPageState createState() => CalendrierPageState();
}

class CalendrierPageState extends State<CalendrierPage> {
  late List<Evenement> evenements;
  bool loaded = false;
  List<String> daysOfWeek = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  ];
  String selectedDay = 'Lundi';

  @override
  void initState() {
    super.initState();
    loadEvenement();
  }

  Future<void> loadEvenement() async {
    String jsonString =
        await rootBundle.loadString('lib/donnees/json/evenement.json');
    List<dynamic> jsonList = await json.decode(jsonString);
    setState(() {
      evenements = jsonList.map((json) => Evenement.fromJson(json)).toList();
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title:
              const MyText(hintText: "Distributions Programmées", fontSize: 20),
          backgroundColor: couleurAffichageSombre,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: GradientContainer.blueGradient,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: daysOfWeek.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedDay = daysOfWeek[index];
                                });
                              },
                              child: MyTextCircle(
                                  colorText: selectedDay == daysOfWeek[index]
                                      ? Colors.black
                                      : Colors.white,
                                  hintText: daysOfWeek[index],
                                  fontSize: 20,
                                  color: selectedDay == daysOfWeek[index]
                                      ? Colors.white
                                      : couleurAffichage),
                            );
                          }),
                    ),
                    Expanded(child: buildEvenement()),
                  ],
                ),
              ),
            ),
            const MyTextCircle(
              hintText: "+ Programme",
              fontSize: 20,
              color: couleurAffichageSombre,
              colorText: Colors.white,
            )
          ],
        ));
  }

  Widget buildEvenement() {
    if (!loaded) {
      return const Center(child: CircularProgressIndicator());
    } else {
      List<Evenement> newEvent = evenements
          .where((evenement) => evenement.jour == selectedDay)
          .toList();
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: newEvent.length,
        itemBuilder: (context, index) {
          return DistributionCard(
              animalName: newEvent[index].name,
              heure: newEvent[index].heure,
              onPressed: () {},
              numProgramme: 2,
              isActivate: newEvent[index].activate);
        },
      );
    }
  }
}
