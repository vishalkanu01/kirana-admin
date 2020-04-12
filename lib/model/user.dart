class Users {
  String fullName;
  String email;
  String id;
  String location;
  String phoneNumber;
  String displayName;
  String password;

  Users();

  Users.fromMap(Map<String, dynamic> data) {
    fullName = data['fullName'];
    email = data['email'];
    id = data['id'];
    location = data['location'];
    phoneNumber = data['phoneNumber'];
  }
}
