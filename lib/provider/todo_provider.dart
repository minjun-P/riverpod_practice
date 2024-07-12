import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/model/todo.dart';
import 'package:riverpod_practice/repository/todo_repository.dart';
import 'package:riverpod_practice/utils/logger.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  FutureOr<List<Todo>> build() async {
    logProvider("todo view model get data");
    return TodoRepository().fetchTodos();
  }
  /// 업데이트 이후, 로컬 데이터 Invalidate하는 예제
  Future<void> addTodo(String title) async {
    logProvider("todo view model 'addTodo'");
    // 현재 state를 loading으로 치환할 수도 있음.
    state = const AsyncLoading();

    final repo = TodoRepository();
    await repo.addTodo(Todo.newOne(title));
    ref.invalidateSelf();
    await future;
  }

  /// 로컬 데이터 수동 업데이트 예제
  Future<void> addTodoWithResponse(String title) async {
    logProvider("todo view model 'addTodoWithResponse'");
    final repo = TodoRepository();
    final newTodo = await repo.addTodo(Todo.newOne(title));

    // 새로 불러온다는 소리가 아니라, 혹시 우연히 로딩 상태일 수 있으니 일단 future로 처리하는 듯 하다.
    final previousState = await future;
    state = AsyncData([...previousState, newTodo]);
  }

  Future<void> updateIsDone(String id, bool isDone) async {
    logProvider("todo view model 'updateIsDone'");
    final repo = TodoRepository();
    final updatedTodo = await repo.updateIsDone(id, isDone);

    final previousState = await future;
    final newState = previousState.map((e) => e.id == id ? updatedTodo : e).toList();
    state = AsyncData(newState);
  }
}

