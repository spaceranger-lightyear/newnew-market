import 'package:bak/models/classes/product.dart';
import 'package:bak/models/classes/user.dart';
import 'package:bak/models/components/border.dart';
import 'package:bak/models/components/navigation.dart';
import 'package:bak/models/designs/colors.dart';
import 'package:bak/models/designs/icons.dart';
import 'package:bak/pages/category/categoryPage2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  User user;

  CategoryPage({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: categoryItemList(context),
      ),
    );
  }

  Widget categoryItemList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('categories').where('level', isEqualTo: '1').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return buildCategoryBody(context, snapshot.data.documents);
      },
    );
  }

  Widget buildCategoryBody(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Category> categoryItems =
        snapshot.map((e) => Category.fromSnapshot(e)).toList();
    return ListView.builder(
      itemCount: categoryItems.length,
      itemBuilder: (context, index) {
        return Container(
          child: categoryItemBuilder(context, categoryItems[index]),
        );
      },
    );
  }

  Widget categoryItemBuilder(BuildContext context, Category category) {
      return Column(
        children: [
          Material(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryPage2(
                              user: user,
                              parentCategory: category.title,
                            )));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(category.title),
                      ),
                      ImageIcon(
                        AssetImage(forward_idle),
                        size: 12,
                        color: semiDark,
                      ),
                    ]),
              ),
            ),
          ),
          borderLineGreyLite(context),
        ],
      );
    return null;
  }
}
