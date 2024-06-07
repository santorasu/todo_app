import 'package:flutter/material.dart';
import 'package:simple_todo/utils/todo_list.dart';

// Defining a stateful widget for the HomePage.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Defining the state class for HomePage.
class _HomePageState extends State<HomePage> {
  // Creating a controller for the text field to handle input.
  final _controller = TextEditingController();

  // Initializing a list of to-do items with their completion status.
  List toDoList = [
    ['Code With Otabek', true],
    ['Learn Flutter', true],
    ['Drink Coffee', false],
    ['Explore Firebase', false],
  ];

  // Function to toggle the completion status of a to-do item.
  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1]; // Invert the completion status.
    });
  }

  // Function to add a new task to the to-do list.
  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]); // Add the new task with completion status set to false.
      _controller.clear(); // Clear the text field.
    });
  }

  // Function to delete a task from the to-do list.
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index); // Remove the task at the specified index.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300, // Setting the background color of the Scaffold.
      appBar: AppBar(
        title: const Text(
          'Simple Todo',
          textAlign: TextAlign.center, // Center the title text within the Text widget.
        ),
        backgroundColor: Colors.deepPurple, // Setting the background color of the AppBar.
        foregroundColor: Colors.white, // Setting the color of the AppBar's text and icons.
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length, // Number of items in the to-do list.
              itemBuilder: (BuildContext context, index) {
                return TodoList(
                  taskName: toDoList[index][0], // Task name.
                  taskCompleted: toDoList[index][1], // Task completion status.
                  onChanged: (value) => checkBoxChanged(index), // Function to handle checkbox changes.
                  deleteFunction: (context) => deleteTask(index), // Function to handle task deletion.
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller, // Assigning the controller to the TextField.
                    decoration: InputDecoration(
                      hintText: 'Add a new task', // Hint text displayed in the TextField.
                      filled: true, // Enable the filled background color.
                      fillColor: Colors.deepPurple.shade200, // Setting the background color of the TextField.
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.deepPurple, // Border color when the TextField is enabled.
                        ),
                        borderRadius: BorderRadius.circular(15), // Rounded corners for the enabled border.
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.deepPurple, // Border color when the TextField is focused.
                        ),
                        borderRadius: BorderRadius.circular(15), // Rounded corners for the focused border.
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15), // Adds space between the TextField and FloatingActionButton.
                FloatingActionButton(
                  onPressed: saveNewTask, // Function to call when the button is pressed.
                  child: const Icon(Icons.add), // Icon displayed on the FloatingActionButton.
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
