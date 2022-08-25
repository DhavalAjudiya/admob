import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Radioa extends StatefulWidget {
  const Radioa({Key? key}) : super(key: key);

  @override
  State<Radioa> createState() => _RadioaState();
}

class _RadioaState extends State<Radioa> {
  String? _radioValue; //Initial definition of radio button value
  // String? choice;
  bool chan = false;
  bool isCheck = false;
  bool isDone = false;
  bool isDone1 = false;
  bool isDone2 = false;
  bool isClear = false;
  String select = "";

  // ------ [add the next block] ------
  @override
  void initState() {
    setState(() {
      _radioValue = "one";
    });
    super.initState();
  }

  // ------ end: [add the next block] ------

  // void radioButtonChanges(String? value) {
  //   setState(() {
  //     _radioValue = value;
  //     switch (value) {
  //       case 'one':
  //         choice = value;
  //         break;
  //       case 'two':
  //         choice = value;
  //         break;
  //       case 'three':
  //         choice = value;
  //         break;
  //       // case 'all':
  //       //   choice = value;
  //       //   break;
  //       default:
  //         choice = "";
  //     }
  //     debugPrint(choice); //Debug the choice in console
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  chan = !chan;
                  print("changeallvalue----$chan");
                  setState(() {});
                });
              },
              child: Text("all")),
          Row(
            children: <Widget>[
              Radio(
                value: chan == true ? "all" : 'one',
                groupValue: _radioValue,
                onChanged: (String? value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
              const Text(
                "One selected",
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: chan == true ? "all" : 'two',
                groupValue: _radioValue,
                onChanged: (String? value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
              const Text(
                "two selected",
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: chan == true ? "all" : 'three',
                groupValue: _radioValue,
                onChanged: (String? value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
              const Text(
                "three selected",
              ),
            ],
          ),
          CheckboxListTile(
            title: const Text('Animate Slowly'),
            value: timeDilation != 1.0,
            onChanged: (bool? value) {
              setState(() {
                timeDilation = value! ? 2.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5,
                  offset: Offset(1, 6),
                ),
              ])),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: 200,
            color: Colors.transparent,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 40,
                      color: Colors.transparent,
                      width: 22,
                    ),
                    const Positioned(
                      child: CircleAvatar(
                        backgroundImage: AssetImage("asset/image/ad.png"),
                        radius: 20,
                        backgroundColor: Colors.transparent,
                      ),
                      left: 0,
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCheck = true;
                    });
                  },
                  child: SizedBox(
                    child: isClear == true
                        ? Text("Hint Text")
                        : select.isEmpty
                            ? Text("Hint Text")
                            : Text(select),
                  ),
                ),
                Spacer(),
                isClear == true
                    ? const Icon(
                        Icons.arrow_drop_down,
                        size: 18,
                      )
                    : select.isEmpty
                        ? const Icon(
                            Icons.arrow_drop_down,
                            size: 18,
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                isClear = true;
                                isCheck = false;

                                // isClear = false;

                                print("isClear ${isClear}");
                              });
                              Future.delayed(Duration(seconds: 1), () {
                                isClear = false;
                                print("isClear ${isClear}");
                              });
                            },
                            child: const Icon(Icons.close, size: 18),
                          ),
              ]),
            ),
          ),
          SizedBox(height: 15),
          isCheck == true
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 90,
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDone = true;
                              isDone1 = false;
                              isDone2 = false;

                              select = "First Text";
                              isCheck = false;
                            });
                          },
                          child: Container(
                            color: isDone == true ? Colors.green.withOpacity(0.1) : Colors.transparent,
                            height: 23,
                            child: Row(children: [
                              isDone == true ? Icon(Icons.done, size: 20) : const SizedBox(width: 20),
                              const Text("First Text"),
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDone = false;
                              isDone1 = true;
                              isDone2 = false;

                              select = "Second Text";
                              isCheck = false;
                            });
                          },
                          child: Container(
                            color: isDone1 == true ? Colors.green.withOpacity(0.1) : Colors.transparent,
                            height: 23,
                            child: Row(children: [
                              isDone1 == true ? Icon(Icons.done, size: 20) : const SizedBox(width: 20),
                              Text("Second Text"),
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDone = false;
                              isDone1 = false;
                              isDone2 = true;

                              select = "third Text";
                              isCheck = false;
                            });
                          },
                          child: Container(
                            color: isDone2 == true ? Colors.green.withOpacity(0.1) : Colors.transparent,
                            height: 23,
                            child: Row(children: [
                              isDone2 == true ? Icon(Icons.done, size: 20) : const SizedBox(width: 20),
                              Text("third Text"),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
