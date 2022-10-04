import 'package:flutter/material.dart';

class DropButton extends StatefulWidget {
  @override
  _DropButtonState createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  List<Map<String, dynamic>> taxesGroups = [
    {
      "name": "asset/image/ad.png",
      "taxes": "Spain",
    },
    {
      "name": "asset/image/category.png",
      "taxes": " uk",
    },
    {
      "name": "asset/image/ad.png",
      "taxes": "usa",
    },
    {
      "name": "asset/image/category.png",
      "taxes": "india",
    },
  ];
  bool isCheck = false;
  var dropdownValue;

  @override
  void initState() {
    dropdownValue = taxesGroups[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropCustom"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                isCheck = true;
                print("valueis---$isCheck");
                setState(() {});
              },
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add),
                    const Text("hello"),
                    const Spacer(),
                    isCheck != true ? const Icon(Icons.arrow_drop_down_rounded) : const SizedBox(),
                  ],
                ),
              ),
            ),
            isCheck == true
                ? Container(
                    height: 130,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: ListView.separated(
                      itemCount: taxesGroups.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("list  -${taxesGroups[index]["name"].toString()}");
                        print("list  -${taxesGroups[index]["taxes"].toString()}");
                        return GestureDetector(
                          onTap: () {
                            isCheck = false;
                            setState(() {});
                            print("valueis---$isCheck");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Image.asset(taxesGroups[index]["name"].toString(), height: 20),
                                  const SizedBox(width: 10),
                                  Text(taxesGroups[index]["taxes"].toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
