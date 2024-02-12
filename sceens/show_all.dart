import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_notes/models/notes_model.dart';

import '../services/db_handler.dart';
import '../utils/app_color.dart';
import '../utils/style_utils.dart';
import 'home/edit_note.dart';

class ShowAllCategory extends StatefulWidget {
  const ShowAllCategory({
    super.key,
  });

  @override
  State<ShowAllCategory> createState() => _ShowAllCategoryState();
}

class _ShowAllCategoryState extends State<ShowAllCategory> {
  final DbHandler dbHandler = DbHandler();
  Set<int> selectedIndexes = Set<int>();

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    await dbHandler.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(foregroundColor: AppColor.lightColor,
          backgroundColor: AppColor.darkColor,
          title: Text(
            'All Notes',
            style: MyAppStyle.headStyle(AppColor.lightColor),
          ),
        ),
        body: FutureBuilder<List<NotesModel>>(
          // Fetch tasks based on the selected category
          future: dbHandler.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Loading state while fetching data
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Error state
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Empty data state
              return const Center(child: Text('No tasks available'));
            } else {
              // Data available, display the list
              List<NotesModel> tasks = snapshot.data!;
              bool showAllCheckboxes = false;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      setState(() {

                        // Toggle the selection for long-press
                        if (!selectedIndexes.contains(index)) {

                          selectedIndexes.add(index);
                        } else {
                          selectedIndexes.remove(index);
                        }
                      });
                    },
                    onTap: () {
                      if (selectedIndexes.isEmpty) {
                        // If any item is selected, handle single tap
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            var size = MediaQuery.of(context).size;
                            return Container(
                              width: size.width,
                              height: size.height / 1.6,
                              color: AppColor.secondaryColor.withOpacity(0.6),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: size.width,
                                      height: size.height / 2.1,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF010101),
                                            Color(0xFF0A0A0A),
                                            Color(0xDD000000),
                                            Color(0xFF010101),
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(50),
                                          topLeft: Radius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 14,
                                    child: Text(
                                      tasks[index].title!,
                                      style: MyAppStyle.headStyle(
                                          AppColor.darkColor),
                                    ),
                                  ),
                                  Positioned(
                                    top: size.height / 10,
                                    child: Container(
                                      width: size.width * 0.88,
                                      // 5% of screen width as padding

                                      child: Text(
                                        tasks[index].notes!,
                                        style: MyAppStyle.btnStyle(
                                            AppColor.lightColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        setState(
                          () {
                            if (selectedIndexes.contains(index)) {
                              selectedIndexes.remove(index);
                            } else {
                              selectedIndexes.add(index);
                            }
                          },
                        );
                        // Handle normal tap (without any item selected)
                        // Show details or perform other actions
                      }
                    },
                    onDoubleTap: () {
                      // Handle double-tap to uncheck the specific item
                      setState(() {
                        selectedIndexes.remove(index);
                      });
                    },
                    child: ListTile(
                      title: Text(tasks[index].title!),
                      subtitle: Text(tasks[index].date.toString()),
                      trailing: selectedIndexes.contains(index)
                          ? Checkbox(
                              value: selectedIndexes.contains(index),
                              onChanged: (value) {
                                setState(
                                  () {
                                    if (value != null) {
                                      if (value) {
                                        selectedIndexes.add(index);
                                      } else {
                                        selectedIndexes.remove(index);
                                      }
                                    }
                                  },
                                );
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editNote(tasks[index]);
                              },
                            ),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          _deleteSelectedNotes();
        }, child: Icon(Icons.delete),),
      ),
    );
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



  void _deleteSelectedNotes() async {
    // Convert the set to a list and sort it
    List<int> sortedIndexes = selectedIndexes.toList()..sort();

    // Iterate through the sorted indexes and delete notes
    for (var idx in sortedIndexes) {
      await dbHandler.deleteNotesByIndex(idx);
    }

    if (mounted) {
      setState(() {
        fetchNotes();
        selectedIndexes.clear();
      });
    }
  }


}
