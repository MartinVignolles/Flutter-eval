import 'package:appli_mobile/components/event_pop_up.dart';
import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/components/text_circle.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:flutter/material.dart';

class DistributionCard extends StatefulWidget {
  final List<String> animalName;
  final String heure;
  final VoidCallback onPressed;
  final bool isActivate;
  final int numProgramme;

  const DistributionCard(
      {super.key,
      required this.animalName,
      required this.heure,
      required this.onPressed,
      required this.numProgramme,
      required this.isActivate});

  @override
  DistributionCardState createState() => DistributionCardState();
}

class DistributionCardState extends State<DistributionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingEntreElement,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.15,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AddEventPopup(
                    etat: ETAT.modification,
                  );
                },
              );
            },
            child: Card(
              color: couleurAffichageSombre,
              child: ListTile(
                title: MyText(
                  hintText: widget.heure,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.animalName.length,
                  itemBuilder: (context, index) {
                    return MyTextCircle(
                      hintText: widget.animalName[index],
                      fontSize: 15,
                    );
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Switch(
                      value: widget.isActivate,
                      onChanged: (bool value) {
                        setState(() {});
                      },
                    ),
                    MyTextCircle(
                      hintText: widget.numProgramme.toString(),
                      fontSize: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
