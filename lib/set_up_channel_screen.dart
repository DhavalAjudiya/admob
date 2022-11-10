import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SetUpChannelScreen extends StatefulWidget {
  SetUpChannelScreen({Key? key}) : super(key: key);

  @override
  State<SetUpChannelScreen> createState() => _SetUpChannelScreenState();
}

class _SetUpChannelScreenState extends State<SetUpChannelScreen> {
  String? dropdownValue = 'WhatsApp';
  DataModel? dataModel;

  List<DataModel> appSelect = [
    DataModel(image: "asset/image/ad.png", name: "WhatsApp"),
    DataModel(image: "asset/image/category.png", name: "whatsappBusiness"),
    DataModel(image: "asset/image/ad.png", name: "messenger"),
    DataModel(image: "asset/image/category.png", name: "instagram"),
    DataModel(image: "asset/image/ad.png", name: "telegram"),
    DataModel(image: "asset/image/category.png", name: "twitter"),
  ];

  // List appSelectItem = [
  //   {
  //     "image": AppIcons.whatsapp,
  //     "appName": AppString.WhatsApp,
  //   },
  // ];
  // late String? dropdownvalue = appSelect.elementAt(0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton<DataModel>(
              hint: const Text('Choose'),
              value: dataModel,
              icon: const Icon(
                Icons.keyboard_arrow_down,
              ),
              underline: const SizedBox(),
              onChanged: (DataModel? value) {
                print("Select VALUE :--0--");

                setState(() {
                  dataModel = value!;
                });
              },
              items: appSelect.map<DropdownMenuItem<DataModel>>((DataModel value) {
                return DropdownMenuItem<DataModel>(
                  value: value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        value.image,
                        height: 20,
                      ),
                      SizedBox(width: 5),
                      Text(value.name),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ]),
    );
  }
}

class DataModel {
  final String image;
  final String name;

  DataModel({required this.image, required this.name});
}
