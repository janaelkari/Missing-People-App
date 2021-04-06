import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_appretry/missing_person.dart';

import 'Authentication/loading.dart';

class MissingList extends StatefulWidget {
  @override
  _MissingListState createState() => _MissingListState();
}

class _MissingListState extends State<MissingList> {
  var _firestore = Firestore.instance;
  List<MissingPerson> missingPeople;
  bool loading;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() {
    loading = true;
    return _firestore.collection("m").getDocuments().then((value) {
      var list = value.documents;
      missingPeople = list.map((e) {
        print("OutData: ${e.data}");
        return MissingPerson.fromJson(e.data);
      }).toList(growable: true);
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: <Widget>[
    //     ListTile(
    //       title: Text("Ziad"),
    //       subtitle: Text("hamra street"),
    //       trailing: Icon(Icons.check_circle),
    //       leading: CircleAvatar(
    //         backgroundImage: NetworkImage(
    //             "https://cdn.psychologytoday.com/sites/default/files/styles/article-inline-half-caption/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=0hb44OrI"),
    //       ),
    //     ),
    //     ListTile(
    //       title: Text("Jana Kanafani "),
    //       subtitle: Text("bliss street"),
    //       trailing: Icon(Icons.check_circle),
    //       leading: CircleAvatar(
    //         backgroundImage: NetworkImage(
    //             "https://www.newzealand.com/assets/Tourism-NZ/Tiaki/9052a21e4c/Tiaki_Hero_Thumbnail_v1__aWxvdmVrZWxseQo_FocalPointCropWzQyMCw0MjAsNTAsNTAsNzUsImpwZyIsNjUsMi41XQ.jpg"),
    //       ),
    //     ),
    //     ListTile(
    //       leading: CircleAvatar(
    //         backgroundImage: NetworkImage(
    //             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtmFoPF5cPREM9B0RM5HmjjCT26b9FlcSiKA&usqp=CAU"),
    //       ),
    //       title: Text("Jana Husseini"),
    //       subtitle: Text("1st street"),
    //     ),
    //     ListTile(
    //       leading: CircleAvatar(
    //         backgroundImage: NetworkImage(
    //             "https://www.zohowebstatic.com/sites/default/files/people/ashish-vikram.jpg"),
    //       ),
    //       title: Text("Ahmad Ghandour"),
    //       subtitle: Text("nabatiyeh street"),
    //       trailing: Icon(Icons.check_circle),
    //     ),
    //     ListTile(
    //       title: Text("Iyad"),
    //       subtitle: Text("2nd street street"),
    //       trailing: Icon(Icons.check_circle),
    //       leading: CircleAvatar(
    //         backgroundImage: NetworkImage(
    //             "https://wordstream-files-prod.s3.amazonaws.com/s3fs-public/pictures/picture-38061-1459177084.jpg"),
    //       ),
    //     ),
    //     ListTile(
    //         title: Text("Jane"),
    //         subtitle: Text("beirut"),
    //         trailing: Icon(Icons.check_circle),
    //         leading: CircleAvatar(
    //           //backgroundColor: Colors.red,
    //           backgroundImage: NetworkImage(
    //               "https://coda.newjobs.com/api/imagesproxy/ms/cms/content30/images/people-pleaser.png"),
    //         )),
    //     ListTile(
    //         title: Text("Ihab Ali"),
    //         subtitle: Text("mar elias"),
    //         leading: CircleAvatar(
    //           backgroundImage: NetworkImage(
    //               "https://assets.themuse.com/uploaded/companies/1309/module_persons/3020.jpg?v=58b723e902db86d853228113ac137d40d267374d4dd91417930270e854d89ca6"),
    //         )),
    //     ListTile(
    //       title: Text("Saad Wehbe"),
    //       subtitle: Text("nabatiyeh street"),
    //       trailing: Icon(Icons.check_circle),
    //       leading: CircleAvatar(
    //         backgroundImage: NetworkImage(
    //             "https://e7.pngegg.com/pngimages/551/467/png-clipart-businessperson-small-business-business-plan-advertising-business-service-people.png"),
    //       ),
    //     ),
    //     ListTile(
    //         title: Text("Lynn Jaber"),
    //         subtitle: Text("4th street"),
    //         leading: CircleAvatar(
    //           backgroundImage: NetworkImage(
    //               "https://media.istockphoto.com/photos/young-woman-portrait-in-the-city-picture-id1009749608?k=6&m=1009749608&s=612x612&w=0&h=ckLkBgedCLmhG-TBvm48s6pc8kBfHt7Ppec13IgA6bo="),
    //         )),
    //     ListTile(
    //       //leading: CircleAvatar(
    //       //backgroundImage: AssetImage(""),
    //       leading: CircleAvatar(
    //         backgroundImage: NetworkImage(
    //             "https://assets.themuse.com/uploaded/companies/1309/module_persons/3020.jpg?v=58b723e902db86d853228113ac137d40d267374d4dd91417930270e854d89ca6"),
    //       ),
    //       title: Text("Omar Abboud"),
    //       subtitle: Text("nabatiyeh street"),
    //
    //       //
    //     ),
    //     ListTile(
    //       leading: CircleAvatar(
    //         backgroundImage: NetworkImage(
    //             "https://s.abcnews.com/images/GMA/191211_gma_thunberg1_hpMain_16x9_992.jpg"),
    //       ),
    //       title: Text("Souad Awad"),
    //       subtitle: Text("nabatiyeh street"),
    //       trailing: Icon(Icons.check_circle),
    //     )
    //   ],
    // );
    if (loading)
      return Center(
        child: Loading(),
      );
    return RefreshIndicator(
      onRefresh: () {
        return loadData();
      },
      child: ListView.separated(
          itemBuilder: (context, index) {
            return _MissingItem(person: missingPeople[index]);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: missingPeople.length),
    );
  }
}

class _MissingItem extends StatelessWidget {
  final MissingPerson person;

  const _MissingItem({Key key, this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(person.name),
      subtitle: Text(person?.address ?? ""),
      trailing: Text(person.age),
    );
  }
}
