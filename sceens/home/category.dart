import 'package:flutter/material.dart';
import 'package:todo_notes/models/notes_model.dart';
import 'package:todo_notes/utils/app_color.dart';
import 'package:todo_notes/utils/style_utils.dart';

import '../../services/db_handler.dart';
import 'edit_note.dart';

class CategoryTasksPage extends StatefulWidget {
  final String category;

  const CategoryTasksPage({super.key, required this.category});

  @override
  State<CategoryTasksPage> createState() => _CategoryTasksPageState();
}

class _CategoryTasksPageState extends State<CategoryTasksPage> {
  late ValueNotifier<List<NotesModel>> _tasksNotifier;
  final DbHandler dbHandler = DbHandler();

  Future<void> fetchNotes() async {
    List<NotesModel> fetchedProducts =
        await dbHandler.getNotesByCategory(widget.category);
    _tasksNotifier.value = fetchedProducts;
  }

  @override
  void initState() {
    super.initState();
    _tasksNotifier = ValueNotifier<List<NotesModel>>([]);
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(foregroundColor: AppColor.lightColor,
          backgroundColor: AppColor.darkColor,
          title: Text(
            ' ${widget.category}',
            style: MyAppStyle.headStyle(AppColor.lightColor),
          ),
        ),
        body: ValueListenableBuilder<List<NotesModel>>(
          // Fetch tasks based on the selected category
          valueListenable: _tasksNotifier,
          builder: (context, tasks, _) {
            if (tasks.isEmpty) {
              return Center(
                child: Text('No tasks available for ${widget.category}'),
              ); // or a loading indicator
            } else {



              return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {





                    return ListTile(
                      title: Text(tasks[index].title!),

                      subtitle:Column(children: [
                        const SizedBox(height: 20),
                        Text(tasks[index].notes!),
                        const SizedBox(height: 20),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(tasks[index].date.toString()),
                            const SizedBox(height: 20),
                          Text(tasks[index].time.toString())


                          ],
                        ),




                      ],),


                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _editNote(tasks[index]);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Note'),
                                content: const Text('Are you sure you want to delete this note?'),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () async {
                                      await dbHandler.deleteNotesByIndex(index);
                                      // Check if the widget is still mounted before calling setState
                                      if (mounted) {
                                        setState(() {
                                          fetchNotes();
                                        });
                                      }

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ]),
                    );
                  },

              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tasksNotifier.dispose();
    super.dispose();
  }



  void _editNote(NotesModel note) async {
    final updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(note: note),
      ),
    );

    if (updatedNote != null) {
      await dbHandler.updateNotes(updatedNote);
      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          fetchNotes();
        });
      }
    }
  }



}

