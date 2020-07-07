import 'dart:async';

import 'package:bak/database/initialize.dart';
import 'package:bak/models/components/buttons.dart';
import 'package:bak/models/designs/colors.dart';
import 'package:bak/models/components/border.dart';
import 'package:bak/models/components/navigation.dart';
import 'package:bak/models/components/selection.dart';
import 'package:bak/models/designs/icons.dart';
import 'package:bak/pages/product/afterAddProdct.dart';
import 'package:bak/pages/category/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddProductPage extends StatefulWidget {
  bool isCategorySelected;
  DocumentSnapshot category;

  AddProductPage({Key key, @required this.isCategorySelected, this.category})
      : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Asset> _images;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productSizeController = TextEditingController();
  TextEditingController productFabricController = TextEditingController();
  TextEditingController productBrandController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDeliveryFeeController = TextEditingController();
  String _error = 'No Error Detected';

  List<DocumentSnapshot> categories = <DocumentSnapshot> [];

  Future getCategories() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('categories').getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      appBar: appBarDefault(context, '상품 등록'),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            productImages(context),
            productField(context),
            palette(context),
            stateSlider(context),
            addTag(context),
            acceptCardPayment(context),
            longButtonNav(
                context,
                primary,
                false,
                Text(
                  '등록하기',
                  style: TextStyle(color: offWhite),
                ),
                AfterAddProduct()),
          ],
        ),
      ),
    );
  }

  Widget productImages(BuildContext context) {
    if (_images == null)
      return Container(
        height: 112,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            emptyImageBox(context),
          ],
        ),
      );
    else
      return Container(
        height: 118,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          scrollDirection: Axis.horizontal,
          itemCount: _images.length,
          itemBuilder: (_, index) {
            return imageBox(context, _images[index]);
          },
        ),
      );
  }

  Future<void> loadAssets() async {
    setState(() {
      _images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
          enableCamera: true,
          selectedAssets: _images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Example App",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      _images = resultList;
      _error = error;
    });
  }

  Widget emptyImageBox(BuildContext context) {
    const double _length = 92;

    return Material(
      child: InkWell(
        onTap: () {
          loadAssets();
        },
        child: Container(
          margin: EdgeInsets.only(right: 15),
          width: _length,
          height: _length,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: offWhite,
          ),
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget imageBox(BuildContext context, Asset image) {
    const double _length = 92;

    return Material(
      child: InkWell(
        onTap: () {
          loadAssets();
        },
        child: Container(
          margin: EdgeInsets.only(right: 15),
          width: _length,
          height: _length,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: offWhite,
          ),
          child: AssetThumb(asset: image, width: 92, height: 92,),
          ),
        ),
      );
  }

  Widget productField(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * (335 / 375),
            height: 44,
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 7),
              child: TextFormField(
                controller: productNameController,
                validator: (value) {
                  if(value.isEmpty) {
                    return '상품명을 입력하세요.';
                  }
                },
                style: TextStyle(
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: '상품명 입력'),
              ),
            ),
          ),
          categorySelector(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * (163 / 375),
                height: 44,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 7),
                  child: TextFormField(
                    controller: productSizeController,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '사이즈 입력 (선택)'),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * (163 / 375),
                height: 44,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 7),
                  child: TextFormField(
                    controller: productFabricController,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '재질 입력 (선택)'),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * (335 / 375),
            height: 44,
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 7),
              child: TextFormField(
                controller: productBrandController,
                style: TextStyle(
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: '브랜드 입력 (선택)'),
              ),
            ),
          ),
          longButtonNav(
              context,
              offWhite,
              true,
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('취향 선택 (선택)'),
                      ),
                      ImageIcon(
                        AssetImage(forward_idle),
                        size: 12,
                        color: semiDark,
                      )
                    ],
                  )),
              favorite(context)),
          Container(
            width: MediaQuery.of(context).size.width * (335 / 375),
            height: 88,
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: productDescriptionController,
                validator: (value) {
                  if(value.isEmpty) {
                    return '상품 설명을 입력하세요.';
                  }
                },
                maxLines: 5,
                style: TextStyle(
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: '설명 입력'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * (163 / 375),
                height: 44,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 7),
                  child: TextFormField(
                    controller: productPriceController,
                    validator: (value) {
                      if(value.isEmpty) {
                        return '가격을 입력하세요.';
                      }
                    },
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '가격 입력'),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * (163 / 375),
                height: 44,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 7),
                  child: TextFormField(
                    controller: productDeliveryFeeController,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '배송비 입력 (선택)'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categorySelector(BuildContext context) {
    if (widget.isCategorySelected)
      return longButton(
        context,
        offWhite,
        true,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.category.data['parent'] +
                ' > ' +
                widget.category.data['title']),
          ),
        ),
      );
    else
      return longButtonNav(
          context,
          offWhite,
          true,
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('카테고리 선택'),
                  ),
                  ImageIcon(
                    AssetImage(forward_idle),
                    size: 12,
                    color: semiDark,
                  )
                ],
              )),
          CategoryPage());
  }

  Widget palette(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              colorCircle(context, Colors.red),
              colorCircle(context, Colors.orange),
              colorCircle(context, Colors.yellow),
              colorCircle(context, Colors.lightGreen),
              colorCircle(context, Colors.green),
              colorCircle(context, Colors.lightBlueAccent),
            ],
          ),
          hSpacer(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              colorCircle(context, Colors.blue),
              colorCircle(context, Colors.purple),
              colorCircle(context, Colors.pink),
              colorCircle(context, Colors.white),
              colorCircle(context, Colors.grey),
              colorCircle(context, Colors.black),
            ],
          )
        ],
      ),
    );
  }

  Widget colorCircle(BuildContext context, Color _color) {
    const double _r = 32;

    if (_color == Colors.white) {
      return Container(
        width: _r,
        height: _r,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(100),
            color: _color),
      );
    }

    return Container(
      width: _r,
      height: _r,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: _color),
    );
  }

  Widget stateSlider(BuildContext context) {
    return Column(
      children: [
        StateSlider(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New'),
              Text('Old'),
            ],
          ),
        )
      ],
    );
  }

  Widget addTag(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('태그 추가'), productTags(context)],
      ),
    );
  }

  Widget productTags(BuildContext context) {
    return Container(
      height: 45,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          tagBox(context),
          tagBox(context),
        ],
      ),
    );
  }

  Widget tagBox(BuildContext context) {
    const double _length = 30;
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: _length,
      height: _length,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: offWhite,
      ),
      child: Center(
        child: Icon(Icons.add),
      ),
    );
  }

  Widget acceptCardPayment(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('카드 결제 허용하기'),
              SelectionSwitch(),
            ],
          ),
          Text('택배 어쩌구 저쩌구'),
        ],
      ),
    );
  }
}
