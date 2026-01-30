import 'package:flutter_clean_architecture/core/usecase/params.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_post_details_usecase.dart';
import 'package:mocktail/mocktail.dart';

void registerTestFallbacks() {
  registerFallbackValue(const NoParams());
  registerFallbackValue(const PostIdParams(1));
}
