import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/components/my_textfield.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:appli_mobile/decoration/decoration.dart';
import 'package:flutter/material.dart';

class AnimalCard extends StatefulWidget {
  final String animalName;
  final int age;
  final VoidCallback onPressed;
  final bool showModifyButton;
  final bool showInformationButton;

  const AnimalCard(
      {super.key,
      required this.animalName,
      required this.age,
      required this.onPressed,
      this.showModifyButton = false,
      this.showInformationButton = true});

  @override
  AnimalCardState createState() => AnimalCardState();
}

class AnimalCardState extends State<AnimalCard> {
  late TextEditingController animalNameController;
  late TextEditingController ageController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    animalNameController = TextEditingController(text: widget.animalName);
    ageController = TextEditingController(text: widget.age.toString());
  }

  @override
  void dispose() {
    animalNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void onModifyPressed() {
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print("A mettre à jour dans la base de données  " +
        animalNameController.text +
        "  " +
        ageController.text +
        "  ");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: paddingEntreElement,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Container(
              decoration: GradientContainer.blueGradient,
              child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: isEditing
                            ? MyTextField(
                                controller: animalNameController,
                                hintText: 'Nom de l\'animal',
                              )
                            : MyText(
                                hintText: widget.animalName,
                                fontSize: 20,
                              ),
                        subtitle: isEditing
                            ? MyTextField(
                                textInputType: TextInputType.number,
                                controller: ageController,
                                hintText: 'Age de l\'animal',
                              )
                            : MyText(
                                hintText: 'Age: ${widget.age} mois',
                                fontSize: 15),
                        trailing: const Icon(
                          Icons.pets,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (widget.showInformationButton)
                              const MyText(
                                  hintText: "some informations", fontSize: 15),
                            if (widget.showInformationButton)
                              IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                color: Colors.white,
                                onPressed: widget.onPressed,
                              ),
                            if (widget.showModifyButton)
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isEditing = !isEditing;
                                    if (!isEditing) {
                                      onModifyPressed();
                                    }
                                  });
                                },
                              ),
                          ]),
                    ],
                  )),
            ),
          ),
        ));
  }
}
