// bloc/post_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/PostRepository.dart';
import 'PostEvent.dart';
import 'PostState.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
