// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:starter/core/entity/empty_result_entity.dart';
import 'package:starter/core/model/base_model.dart';

// Project imports:


part 'empty_result_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class EmptyResultModel extends BaseModel<EmptyResultEntity> {
  final String? message;

  EmptyResultModel({this.message});

  factory EmptyResultModel.fromJson(Map<String, dynamic> json) =>
      _$EmptyResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyResultModelToJson(this);

  @override
  EmptyResultEntity toEntity() {
    return EmptyResultEntity(
      message: message ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmptyResultModel && message == other.message;
  }

  @override
  int get hashCode {
    return message.hashCode;
  }

  @override
  String toString() {
    return "EmptyResultModel(message: $message)";
  }
}
