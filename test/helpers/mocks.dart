import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_architecture/core/network/dio_client.dart';
import 'package:flutter_clean_architecture/core/usecase/params.dart';
import 'package:flutter_clean_architecture/features/posts/data/datasources/posts_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_post_details_usecase.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_state.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_state.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements DioClient {}

class MockPostsRepository extends Mock implements PostsRepository {}

class MockGetPostsUseCase extends Mock implements GetPostsUseCase {}

class MockGetPostDetailsUseCase extends Mock implements GetPostDetailsUseCase {}

class MockPostsRemoteDataSource extends Mock implements PostsRemoteDataSource {}

class MockPostsCubit extends MockCubit<PostsState> implements PostsCubit {}

class MockPostDetailsCubit extends MockCubit<PostDetailsState> implements PostDetailsCubit {}

class FakeNoParams extends Fake implements NoParams {}
