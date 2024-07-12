import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/model/todo.dart';
import 'package:riverpod_practice/provider/comment_provider.dart';

class CommentScreen extends ConsumerWidget {
  final Todo todo;

  const CommentScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(commentListProvider(todo.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text("댓글 화면"),
        bottom: PreferredSize(
          preferredSize: Size(double.maxFinite, 50),
          child: Container(
            width: double.maxFinite,
            color: Colors.green.shade50,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("선택된 할일 : ${todo.title}", style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(commentListProvider(todo.id).future);
        },
        child: Center(
          child: switch(comments) {
            AsyncData(:final value) => value.isNotEmpty?  ListView(
              children: value.map((e) => ListTile(
                title: Text(e.content),
                subtitle: Text("댓글임 id:${e.id}"),
              )).toList(),
            ) : const Center(child: Text("댓글이 없습니다.")),
            AsyncError(:final error) => Text(error.toString()),
            _ => const CircularProgressIndicator(),
          },
        ),
      ),
    );
  }
}
