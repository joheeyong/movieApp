// screens/post_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/PostBloc.dart';
import '../bloc/PostEvent.dart';
import '../bloc/PostState.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (_, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Press button to fetch posts'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PostBloc>().add(FetchPosts()),
        child: const Icon(Icons.download),
      ),
    );
  }
}
