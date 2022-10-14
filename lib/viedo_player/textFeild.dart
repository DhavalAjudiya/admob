import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  static List<String> friendsList = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Dynamic TextFormFields'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name textfield
              // Padding(
              //   padding: const EdgeInsets.only(right: 32.0),
              //   child: TextFormField(
              //     controller: _nameController,
              //     decoration: InputDecoration(hintText: 'Enter your name'),
              //     validator: (v) {
              //       if (v!.trim().isEmpty) {
              //         return 'Please enter something';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Add Friends',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              ..._getFriends(),
              const SizedBox(
                height: 40,
              ),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                  }
                },
                child: Text('Submit'),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// get firends text-fields
  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = -1; i < friendsList.length; i++) {
      print("index--0---${friendsList.length}");

      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(i)),
            const SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == friendsList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    print("index--0---$index");

    return InkWell(
      onTap: () {
        if (add) {
          print("index--1---$index");
          friendsList.insert(1, "");
        } else {
          if (index == 0) {
            friendsList.removeAt(index);
          } else {
            friendsList.removeAt(0);
          }
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  const FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController? _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController?.text = _MyFormState.friendsList[widget.index];
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) {
        _MyFormState.friendsList[widget.index] = v;
        print("_nameController---${_nameController?.text}");
      },
      decoration: const InputDecoration(hintText: 'Enter your friend\'s name'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
