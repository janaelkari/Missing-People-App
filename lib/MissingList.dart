import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appretry/missing.dart';
import 'package:provider/provider.dart';

import 'missing_notifier.dart';

class MissingList extends StatefulWidget {
  _PeopleState createState() => _PeopleState();


}
  class _PeopleState extends State<MissingList> {
    @override
    void initState() {
      Notifier xNotifier = Provider.of<Notifier>(context, listen: false);
      getpeople(xNotifier);
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    Notifier xNotifier = Provider.of<Notifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('LIST'),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(xNotifier.missingList[index].name),
              subtitle: Text(xNotifier.missingList[index].adress),
            );
          },
          itemCount: xNotifier.missingList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },


        ));
  }}
getpeople(Notifier xNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('m')
      .getDocuments();

  List<missing> _pList = [];

  snapshot.documents.forEach((document) {
    missing p = missing.fromMap(document.data);
    _pList.add(p);
  });

  xNotifier.missingList = _pList;
}