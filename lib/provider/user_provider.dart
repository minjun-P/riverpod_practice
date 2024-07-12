import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/model/user.dart';
import 'package:riverpod_practice/provider/todo_provider.dart';
import 'package:riverpod_practice/repository/user_repository.dart';
import 'package:riverpod_practice/utils/logger.dart';

part 'user_provider.g.dart';

@riverpod
Future<User> user(UserRef ref) async {
  logProvider("user view model get data");
  // TODO 아래 코드는 개선해야할 부분이 존재함.
  // 먼저 의도를 설명하자면, todo가 변경될 때마다 user도 다시 불러오는 것이다.
  // 다만
  // 1. 첫 fetch시에는 todo를 기다리지 않아야 한다. 아래 코드 때문에 원래 순차적으로 유저를 불러오고,
  // todo를 불러오던 동작이 변경되었다. todo가 다 불러오고 난 뒤에야 유저가 불러와진다.
  // 2. 두번째로, todo가 변경될 때마다 유저를 불러오는 것은 비효율적이다.
  // 권장은 특정 트리거 조건일 때만 refetch를 하도록 하는 것이다. 가령 todo list의 check 변경 로직시에만
  // 확인을 한다거나
  final todos = await ref.watch(todoListProvider.future);
  logProvider("user view model listen todos change : $todos");
  final userRepo = UserRepository();
  return userRepo.getUser();
}

