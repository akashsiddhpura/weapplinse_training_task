class Usermodel {
  String? uid;
  String? email;
  String? firstname;
  String? secondname;
  String? photoURL;

  Usermodel(
      {this.email, this.firstname, this.secondname, this.uid, this.photoURL});

  //receving data from server
  factory Usermodel.fromMap(map) {
    return Usermodel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstName'],
      secondname: map['secondName'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email ': email,
      'firstName': firstname,
      'secondName': secondname,
    };
  }
}
