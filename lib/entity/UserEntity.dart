class User {
  String password;
  String name;
  String account;

  User({this.password, this.name, this.account});

  User.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    name = json['name'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['name'] = this.name;
    data['account'] = this.account;
    return data;
  }
}
