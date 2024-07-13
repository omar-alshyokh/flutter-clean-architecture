// Project imports:
import 'package:starter/core/entity/base_entity.dart';

class PostEntity extends BaseEntity {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  const PostEntity({this.userId, this.id, this.title, this.body});

  @override
  List<Object?> get props => [];
}
