import 'Data.dart';

class ToolsModel {
  ToolsModel({
      this.type, 
      this.message, 
      this.data,});

  ToolsModel.fromJson(dynamic json) {
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ToolsData.fromJson(v));
      });
    }
  }
  String? type;
  String? message;
  List<ToolsData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}