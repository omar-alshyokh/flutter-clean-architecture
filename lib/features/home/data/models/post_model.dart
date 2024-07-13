import 'package:json_annotation/json_annotation.dart';
import 'package:starter/core/model/base_model.dart';
import 'package:starter/features/home/domain/entity/post_entity.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class PostModel extends BaseModel<PostEntity> {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostModel({this.userId, this.id, this.title, this.body});

  /// Connect the generated [_$PostModelFromJson] function to the `fromJson`
  /// factory.
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  /// Connect the generated [_$PostModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  PostEntity toEntity() {
    return PostEntity(userId: userId, id: id, title: title, body: body);
  }
}
