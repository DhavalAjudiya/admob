import 'package:flutter/material.dart';
import 'package:testadmob/stream/match_stream.dart';
import 'package:testadmob/stream/modal.dart';

class GetStreamData extends StatefulWidget {
  const GetStreamData({Key? key}) : super(key: key);

  @override
  State<GetStreamData> createState() => _GetStreamDataState();
}

class _GetStreamDataState extends State<GetStreamData> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    callApi();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.9;
      if (maxScroll - currentScroll <= delta) {
        callApi();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream: LiveStream().MatchStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return LayoutBuilder(
                        builder: (context, constraint) {
                          return Column(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<Example> feturedModel = snapshot.data as List<Example>;

                      // List<Example> started = [];
                      // String matchDate = "";
                      //
                      // if (feturedModel != null) {
                      //   started.add(feturedModel);
                      // }

                      return feturedModel.isEmpty
                          ? const Center(
                              child: Text(
                                "noData ",
                                style: TextStyle(color: Colors.red, height: 20),
                              ),
                            )
                          : Column(
                              children: [
                                ListView.builder(
                                  itemCount: feturedModel.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${feturedModel[index].enddate}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          "${feturedModel[index].seriesid}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "${feturedModel[index].seriesname}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "${feturedModel[index].startdate}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future callApi() async {
    print("call api");
    List<Example> feturedModel = await LiveStream().getMatches();
    // print("call api-----${feturedModel?.startdate}");
  }
}
