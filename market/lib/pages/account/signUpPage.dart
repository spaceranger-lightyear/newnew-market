import 'package:bak/database/functions.dart';
import 'package:bak/models/classes/user.dart';
import 'package:bak/models/components/border.dart';
import 'package:bak/models/designs/colors.dart';
import 'package:bak/models/designs/typos.dart';
import 'package:bak/pages/account/selectFavor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bak/models/components/navigation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String verifyCode;
  String confirmPassword;

  String username;
  String password;
  String contact;
  String eMail;
  String address;

  String createDate;
  String lastActivity;

  String rate;

  String imageURI;
  String name;
  String bio;
  String webSite;

  List<String> followers = [];
  List<String> following = [];
  List<String> selectedFavor = [];
  List<String> reviews = [];

  List<String> favorite = [];
  List<String> myProducts = [];
  List<String> myCollections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefaultDeep(context, '회원가입'),
      backgroundColor: offWhite,
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            hSpacer(40),
            textFieldAuth(context),
            textFieldVerifyCode(context),
            textFieldUsername(context),
            textFieldEMail(context),
            textFieldPassword(context),
            textFieldConfirmPassword(context),
            hSpacer(50),
            signUpButton(context),
          ],
        ),
      ),
    );
  }

  Widget textFieldAuth(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        textFieldPhoneNumber(context),
        wSpacer(10),
        shortButtonRequestAuth(
            context,
            primary,
            false,
            Text(
              '인증요청',
              style: cta(offWhite),
            )),
      ],
    );
  }

  Widget textFieldPhoneNumber(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (227 / 375),
      height: 44,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextFormField(
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.numberWithOptions(signed: true),
        validator: (value) {
          if (value.length != 11) return '휴대폰 번호가 올바르지 않습니다.';
          return null;
        },
        onSaved: (value) {
          contact = value;
        },
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: '휴대폰 번호를 입력하세요.'),
      ),
    );
  }

  Widget shortButtonRequestAuth(
      BuildContext context, Color _color, bool _border, Widget _widget) {
    if (_border)
      return Container(
        width: MediaQuery.of(context).size.width * (100 / 375),
        height: 44,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black), color: _color),
        child: Center(
          child: _widget,
        ),
      );
    else
      return Container(
        width: MediaQuery.of(context).size.width * (100 / 375),
        height: 44,
        color: _color,
        child: Center(
          child: _widget,
        ),
      );
  }

  Widget textFieldVerifyCode(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (335 / 375),
      height: 44,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextFormField(
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.numberWithOptions(signed: true),
        validator: (value) {
          if (value.length != 6) return '인증번호가 올바르지 않습니다.';
          return null;
        },
        onSaved: (value) {
          verifyCode = value;
        },
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: '인증번호를 입력하세요.'),
      ),
    );
  }

  Widget textFieldUsername(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (335 / 375),
      height: 44,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextFormField(
        validator: (value) {
          Pattern pattern = r'^[a-z0-9_]+$';
          RegExp regex = new RegExp(pattern);

          if (!regex.hasMatch(value)) return '영소문자, 숫자, _만 사용할 수 있습니다.';
          return null;
        },
        onSaved: (value) {
          username = value;
        },
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: '상점명을 입력하세요.'),
      ),
    );
  }

  Widget textFieldEMail(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (335 / 375),
      height: 44,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextFormField(
        validator: (value) {
          Pattern pattern =
              r'^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$';
          RegExp regex = new RegExp(pattern);

          if (!regex.hasMatch(value)) return '이메일 형식이 올바르지 않습니다.';
          return null;
        },
        onSaved: (value) {
          eMail = value;
        },
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: '이메일 주소를 입력하세요.'),
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
          Pattern pattern = r'^[a-zA-Z0-9!@#^&_]+$';
          RegExp regex = new RegExp(pattern);
          _formKey.currentState.save();

          if (!regex.hasMatch(value))
            return '영대소문자, 숫자, !,@,#,^,&,_만 사용할 수 있습니다.';
          if (value.length < 8 || value.length > 16)
            return '비밀번호를 8자 이상 16자 이하로 설정해주세요.';
          return null;
        },
        onSaved: (value) {
          password = value;
        },
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: '비밀번호를 8-16자로 입력하세요.'),
      ),
    );
  }

  Widget textFieldConfirmPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (335 / 375),
      height: 44,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextFormField(
        obscureText: true,
        validator: (value) {
          if (value != password) {
            return '비밀번호가 일치하지 않습니다.';
          }
          return null;
        },
        onSaved: (value) {
          confirmPassword = value;
        },
        style: TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: '비밀번호를 한번 더 입력하세요.'),
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    User user;

    return Material(
      child: InkWell(
        onTap: () {
          _autoValidate = true;
          if (validateAndSave()) {
            _formKey.currentState.save();
            signUp();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width * (335 / 375),
          height: 44,
          color: primary,
          child: Center(
            child: Text(
              '가입하기',
              style: cta(offWhite),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  void signUp() async {
    String uid;

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: eMail, password: password)
        .then(
      (value) async {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: eMail, password: password);
      },
    ).then(
      (value) async {
        uid = (await FirebaseAuth.instance.currentUser()).uid;

        Firestore.instance.collection('users').document(username).setData(
          {
            'username': username,
            'password': password,
            'contact': contact,
            'eMail': eMail,
            'address': address ?? "",
            'createDate': createDate ??
                DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
            'lastActivity': lastActivity ??
                DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
            'rate': rate ?? "",
            'imageURI': imageURI ?? 'gs://newnew-beta.appspot.com/1-1.JPG',
            'name': name ?? "",
            'bio': bio ?? "상점 소개를 입력하세요.",
            'webSite': webSite ?? "",
            'followers': followers ?? List.from(['']),
            'following': following ?? List.from(['']),
            'selectedFavor': selectedFavor ?? List.from(['']),
            'reviews': reviews ?? List.from(['']),
            'favorite': favorite ?? List.from(['']),
            'myProducts': myProducts ?? List.from(['']),
            'myCollections': myCollections ?? List.from(['']),
          },
        );

        Firestore.instance.collection('users').document(username).get().then(
          (e) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectFavorPage(
                  user: User.getUserData(e),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
