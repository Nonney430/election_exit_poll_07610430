


import 'package:election_exit_poll_07610430/models/data.dart';
import 'package:election_exit_poll_07610430/models/item.dart';
import 'package:election_exit_poll_07610430/services/api.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  static const routeName = '/result';
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  late Future<List<Data>>? _futureList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image:  DecorationImage(
            image:  AssetImage('assets/images/bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: FutureBuilder<List<Data>>(
            future: _futureList,
            builder: (context, snapshot) {
              if(snapshot.connectionState != ConnectionState.done){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = snapshot.data![index];

                    return Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(8.0),
                      elevation: 5.0,
                      shadowColor: Colors.black.withOpacity(0.2),
                      child: InkWell(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      item.candidateNumber.toString(),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          item.candidateTitle,
                                        ),
                                        Text(
                                          item.candidateName,
                                        ),

                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Text(
                              item.score.toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
  Future<List<Data>> _load() async {
    List list = await Api().fetch('exit_poll/result');
    var itemList = list.map((item) => Data.fromJson(item)).toList();
    return itemList;
  }
  @override
  void initState() {
    super.initState();
    _futureList = _load();
  }

}
