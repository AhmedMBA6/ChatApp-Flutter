import 'constant.dart';

class UserField {
  static const String lastMessageTime = 'lastMessageTime';
}

class UserModel {
   String? id;
   String? fullName;
   String? userName;
   String? email;
   String? phone;

   UserModel(
      {this.id,
      this.fullName,
      this.userName,
      this.email,
      this.phone,});

  UserModel copyWith({
    String? id,
    String? fullName,
    String? userName,
    String? email,
    String? phone,
  }) =>
      UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  Map<String, dynamic> toMap() => {
        columnFullName: fullName,
        columnUserName: userName,
        columnEmail: email,
        columnPhone: phone,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[columnId],
      fullName: map[columnFullName],
      userName: map[columnUserName],
      email: map[columnEmail],
      phone: map[columnPhone],
    );
  }
}
