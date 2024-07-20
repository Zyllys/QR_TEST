class User {
  final int recid;
  final String username;
  final String name;
  final String surname;
  final int usergroup;
  final String position;
  final String address1;
  final String address2;
  final String address3;
  final String tel;
  final String email;
  final String lineid;
  final String zipcode;
  final String province;

  User({required this.recid, required this.username, required this.name, required this.surname, required this.usergroup, required this.position, required this.address1, required this.address2, required this.address3, required this.tel, required this.email, required this.lineid, required this.zipcode, required this.province});

  factory User.fromJson(Map<String,dynamic> json) {
    return switch(json) {
      {
        'recid' : int recid,
        'username' : String username,
        'name' : String name,
        'surname': String surname,
        'usergroup' : int usergroup,
        'position' : String position,
        'address1' : String address1,
        'address2' : String address2,
        'address3' : String address3,
        'tel' : String tel,
        'email' : String email,
        'lineid' : String lineid,
        'zipcode' : String zipcode,
        'province' : String province
      } => User(recid: recid, username: username, name: name, surname: surname, usergroup: usergroup, position: position, address1: address1, address2: address2, address3: address3, tel: tel, email: email, lineid: lineid, zipcode: zipcode, province: province),
      _ => throw const FormatException("User Model: Failed to load user data")
    };
  }
}