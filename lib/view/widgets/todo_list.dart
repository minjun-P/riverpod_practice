import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/model/todo.dart';
import 'package:riverpod_practice/provider/todo_provider.dart';
import 'package:riverpod_practice/view/comment_screen.dart';

class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(todoListProvider);
    return switch (res) {
      AsyncData(:final value) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: value.map((e) => TodoTile(todo: e)).toList(),
            ),
          ),
        ),
      AsyncError(:final error) => Center(child: Text(error.toString())),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class TodoTile extends ConsumerStatefulWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  @override
  ConsumerState createState() => _TodoTileState();
}

class _TodoTileState extends ConsumerState<TodoTile> {
  Future<void>? _pendingUpdateIsDone;

  @override
  Widget build(BuildContext context) {
    final todo = widget.todo;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text("할일 : ${todo.title}"),
        subtitle: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CommentScreen(todo: todo))
            );
          },
          child: const Text("댓글 확인하기"),
        ),
        trailing: FutureBuilder(
            future: _pendingUpdateIsDone,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(),
                );
              }
              return Checkbox(
                value: todo.isDone,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _pendingUpdateIsDone = ref
                          .read(todoListProvider.notifier)
                          .updateIsDone(todo.id, value);
                    });
                  }
                },
              );
            }),
      ),
    );
  }
}
