class DataModal {
  final String? email;
  final String? phone;
  final String? password;
  final String? hobby;
  final String? schoolFriend;
  final String? schoolFriend1;
  final String? collageFriend;
  final String? collageFriend1;

  DataModal({
    this.email,
    this.phone,
    this.password,
    this.hobby,
    this.schoolFriend,
    this.schoolFriend1,
    this.collageFriend,
    this.collageFriend1,
  });

  factory DataModal.fromMap(Map<dynamic, String> map) {
    return DataModal(
      email: map["email"] ?? "",
      phone: map["phone"] ?? "",
      password: map["password"] ?? "",
      hobby: map["hobby"],
      schoolFriend1: map["schoolFriend1"],
      schoolFriend: map["schoolFriend"],
      collageFriend: map["collageFriend"],
      collageFriend1: map["collageFriend1"],
    );
  }
}
