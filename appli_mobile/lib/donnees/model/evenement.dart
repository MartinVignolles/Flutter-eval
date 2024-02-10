class Evenement {
  final String heure;
  final String jour;
  final List<String> name;
  final bool activate;

  Evenement(this.heure, this.jour, this.name, this.activate);

  Evenement.fromJson(Map<String, dynamic> json)
      : heure = json['heure'] as String,
        jour = json['jour'] as String,
        name = (json['name'] as List<dynamic>).cast<String>(),
        activate = json['activate'] as bool;

  Map<String, dynamic> toJson() =>
      {'heure': heure, 'jour': jour, 'name': name, 'activate': activate};
}
