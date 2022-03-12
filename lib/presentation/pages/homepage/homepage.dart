import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:okoted/app/app_color.dart';
import 'package:okoted/app/app_vector.dart';
import 'package:okoted/data/local/dao/note_dao.dart';
import 'package:okoted/data/local/box/note_model.dart';
import 'package:okoted/presentation/widget/toolbar.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleEditController = TextEditingController();
  final descEditController = TextEditingController();

  final snackBar = SnackBar(
    content: const Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OkNotedToolbar(Size(double.infinity, 100)),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ValueListenableBuilder<Box<NoteModel>>(
            valueListenable: NoteDao.noteBox.listenable(),
            builder: (context, data, _) {
              var items = data.values.toList().cast<NoteModel>();

              if (items.isEmpty) {
                return Center(
                  child: Text("Empty"),
                );
              } else {
                return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: widgetListNote(items[index]),
                        onTap: () => {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              context: context,
                              builder: (context) {
                                return widgetDetailNote(items[index]);
                              })
                        },
                      );
                    });
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              context: context,
              builder: (context) {
                return widgetModalBottomSheetAddNote();
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: AppColors.greyEsclipe,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: AppColors.greyEsclipe,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: SvgPicture.asset(
                            AppVectors.more,
                            color: Colors.white,
                            width: 32,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                      child: SvgPicture.asset(
                    AppVectors.search,
                    width: 32,
                    height: 24,
                  )),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                      margin: EdgeInsets.fromLTRB(32, 0, 16, 0),
                      child: SvgPicture.asset(
                        AppVectors.notification,
                        color: Colors.white,
                        width: 32,
                        height: 24,
                      )),
                ),
              ],
            ),
          )),
    );
  }

  Widget widgetModalBottomSheetAddNote() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: titleEditController,
            cursorColor: AppColors.greyDim,
            style: TextStyle(fontSize: 20, color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Task name",
                hintStyle: TextStyle(color: AppColors.greyDim)),
          ),
          TextField(
            controller: descEditController,
            cursorColor: AppColors.greyDim,
            style: TextStyle(fontSize: 16, color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Description",
                hintStyle: TextStyle(color: AppColors.greyDim)),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 2, color: AppColors.whiteGainsboro)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Inbox",
                    style: TextStyle(fontSize: 16, color: AppColors.greyDim),
                  ),
                ),
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  final noteModel = NoteModel(
                      title: titleEditController.text,
                      date: DateTime.now().toString(),
                      desc: descEditController.text,
                      project: "Personal");
                  addNote(noteModel);
                },
                child: Icon(
                  Icons.send_outlined,
                  color: AppColors.greyDark,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget widgetListNote(NoteModel item) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(item.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                convertFormatDate(
                    item.date, "yyyy-MM-dd HH:mm:ss", "dd-MM-yyyy"),
                style: TextStyle(color: AppColors.greyDark, fontSize: 15),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(child: Container()),
              Text(item.project),
              SizedBox(
                width: 8,
              ),
              Container(
                  width: 8,
                  height: 8.0,
                  decoration: new BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ))
            ],
          ),
          Divider(
            color: Color(0xFF9C9B9B),
            height: 16,
          )
        ],
      ),
    );
  }

  Widget widgetDetailNote(NoteModel item) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      margin: EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  width: 8,
                  height: 8.0,
                  decoration: new BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  )),
              SizedBox(
                width: 8,
              ),
              Text(item.project),
              Expanded(child: Container()),
              Text(
                convertFormatDate(
                    item.date, "yyyy-MM-dd HH:mm:ss", "dd-MM-yyyy"),
                style: TextStyle(color: AppColors.greyDim, fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            item.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            item.desc,
            style: TextStyle(color: AppColors.greyDim, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Future addNote(NoteModel note) async {
    setState(() {
      NoteDao.addNote(note);
      Navigator.of(context).pop();
      //items.add(note);
    });
  }

  String convertFormatDate(
      String dateTime, String sourceFormat, String resultFormat) {
    var dateTimeOld = DateFormat(sourceFormat).parse(dateTime);
    var dateTimeNew = DateFormat(resultFormat).format(dateTimeOld);

    print("date beofre ${dateTimeOld.toString()},, date after ${dateTimeNew}");
    return dateTimeNew;
  }

  @override
  void dispose() {
    titleEditController.dispose();
    descEditController.dispose();
    NoteDao.noteBox.close();
    super.dispose();
  }
}
