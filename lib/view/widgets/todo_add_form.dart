import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/provider/todo_provider.dart';

class TodoAddForm extends ConsumerStatefulWidget {
  final String placeholder;
  final Future<void> Function(String) onAdd;

  const TodoAddForm({
    super.key,
    required this.placeholder,
    required this.onAdd,
  });

  @override
  ConsumerState createState() => _TodoAddFormState();
}

class _TodoAddFormState extends ConsumerState<TodoAddForm> {
  late final TextEditingController _controller;
  // 보류 중인 특정 작업에 대한 future를 둘 수 있다.
  // 보류 중인 작업이 없는 경우에는 이것을 Null로 관리할 것이다.
  Future<void>? _pendingAddTodo;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, ),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          FutureBuilder(
            future: _pendingAddTodo,
            builder: (context, snapshot) {
              final isError = snapshot.hasError && snapshot.connectionState != ConnectionState.waiting;
              final isLoading = snapshot.connectionState == ConnectionState.waiting;

              return IconButton(
                icon: isLoading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.add),
                onPressed: () {
                  if (_controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(child: Text("내용을 입력해주세요!")),
                      ),
                    );
                    return;
                  }
                  setState(() {
                    _pendingAddTodo = widget.onAdd(_controller.text);
                  });
                  _controller.text = "";
                },
              );
            }
          ),
        ],
      ),
    );
  }
}
