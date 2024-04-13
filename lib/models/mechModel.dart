class mechModel {
  String? mid;
  String? name;
  String? phoneNo;
  String? email;
  String? password;

  mechModel({this.mid, this.name, this.phoneNo, this.email, this.password});

  //data from server
  factory mechModel.fromMap(map) {
    return mechModel(
      mid: map['mid'],
      name: map['name'],
      phoneNo: map['phoneNo'],
      email: map['email'],
      password: map['password'],
    );
  }

  //sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'mid': mid,
      'name': name,
      'phoneNo': phoneNo,
      'email': email,
      'password': password,
    };
  }
}
