import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/components/text_circle.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:flutter/material.dart';

class HistoriqueCard extends StatefulWidget {
  final List<String> gamelle;
  final String heure;
  final String jour;
  final int numProgramme;
  final String distribution;

  const HistoriqueCard(
      {super.key,
      required this.gamelle,
      required this.heure,
      required this.jour,
      required this.numProgramme,
      required this.distribution});

  @override
  HistoriqueCardState createState() => HistoriqueCardState();
}

class HistoriqueCardState extends State<HistoriqueCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingEntreElement,
      child: Center(
        child: SizedBox(
          //width: MediaQuery.of(context).size.width * 0.85,
          //height: MediaQuery.of(context).size.height * 0.15,
          child: Card(
            color: couleurAffichageSombre,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      MyText(
                        hintText: widget.jour,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      MyText(
                        hintText: widget.heure,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      MyTextCircle(
                        hintText: widget.numProgramme.toString(),
                        fontSize: 15,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MyText(
                        hintText: widget.distribution,
                        fontFamily: 'Snippet',
                        fontSize: 12,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              widget.gamelle.length,
                              (index) => MyTextCircle(
                                hintText: widget.gamelle[index],
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
