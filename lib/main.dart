import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrailMark',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final TextEditingController _todoController = TextEditingController();
  final List<TodoItem> _todos = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addTodo() {
    if (_todoController.text.isEmpty) return;
    
    setState(() {
      _todos.add(TodoItem(text: _todoController.text));
      _todoController.clear();
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TrailMark'),
      ),
      body: _selectedIndex == 0 ? _buildTodoList() : _buildCounter(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.numbers),
            label: 'Counter',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildTodoList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _todoController,
                  decoration: const InputDecoration(
                    hintText: 'Add a new todo',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _addTodo,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: _todos[index].isCompleted,
                  onChanged: (_) => _toggleTodo(index),
                ),
                title: Text(
                  _todos[index].text,
                  style: TextStyle(
                    decoration: _todos[index].isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCounter() {
    return const Center(
      child: Text(
        'Counter tab coming soon!',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }
}

class TodoItem {
  String text;
  bool isCompleted;

  TodoItem({required this.text, this.isCompleted = false});
}