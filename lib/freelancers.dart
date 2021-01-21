class Freelancers {

  final int id;
  final String name;
  final String profession;
  final String hourlyRate;
  final String experience;
  final String completedProject;
  final String country;
  final String image;

  Freelancers ({
    this.id, this.name, this.profession, this.hourlyRate, this.experience, this.completedProject, this.country, this.image,
  });

  factory Freelancers.fromJson(Map<String, dynamic> json) {
    return Freelancers(

      id: json['id'],
      name: json['name'],
      profession: json['profession'] ,
      hourlyRate: json['hourlyRate'],
      experience: json['experience'],
      completedProject: json['completedProject'] ,
      country: json['country'],
      image: json['image']
    );
  }

}