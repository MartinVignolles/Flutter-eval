import 'package:appli_mobile/components/my_button.dart';
import 'package:appli_mobile/components/my_text.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddEventPopup extends StatefulWidget {
  final String id;
  final ETAT etat;

  const AddEventPopup({Key? key, this.id = "", required this.etat})
      : super(key: key);

  @override
  AddEventPopupState createState() => AddEventPopupState();
}

class AddEventPopupState extends State<AddEventPopup> {
  List<String> selectedDays = [];
  TimeOfDay? selectedTime;
  List<String> gamelle = [];

  @override
  void initState() {
    super.initState();
    if (widget.etat == ETAT.modification) {
      //getCardByID
    }
  }

  static List<String> jourSemaine = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche',
  ];
  static List<String> programme = ['Tigrou', 'Rex']; // Default selection
  final items = jourSemaine.map((e) => MultiSelectItem<String>(e, e)).toList();
  final itemsGamelle =
      programme.map((e) => MultiSelectItem<String>(e, e)).toList();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: couleurAffichageSombre,
      title: const MyText(
        hintText: 'Ajouter un événement',
        fontSize: 20,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MultiSelectDialogField(
              initialValue: selectedDays,
              backgroundColor: couleurAffichageSombre,
              buttonText: const Text('jours de la semaine',
                  style: TextStyle(color: Colors.white)),
              items: items,
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                selectedDays = values;
              },
            ),
            MultiSelectDialogField(
              initialValue: gamelle,
              backgroundColor: couleurAffichageSombre,
              buttonText:
                  const Text('Gamelle', style: TextStyle(color: Colors.white)),
              items: itemsGamelle,
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                gamelle = values;
              },
            ),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
              child: Text(selectedTime != null
                  ? 'Heure sélectionnée: ${selectedTime!.format(context)}'
                  : 'Sélectionner une heure'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MyButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'Annuler',
          fontSize: 15,
          fontFamily: 'Inter',
          background: Colors.red,
        ),
        MyButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          fontFamily: 'Inter',
          text: 'Enregistrer',
          fontSize: 15,
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}
