import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;
  final String photoUrl;
  final String displayName;

  User({
    @required this.uid,
    @required this.photoUrl,
    @required this.displayName,
  });
}


class Auth with ChangeNotifier{

  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      photoUrl: user.photoUrl,
      displayName: user.displayName,
    );
  }


  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }


  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(authResult.user);
  }


  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

//  Future<User> signInWithFacebook() async {
//    final facebookLogin = FacebookLogin();
//    final result = await facebookLogin.logInWithReadPermissions(
//      ['public_profile'],
//    );
//    if (result.accessToken != null) {
//      final authResult = await _firebaseAuth.signInWithCredential(
//        FacebookAuthProvider.getCredential(
//          accessToken: result.accessToken.token,
//        ),
//      );
//      return _userFromFirebase(authResult.user);
//    } else {
//      throw PlatformException(
//        code: 'ERROR_ABORTED_BY_USER',
//        message: 'Sign in aborted by user',
//      );
//    }
//  }




  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
//    final facebookLogin = FacebookLogin();
//    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }

}