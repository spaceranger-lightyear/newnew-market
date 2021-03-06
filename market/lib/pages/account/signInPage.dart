import 'package:bak/models/classes/user.dart';
import 'package:bak/models/components/border.dart';
import 'package:bak/models/components/cards.dart';
import 'package:bak/models/designs/colors.dart';
import 'package:bak/models/components/navigation.dart';
import 'package:bak/models/designs/typos.dart';
import 'package:bak/pages/account/findPassword.dart';
import 'package:bak/pages/account/signUpPage.dart';
import 'package:bak/pages/home/bootPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  _SignInPage createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String account;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefaultDeep(context, '로그인'),
      backgroundColor: offWhite,
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 60),
              width: MediaQuery.of(context).size.width * (124 / 375),
              child: Image.asset(
                'lib/assets/icons/drawable-xxxhdpi/new_new_logo_combined.png',
                fit: BoxFit.cover,
              ),
            ),
            textFieldAccount(context),
            textFieldPassword(context),
            hSpacer(20),
            signInButton(context),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                textButton(context, '비밀번호 찾기', FindPasswordPage()),
                Padding(
                  padding: EdgeInsets.all(3),
                ),
                Container(
                  height: 12,
                  width: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.all(3),
                ),
                textButton(context, '회원가입', SignUpPage()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget textButton(BuildContext context, String _textContext, Widget _route) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => _route));
        },
        child: Container(
          height: 20,
          width: 70,
          color: offWhite,
          child: Center(
            child: Text(
              _textContext,
              style: caption2(semiDark),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldAccount(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (335 / 375),
      height: 44,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) return '상점명 또는 이메일을 입력하세요.';
          return null;
        },
        onSaved: (value) => account = value,
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: '상점명 또는 이메일'),
      ),
    );
  }

  Widget textFieldPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (335 / 375),
      height: 44,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextFormField(
        obscureText: true,
        validator: (value) {
          if (value.isEmpty) return '비밀번호를 입력하세요.';
          return null;
        },
        onSaved: (value) => password = value,
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: '비밀번호'),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          _formKey.currentState.save();
          signIn();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * (335 / 375),
          height: 44,
          color: primary,
          child: Center(
            child: Text(
              '로그인',
              style: cta(offWhite),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() {
    Pattern pattern =
        r'^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(account)) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: account, password: password)
          .then((e) {
        var users = Firestore.instance
            .collection('users')
            .where('eMail', isEqualTo: account)
            .snapshots()
            .forEach((element) {
          element.documents.asMap().forEach((key, e) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BootPage(
                        user: User.getUserData(e),
                      )),
              (route) => false);
          });
        });
      });
    }
    Firestore.instance.collection('users').document(account).get().then((e) {
      if (account == e.data['username']) {
        if (password == e.data['password']) {
          FirebaseAuth.instance.signInWithEmailAndPassword(
              email: e.data['eMail'], password: e.data['password']);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BootPage(
                        user: User.getUserData(e),
                      )),
              (route) => false);
        } else
          wrongDialog('비밀번호가 일치하지 않습니다.');
      } else
        wrongDialog('아이디가 존재하지 않습니다.');
    });
  }

  void wrongDialog(String textContext) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(textContext),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                color: primary,
                child: Text('확인'),
              ),
            ],
          );
        });
  }
}
