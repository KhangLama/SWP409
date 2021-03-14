class User {
  String name;
  String phone;
  String email;
  String password;

  User({this.name, this.phone, this.email, this.password});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    phone = json['phone'] as String; 
    email = json['email'] as String;
    password = json['password'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

}
