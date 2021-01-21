class Users {

  final int id;
  final String fullname;
  final String username;
  final String password;
  final String phone;
  final String email;
  final int age;
  final String role;
  final String confirmPwd;

  Users ({
    this.id, this.fullname, this.username, this.password, this.phone, this.email, this.age, this.role, this.confirmPwd
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(

      id: json['id'],
      fullname: json['fullname'],
      username: json['username'] ,
      password: json['password'],
      phone: json['phone'],
      email: json['email'] ,
      age: json['age'],
      role: json['role'],
    );
  }
}