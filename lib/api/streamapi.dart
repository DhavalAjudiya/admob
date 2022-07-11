import 'package:flutter/material.dart';
import 'package:testadmob/api/modal.dart';
import 'package:testadmob/api/services.dart';

class StreamApi extends StatefulWidget {
  const StreamApi({Key? key}) : super(key: key);

  @override
  State<StreamApi> createState() => _StreamApiState();
}

class _StreamApiState extends State<StreamApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: StreamBuilder(
              stream: FetchApiService.messageFlow(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print("-------5555555--------}");

                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text('Loading'),
                    ),
                  );
                }
                print("-------6666666--------}");

                return ListView.builder(
                  itemCount: snapshot.data,
                  itemBuilder: (context, index) {
                    print("-------77777777--------}");

                    HomePageModel message = snapshot.data[index];
                    print("-------8888888--------}");

                    return Column(
                      children: [Text("${message.topicList?.data?[index].id}")],
                    );
                  },
                );

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
