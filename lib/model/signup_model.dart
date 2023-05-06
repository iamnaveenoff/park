class SignupModel {
  String? username;
  String? name;
  String? email;
  String? phone;
  String? password;
  List<String>? roles;

  SignupModel(
      {this.username,
      this.email,
      this.phone,
      this.password,
      this.roles,
      this.name});

  SignupModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['roles'] = roles;
    return data;
  }
}
