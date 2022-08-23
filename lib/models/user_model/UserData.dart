class UserData {
  UserData({
      this.userId, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.imageUrl, 
      this.address, 
      this.role, 
      this.userPoints, 
      this.userNotification,});

  UserData.fromJson(dynamic json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    address = json['address'];
    role = json['role'];
    userPoints = json['UserPoints'];
    if (json['UserNotification'] != null) {
      userNotification = [];
      json['UserNotification'].forEach((v) {
        userNotification?.add(v);
      });
    }
  }
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  dynamic address;
  String? role;
  dynamic userPoints;
  List<dynamic>? userNotification;

}