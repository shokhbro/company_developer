class Employees {
  final String name;
  final int age;
  final String position;
  final List<String> skills;

  Employees({
    required this.name,
    required this.age,
    required this.position,
    required this.skills,
  });

  factory Employees.fromJson(Map<String, dynamic> json) {
    return Employees(
      name: json['name'],
      age: json['age'],
      position: json['position'],
      skills: List<String>.from(json['skills']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'position': position,
      'skills': skills,
    };
  }
}
