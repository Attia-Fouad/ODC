class Data {
  Data({
      this.userId, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.imageUrl, 
      this.address, 
      this.role, 
      this.userPoints, 
      this.userNotification,});

  Data.fromJson(dynamic json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    address = json['address'];
    role = json['role'];
    userPoints = json['UserPoints'];

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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['imageUrl'] = imageUrl;
    map['address'] = address;
    map['role'] = role;
    map['UserPoints'] = userPoints;
    if (userNotification != null) {
      map['UserNotification'] = userNotification?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}