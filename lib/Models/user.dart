class User {
  String name;
  String phone;
  String email;
  String password;

  // ignore: sort_constructors_first
  User({this.name, this.phone, this.email, this.password});

  // ignore: sort_constructors_first
  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    phone = json['phone'] as String;
    email = json['email'] as String;
    password = json['password'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
