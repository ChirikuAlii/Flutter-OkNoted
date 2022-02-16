import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:okoted/app/app_color.dart';
import 'package:okoted/presentation/widget/toolbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final snackBar = SnackBar(
    content: const Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OkNotedToolbar(Size(double.infinity, 100)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: AppColors.greyEsclipe,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: AppColors.greyEsclipe,
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
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
                            "assets/toolbar/more.svg",
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);
                  },
                  child: Container(
                      child: SvgPicture.asset(
                    "assets/ic_searchh.svg",
                    width: 32,
                    height: 24,
                  )),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);
                  },
                  child: Container(
                      margin: EdgeInsets.fromLTRB(32, 0, 16, 0),
                      child: SvgPicture.asset(
                        "assets/ic_notification.svg",
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
}
