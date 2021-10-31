


import 'package:election_exit_poll_07610430/models/data.dart';
import 'package:election_exit_poll_07610430/models/item.dart';
import 'package:election_exit_poll_07610430/pages/result/result_page.dart';
import 'package:election_exit_poll_07610430/services/api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<Item>>? _futureList;

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
            child: FutureBuilder<List<Item>>(
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
                          onTap: () => _handleClick(item),
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
                              ElevatedButton(onPressed: () => _handleClick(item),
                                  child: Text('ดูผล'))
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
  Future<List<Item>> _load() async {
    List list = await Api().fetch('exit_poll');
    var itemList = list.map((item) => Item.fromJson(item)).toList();
    return itemList;
  }
  @override
  void initState() {
    super.initState();
    _futureList = _load();

  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  _handleClick(Item item){
    Navigator.pushNamed(
      context,
      ResultPage.routeName,
      arguments: item,
    );
  }
}
