import 'package:flutter_clean_architecture/core/entity/base_entity.dart';

class PostEntity extends BaseEntity {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [userId, id, title, body];
}
