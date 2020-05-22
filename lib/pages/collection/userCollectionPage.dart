import 'package:flutter/material.dart';
import 'package:newnew/widgets/collection/recommends.dart';
import 'package:newnew/widgets/collection/userCollections.dart';

class UserCollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('뉴뉴 컬렉션', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        leading: BackButton(
          color: Colors.black
        ),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      body: UserCollections(),
    );
  }
}
