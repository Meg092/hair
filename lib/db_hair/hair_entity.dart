import 'dart:typed_data';

class HairEntity {
  int id;
  DateTime createdTime;
  Uint8List image;

  HairEntity({
    required this.id,
    required this.createdTime,
    required this.image,
  });

  factory HairEntity.fromJson(Map<String, dynamic> json) {
    return HairEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'image': image,
    };
  }
}