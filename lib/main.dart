import 'package:flutter/material.dart';
import 'models/task.dart';
import 'widgets/task_tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-Do List',
      home: TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [];
  final TextEditingController controller = TextEditingController();

  void addTask(String title) {
    if (title.trim().isEmpty) return;

    setState(() {
      tasks.add(Task(title: title));
      controller.clear();
    });
  }

  void toggleTask(Task task, bool? value) {
    setState(() {
      task.toggleDone();
    });
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 208, 208),
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => TaskTile(
                task: tasks[index],
                onChanged: (val) => toggleTask(tasks[index], val),
                onDelete: () => deleteTask(tasks[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter new task',
                      filled: true,
                      fillColor: Colors.white
                    ),
                    onSubmitted: addTask,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => addTask(controller.text),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
