import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReversCounDown extends StatefulWidget {
  const ReversCounDown({Key? key}) : super(key: key);

  @override
  State<ReversCounDown> createState() => _ReversCounDownState();
}

class _ReversCounDownState extends State<ReversCounDown> {
  int dateFormat(int time, String format) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
    String result = '';
    final DateFormat formatter = DateFormat(format);
    result = formatter.format(date);
    DateTime parseDate = DateFormat(format).parse(result);
    return parseDate.millisecondsSinceEpoch;
  }

  Timer? _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () {
              startTimer();
            },
            child: const Text("start"),
          ),
          const SizedBox(height: 10),
          Text("$_start"),
          const SizedBox(height: 10),
          Center(
            child: TweenAnimationBuilder<Duration>(
              duration: const Duration(milliseconds: 1668452400545454545),
              tween: Tween(
                begin: const Duration(milliseconds: 1668452400545454545),
                end: Duration.zero,
              ),
              onEnd: () {
                print('Timer ended');
              },
              builder: (
                BuildContext context,
                Duration value,
                Widget? child,
              ) {
                final hour = value.inHours % 12;
                final minutes = value.inMinutes % 60;
                final seconds = value.inSeconds % 60;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    '$hour:$minutes:$seconds',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
