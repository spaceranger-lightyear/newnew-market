import 'package:flutter/material.dart';

import 'package:newnew/widgets/category/squareList(2in1).dart';
import 'package:newnew/widgets/collection/recommends.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with TickerProviderStateMixin {
  TabController _controller;

  List<Widget> pages = [
    SquareList2in1(),
    SquareList2in1(),
    SquareList2in1(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.75,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Container(
              child: Text(
                '상품',
                style: TextStyle(color: Colors.black),
              ),
            ),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            bottom: TabBar(
              controller: _controller,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  icon: Text('일반'),
                ),
                Tab(
                  icon: Text('취향'),
                ),
                Tab(
                  icon: Text('서비스'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: pages,
          ),
        ),
      ),
    );
  }
}