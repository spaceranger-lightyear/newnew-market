import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

import 'package:artpia/pages/profile/module.dart';

class ArtistPage extends StatefulWidget {
  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: artistAppBar(context),
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            userProfile(context),
            SizedBox(
              height: 20,
            ),
            artworkList(context),
          ],
        ),
      ),
    );
  }

  Widget userProfile(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child:  Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 60,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Name', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          Text(' City, Country', style: TextStyle(fontSize: 18,),),
        ],
      ),
    );
  }

  void addImages() async {
    List<Media> res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.all,
      language: Language.System,
      cropOpt: CropOption(
      ),
    );
    if (res != null) {
      print(res.map((e) => e.path).toList());
      setState(() {
        path = res[0].thumbPath;
      });
    }
  }

  Widget artworkList(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            child: Text('Artworks', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
          ),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              testItem(),
              testItem(),
              testItem(),
              testItem(),testItem(),
              testItem(),
              testItem(),
              testItem(),
            ],
          ),
        ],
      )
    );
  }

  Widget testItem() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20)),
    );
  }
}
