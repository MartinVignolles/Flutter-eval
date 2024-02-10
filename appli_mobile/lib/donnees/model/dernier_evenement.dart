class DernierEvenement {
  final String heure;
  final String distribution;

  DernierEvenement(this.heure, this.distribution);

  DernierEvenement.fromJson(Map<String, dynamic> json)
      : heure = json['heure'] as String,
        distribution = json['distribution'] as String;

  Map<String, dynamic> toJson() => {
        'heure': heure,
        'distribution': distribution,
      };
}
