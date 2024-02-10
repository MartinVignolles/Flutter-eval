import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:flutter/material.dart';

class HeureCard extends StatefulWidget {
  final String heure;
  final String distribution;

  const HeureCard({super.key, required this.heure, required this.distribution});

  @override
  HeureCardState createState() => HeureCardState();
}

class HeureCardState extends State<HeureCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.85,
        child: Card(
          color: couleurAffichage,
          child: ListTile(
            title: Center(child: MyText(hintText: widget.heure, fontSize: 20)),
            subtitle: Center(
                child: MyText(
              hintText: widget.distribution,
              fontSize: 15,
            )),
          ),
        ),
      ),
    );
  }
}
