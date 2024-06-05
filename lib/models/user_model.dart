class UserModel {
  String? uid;
  String? fullname;
  String? email;
  UserModel({
    this.uid,
    this.fullname,
    this.email,
  });
  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
  }

  Map<String, dynamic> toMap() {
    return {
      "fullname": fullname,
      "uid": uid,
      "email": email,
    };
  }
}
