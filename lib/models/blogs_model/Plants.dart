class Plants {
  Plants({
      this.plantId, 
      this.name, 
      this.description, 
      this.imageUrl, 
      this.waterCapacity, 
      this.sunLight, 
      this.temperature,});

  Plants.fromJson(dynamic json) {
    plantId = json['plantId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    waterCapacity = json['waterCapacity'];
    sunLight = json['sunLight'];
    temperature = json['temperature'];
  }
  String? plantId;
  String? name;
  String? description;
  String? imageUrl;
  int? waterCapacity;
  int? sunLight;
  int? temperature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['plantId'] = plantId;
    map['name'] = name;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['waterCapacity'] = waterCapacity;
    map['sunLight'] = sunLight;
    map['temperature'] = temperature;
    return map;
  }

}