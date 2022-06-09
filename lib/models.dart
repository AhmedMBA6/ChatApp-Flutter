class UserModel {
  String? uid;
  String? firstName;
  String? lastname;
  String? email;
  String? phone;

  UserModel({this.uid, this.firstName, this.lastname, this.email,
      this.phone});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastname: map['lastName'],
      email: map['email'],
      phone: map['phone']




    );

  }

  Map<String, dynamic> toMap() {
    return{
      'uid' : uid,
      'email': email,
      'firstName' : firstName,
      'lastName' : lastname,
      'phone': phone
    };
  }


}
