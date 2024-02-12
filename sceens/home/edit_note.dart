import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_notes/models/notes_model.dart';

import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../utils/style_utils.dart';

class EditNoteScreen extends StatefulWidget {
  final NotesModel note;

  EditNoteScreen({required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
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


            ElevatedButton(
              onPressed: () {
                DateTime now = DateTime.now();

                String formattedTime = DateFormat.jm().format(now);
                NotesModel updatedNote = NotesModel(
                  id: widget.note.id,
                  title: _titleController.text,
                  date: widget.note.date,
                  category: widget.note.category,
                  time: formattedTime, notes: _noteController.text  ,
                  // Add other fields accordingly
                );
                Navigator.pop(context, updatedNote);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();

    super.dispose();
  }
}
