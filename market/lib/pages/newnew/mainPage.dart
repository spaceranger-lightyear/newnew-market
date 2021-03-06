import 'package:bak/models/classes/user.dart';
import 'package:bak/models/designs/colors.dart';
import 'package:bak/models/components/navigation.dart';
import 'package:bak/pages/newnew/follwingCollections.dart';
import 'package:bak/pages/newnew/follwingShops.dart';
import 'package:bak/pages/newnew/recommend.dart';
import 'package:flutter/material.dart';

class NewnewPage extends StatefulWidget {
  User user;
  NewnewPage({this.user});

  @override
  _NewnewPageState createState() => _NewnewPageState();
}

class _NewnewPageState extends State<NewnewPage> with TickerProviderStateMixin {
  TabController _controller;

  List<Tab> _tabs = [
    Tab(
      icon: Text('추천'),
    ),
    Tab(
      icon: Text('shop'),
    ),
    Tab(
      icon: Text('collection'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: offWhite,
        appBar: appBarWithSearch(context, 'Explore', widget.user, _tabs, _controller),
        body: Column(
          children: [
            TabBar(
              controller: _controller,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: _tabs,
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  RecommendPage(user: widget.user,),
                  FollowingShopsPage(user: widget.user),
                  FollowingCollectionsPage(user: widget.user),
                ],
              ),
            )
          ],
        ));
  }
}
