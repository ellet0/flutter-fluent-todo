import 'package:fluent_ui/fluent_ui.dart';

import '../models/todo.dart';

class EditAddTodoContent extends StatefulWidget {
  const EditAddTodoContent(this.onSendClick, this.todoEdit, {Key? key})
      : super(key: key);

  final Function onSendClick;
  final Todo? todoEdit;

  @override
  State<EditAddTodoContent> createState() => _EditAddTodoContentState();
}

class _EditAddTodoContentState extends State<EditAddTodoContent> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool _isFinished = false;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    if (widget.todoEdit != null) {
      titleController.text = widget.todoEdit!.title;
      descriptionController.text = widget.todoEdit!.description;
      _isFinished = widget.todoEdit!.isFinished;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.todoEdit == null ? 'Add Todo' : 'Edit Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBox(
            controller: titleController,
            placeholder: 'Title',
            minLines: 1,
            maxLines: 1,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),
          TextBox(
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            placeholder: 'Description',
            textInputAction: TextInputAction.next,
            onSubmitted: (value) => _sendTodo(),
          ),
          const SizedBox(height: 20),
          Checkbox(
            content: const Text('Is finished'),
            checked: _isFinished,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _isFinished = value;
              });
            },
          )
        ],
      ),
      actions: [
        HyperlinkButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        HyperlinkButton(
            onPressed: _sendTodo,
            child: Text(widget.todoEdit != null ? 'Edit' : 'Create')),
      ],
    );
  }

  void _sendTodo() {
    String title = titleController.text;
    String description = descriptionController.text;
    final todo =
        Todo(title: title, description: description, isFinished: _isFinished);
    widget.onSendClick(todo);
    Navigator.pop(context);
  }
}
