import 'package:fluent_ui/fluent_ui.dart';
import 'package:lottie/lottie.dart';

import '/models/todo.dart';
import '/widgets/edit_add_todo_dialog.dart';
import '../generated/assets.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  final List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: _getAppBar(),
      pane: _getNavigationPane(),
      // content: _getNavigationBody(),
    );
  }

  NavigationAppBar _getAppBar() {
    return NavigationAppBar(
      title: const Text(
        "Todo App",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: Row(
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              child: const Text("Add Todo"),
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => EditAddTodoContent(_addTodoItem, null),
              ),
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
    );
  }

  NavigationPane _getNavigationPane() {
    return NavigationPane(
        header: const FlutterLogo(
          style: FlutterLogoStyle.horizontal,
          size: 100,
        ),
        selected: selectedIndex,
        onChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.to_do_logo_outline),
            title: const Text('Todo'),
            body: todos.isNotEmpty
                ? _getTodoList()
                : Lottie.asset(Assets.lottie.noData.path),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const Center(
              child: Text('Settings'),
            ),
          ),
        ]);
  }

  void _addTodoItem(Todo todo) => setState(() {
        todos.add(todo);
      });

  void _deleteTodoItem(int index) => setState(() {
        todos.removeAt(index);
      });

  void editTodoItem(int index) => showDialog(
      context: context,
      builder: (ctx) {
        return EditAddTodoContent((Todo todo) {
          setState(() {
            todos[index] = todo;
          });
        }, todos[index]);
      });

  Widget _getTodoList() {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => editTodoItem(index),
            child: ListTile(
              onPressed: () {},
              title: Text(todos[index].title),
              subtitle: Text(todos[index].description),
              trailing: IconButton(
                onPressed: () => _deleteTodoItem(index),
                icon: const Icon(FluentIcons.delete),
              ),
            ),
          );
        });
  }
}
