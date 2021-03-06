import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Artpia
{
  static const String appName = 'e-Shop';

  static SharedPreferences sharedPreferences;
  static User user;
  static FirebaseAuth auth;
  static FirebaseFirestore firestore;

  static String collectionUser = "users";
  static String collectionOrders = "orders";
  static String userFavoriteList = 'userFavorite';
  static String subCollectionAddress = 'userAddress';

  static final String userUID = 'uid';
  static final String userName = 'name';
  static final String userEmail = 'eMail';
  static final String userImageUrl = 'imageUrl';
  static final String userProfileImageUrl = 'profileImageUrl';

  static final String addressID = 'addressID';
  static final String totalAmount = 'totalAmount';
  static final String artworkID = 'artworkIDs';
  static final String paymentDetails ='paymentDetails';
  static final String orderTime ='orderTime';
  static final String isSuccess ='isSuccess';
}