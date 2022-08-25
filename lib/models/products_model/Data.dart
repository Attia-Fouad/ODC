import 'Plant.dart';

class ProductData {
  ProductData({
      this.productId, 
      this.name, 
      this.description, 
      this.imageUrl, 
      this.type, 
      this.price, 
      this.available, 
      this.seed, 
      this.plant, 
      this.tool,});

  ProductData.fromJson(dynamic json) {
    productId = json['productId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    price = json['price'];
    available = json['available'];
    seed = json['seed'];
    plant = json['plant'] != null ? Plant.fromJson(json['plant']) : null;
    tool = json['tool'];
  }
  String? productId;
  String? name;
  String? description;
  String? imageUrl;
  String? type;
  int? price;
  bool? available;
  dynamic seed;
  Plant? plant;
  dynamic tool;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['name'] = name;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['type'] = type;
    map['price'] = price;
    map['available'] = available;
    map['seed'] = seed;
    if (plant != null) {
      map['plant'] = plant?.toJson();
    }
    map['tool'] = tool;
    return map;
  }

}