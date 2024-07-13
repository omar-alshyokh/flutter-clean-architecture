import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/home/presentation/bloc/post_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CancelToken cancelToken;
  late final PostBloc postBloc;

  @override
  void initState() {
    super.initState();

    cancelToken = CancelToken();

    postBloc = PostBloc();
    postBloc.add(GetPostEvent(cancelToken));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        bloc: postBloc,
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetPostsSuccess) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title ?? ""),
                  subtitle: Text(post.body ?? ""),
                );
              },
            );
          } else if (state is GetPostsFailed) {
            return Center(child: Text('Error: ${state.error.message}'));
          } else {
            return const Center(child: Text('No posts available.'));
          }
        },
      ),
    );
  }
}
