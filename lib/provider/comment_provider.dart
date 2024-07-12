import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/model/comment.dart';
import 'package:riverpod_practice/repository/comment_repository.dart';
import 'package:riverpod_practice/utils/logger.dart';

part 'comment_provider.g.dart';

// 그냥 깡으로 keepAlive True로 해놓았다. 이렇게 하면 한번 불러온 Provider와 불러와진 값이 계속 유지된다.
// 즉, 한번 불러온 데이터는 invalidate를 하지 않는다면 계속 보관된 상태로 존재한다.
@Riverpod(keepAlive: true)
class CommentList extends _$CommentList {
  @override
  FutureOr<List<Comment>> build(String todoId) async {
    logProvider("comment view model get data");
    // 받은 인수는 this.todoID 이렇게 따로 접근도 가능하다.
    return CommentRepository().fetchCommentsByTodoId(todoId);
  }
}
