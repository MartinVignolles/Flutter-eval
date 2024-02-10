class Animal {
  final String name;
  final String idUtilisateur;
  final int age;
  final String idGamelle;

  Animal(this.name, this.idUtilisateur, this.age, this.idGamelle);

  Animal.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        idUtilisateur = json['idUtilisateur'] as String,
        age = json['age'] as int,
        idGamelle = json['idGamelle'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'idUtilisateur': idUtilisateur,
        'age': age,
        'idGamelle': idGamelle
      };
}
