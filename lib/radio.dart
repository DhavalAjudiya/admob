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
        ],
      ),
    );
  }
}
