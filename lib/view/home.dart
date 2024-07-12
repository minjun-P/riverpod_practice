import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/model/user.dart';
import 'package:riverpod_practice/provider/todo_provider.dart';
import 'package:riverpod_practice/provider/user_provider.dart';
import 'package:riverpod_practice/view/widgets/splash_loading_screen.dart';
import 'package:riverpod_practice/view/widgets/todo_add_form.dart';
import 'package:riverpod_practice/view/widgets/todo_list.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(userProvider, (prev, next) {
      if (next is AsyncData<User>) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text("유저 정보 불러오기를 완료했어요!")),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final todo = ref.read(todoListProvider.notifier);
    return user.when(
      data: (data) => Scaffold(
        appBar: AppBar(
          title: Text("로그인된 유저 : ${data.name}"),
          actions: switch(user) {
            AsyncData(:final value) => [
              value.goalSatisfied
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank, color: Colors.red),
            ],
            _ => [
              const Icon(Icons.sms_failed_outlined),
            ],
          },
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12).copyWith(bottom: 30),
          child: Column(
            children: [
              TodoAddForm(
                placeholder: "state invalidate 방식",
                onAdd: todo.addTodo,
              ),
              TodoAddForm(
                placeholder: "state manual update 방식",
                onAdd: todo.addTodoWithResponse,
              ),
              const Expanded(child: ClipRRect(child: TodoListWidget())),
            ],
          ),
        ),
      ),
      error: (_, __) => const Center(child: Text("error")),
      loading: () => const SplashLoadingScreen(),
    );
  }
}
