class HistoriqueModel {
  final String heure;
  final String distribution;
  final String jour;
  final int programme;
  final List<String> gammelle;

  HistoriqueModel(
      this.heure, this.distribution, this.jour, this.programme, this.gammelle);

  HistoriqueModel.fromJson(Map<String, dynamic> json)
      : heure = json['heure'] as String,
        distribution = json['distribution'] as String,
        jour = json['jour'] as String,
        programme = json['programme'],
        gammelle = (json['gamelle'] as List<dynamic>).cast<String>();

  Map<String, dynamic> toJson() => {
        'heure': heure,
        'distribution': distribution,
        'jour': jour,
        'programme': programme,
        'gamelle': gammelle
      };
}
