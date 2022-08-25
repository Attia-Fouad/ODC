import 'Plants.dart';
import 'Seeds.dart';
import 'Tools.dart';

class BlogsData {
  BlogsData({
      this.plants, 
      this.seeds, 
      this.tools,});

  BlogsData.fromJson(dynamic json) {
    if (json['plants'] != null) {
      plants = [];
      json['plants'].forEach((v) {
        plants?.add(Plants.fromJson(v));
      });
    }
    if (json['seeds'] != null) {
      seeds = [];
      json['seeds'].forEach((v) {
        seeds?.add(Seeds.fromJson(v));
      });
    }
    if (json['tools'] != null) {
      tools = [];
      json['tools'].forEach((v) {
        tools?.add(Tools.fromJson(v));
      });
    }
  }
  List<Plants>? plants;
  List<Seeds>? seeds;
  List<Tools>? tools;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (plants != null) {
      map['plants'] = plants?.map((v) => v.toJson()).toList();
    }
    if (seeds != null) {
      map['seeds'] = seeds?.map((v) => v.toJson()).toList();
    }
    if (tools != null) {
      map['tools'] = tools?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}