import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_notes/sceens/home/category.dart';
import 'package:todo_notes/sceens/home/widgets/home_card.dart';
import '../../global_widgets/animated_button/action_button.dart';
import '../../global_widgets/animated_button/expandeble_fab.dart';
import '../../models/notes_model.dart';
import '../../utils/app_images.dart';
import '../../utils/media_query_utils.dart';
import '../show_all.dart';
import 'create_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          "ToDoAPP",
        )),
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: HomeCard(
                    title: "Work",
                    image: AppImages.imgWork,

                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoryTasksPage(
                              category: 'Work',
                            ),
                          ));
                    },
                  )),
                  Flexible(
                      child: HomeCard(
                    title: "Wishlist",
                    image: AppImages.imgWishlist,

                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoryTasksPage(
                              category: 'Wishlist',
                            ),
                          ));
                    },
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: HomeCard(
                title: "Default",
                image: AppImages.custom,

                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryTasksPage(
                          category: 'Default',
                        ),
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: HomeCard(
                    title: "Personal",
                    image: AppImages.imgPersonal,

                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoryTasksPage(
                              category: 'Personal',
                            ),
                          ));
                    },
                  )),
                  Flexible(
                      child: HomeCard(
                    title: "Birthday",
                    image: AppImages.imgBirthday,

                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoryTasksPage(
                              category: 'Birthday',
                            ),
                          ));
                    },
                  )),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: ExpandableFab(
          distance: 120,
          children: [

            ActionButton(
              icon: const Icon(
                Icons.category_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowAllCategory(),));
              },
            ),
            ActionButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNote(
                        onCreate: (NotesModel value) {
                          // You can add any logic you need here.
                          print('Note created: $value');
                        },
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
