import 'package:editsource/models/UI/cards.dart';
import 'package:editsource/models/classes/collection.dart';
import 'package:editsource/models/classes/product.dart';
import 'package:editsource/models/widgets/components/selection/indicator.dart';
import 'package:editsource/pages/home/account/signInPage.dart';
import 'package:editsource/pages/home/account/signUpPage.dart';
import 'package:editsource/pages/home/bootPage.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreen createState() => _OnboardingScreen();
}

class _OnboardingScreen extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  int currentIndexPage;
  int pageLength;

  @override
  void initState() {
    currentIndexPage = 0;
    pageLength = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            children: <Widget>[
              Walkthrougth(
                  content: Padding(
                padding: EdgeInsets.all(20),
                child:
                    itemCardLarge(context, new Product('test', 150000, '/lib')),
              )),
              Walkthrougth(
                  content: Padding(
                padding: EdgeInsets.all(20),
                child:
                    itemCardMedium(context, new Product('test', 150000, '/lib')),
              )),
              Walkthrougth(
                  content: Padding(
                padding: EdgeInsets.all(20),
                child:
                    //itemCardSmall(context, new Product('test', 150000, '/lib')),
                    collectionCoverCard(context, new Collection()),
              )),
            ],
            onPageChanged: (value) {
              setState(() => currentIndexPage = value);
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BootPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 40,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        '둘러보기',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.25,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Text(
              '취향있는 사람들의\n좋은 물건\nNEW NEW',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 1.1),
                  child: Align(
                    alignment: Alignment.center,
                    child: imageCarouselIndicator(currentIndexPage, pageLength),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInPage()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                height: 40,
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    '로그인',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                height: 40,
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    '회원가입',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Walkthrougth extends StatelessWidget {
  final Padding content;

  Walkthrougth({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(color: Colors.redAccent),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(child: content),
    );
  }
}
