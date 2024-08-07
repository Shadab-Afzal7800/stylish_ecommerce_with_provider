class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;
  UserModel({
    this.uid,
    this.fullname,
    this.email,
    this.profilepic,
  });
  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "fullname": fullname,
      "uid": uid,
      "email": email,
      "profilepic": profilepic,
    };
  }
}
