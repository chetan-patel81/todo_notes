import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_notes/utils/app_color.dart';
import 'package:todo_notes/utils/app_string.dart';
import 'package:todo_notes/utils/style_utils.dart';
import 'package:intl/intl.dart';

import '../../models/notes_model.dart';

import '../../services/db_handler.dart';
import 'category.dart';

class CreateNote extends StatefulWidget {
  final ValueChanged<NotesModel> onCreate;

  const CreateNote({super.key, required this.onCreate});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  DbHandler dbHandler = DbHandler();

  // final List<NotesModel> tasks = [];
  String _selectedCategory = 'Default'; // Default category

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {
            _addNote();
          }, // Connect the button to the addNote function,
          child: const Text("Add Note"),
        ),
        backgroundColor: AppColor.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColor.darkColor,
          title: Text(
            "Create Note",
            style: MyAppStyle.headStyle(AppColor.lightColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Title",
                  style: MyAppStyle.titleStyle(AppColor.darkColor),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.lightColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _titleController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: AppStrings.enterTask,
                        icon: Icon(CupertinoIcons.doc_append),
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppStrings.heading1,
                  style: MyAppStyle.titleStyle(AppColor.darkColor),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.lightColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _noteController,
                    maxLines: 100,
                    minLines: 1,
                    decoration: const InputDecoration(
                        hintText: AppStrings.enterTask,
                        icon: Icon(CupertinoIcons.doc_append),
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: <String>[
                      'Default',
                      'Personal',
                      'Work',
                      'Wishlist',
                      'Birthday'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addNote() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      DateTime now = DateTime.now();
      String formattedTime = DateFormat.jm().format(now);

      // Create a Task object with entered details
      NotesModel newNote = NotesModel(
        title: _titleController.text,
        notes: _noteController.text,
        date: DateFormat.yMMMMEEEEd().format(DateTime.now()),
        category: _selectedCategory,
        time: formattedTime,
      );

      try {
        // Ensure customTime is formatted correctly before storing
        await dbHandler.createNote(newNote);
        widget.onCreate(newNote);

        // Clear text controllers and reset selected date/time
        _noteController.clear();
        _titleController.clear();
//"Add Note" button to navigate to the corresponding category page based on the selected category.

        // Navigate to the selected category page
        _navigateToCategoryPage(_selectedCategory);
      } catch (e) {
        // Handle the error (show an error message to the user)
        print("Error creating note: $e");
      }
    } else {
      // Show an error message if title or note is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Title and note cannot be empty.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  //disposed to prevent memory leaks.
  // the dispose method of _BirthDayScreenState class.
  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();

    super.dispose();
  }

  Future<void> _navigateToCategoryPage(String category) async {
    switch (category) {
      case 'Personal':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoryTasksPage(category: 'Personal'),
          ),
        );
        // Navigate to Personal category page
        break;
      case 'Work':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoryTasksPage(category: 'Work'),
          ),
        );
        // Navigate to Work category page
        break;

      case 'Wishlist':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoryTasksPage(category: 'Wishlist'),
          ),
        );
        // Navigate to Wishlist category page
        break;
      case 'Birthday':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoryTasksPage(category: 'Birthday'),
          ),
        );
        // Navigate to Birthday category page
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoryTasksPage(category: 'Default'),
          ),
        );
        break;
    }
  }
}
//make option in selected to save in  page = personal,work,custom,wishlist,birthday
