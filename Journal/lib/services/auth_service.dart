import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'internet_status.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _facebookLogin = FacebookLogin();

//* Contact function
  Future<void> contactMe(String url) async {
    if (await checkInternetConnection()) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch this email: $url');
      }
    } else {
      Fluttertoast.showToast(
          msg: "Connection Error !",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18.0);
    }
  }

//* Follow function
  Future<void> followMe(String url) async {
    if (await checkInternetConnection()) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("We are not able to launch: $url");
      }
    } else {
      Fluttertoast.showToast(
          msg: "Connection Error !",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18.0);
    }
  }

//* Signout function
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      handleExceptions(e.toString());
    }
  }

//* Google Authentication
  Future<void> googleSignin() async {
    if (await checkInternetConnection()) {
      try {
        final GoogleSignInAccount _googleSignInAccount =
            await _googleSignIn.signIn();
        final GoogleSignInAuthentication _googleSignInAuthentication =
            await _googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: _googleSignInAuthentication.accessToken,
          idToken: _googleSignInAuthentication.idToken,
        );

        await _auth.signInWithCredential(credential);
      } catch (e) {
        handleExceptions(e.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: "Connection Error !",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18.0);
    }
  }

//* Twitter Authentication
  Future<void> twitterSignin() async {
    if (await checkInternetConnection()) {
      try {
        var twitterLogin = new TwitterLogin(
          consumerKey: 'provide your consumerKey here',
          consumerSecret: 'provide your consumerSecret here',
        );
        TwitterLoginResult _twitterLoginResult = await twitterLogin.authorize();
        TwitterSession _currentUserTwitterSession = _twitterLoginResult.session;

        //* We can get the user log status via :
        // TwitterLoginStatus _twitterLoginStatus = _twitterLoginResult.status;

        AuthCredential _authCredential = TwitterAuthProvider.getCredential(
            authToken: _currentUserTwitterSession?.token ?? '',
            authTokenSecret: _currentUserTwitterSession?.secret ?? '');
        await _auth.signInWithCredential(_authCredential);
      } catch (e) {
        handleExceptions(e.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: "Connection Error !",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18.0);
    }
  }

//* Facebook Authentication
  Future<void> facebookSignin() async {
    if (await checkInternetConnection()) {
      try {
        FacebookLoginResult _result = await _facebookLogin.logIn(['email']);

        AuthCredential _credential = FacebookAuthProvider.getCredential(
            accessToken: _result.accessToken.token);
        await _auth.signInWithCredential(_credential);
      } catch (e) {
        handleExceptions(e.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: "Connection Error !",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18.0);
    }
  }

//* The function that handle exceptions
  void handleExceptions(String exceptions) {
    switch (exceptions) {
      case "PlatformException(ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL, An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address., null)":
        Fluttertoast.showToast(
            msg: "An account already exists",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.redAccent,
            fontSize: 18.0,
            textColor: Colors.white);
        break;

      case "PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)":
        Fluttertoast.showToast(
            msg: "Connection Error !",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 18.0);
        break;

      //* Exceptions from twitter auth
      case "PlatformException(error, Given String is empty or null, null)":
        Fluttertoast.showToast(
            msg: "Login Cancelled !",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.redAccent,
            fontSize: 18,
            textColor: Colors.white);
        break;

      default:
        print("The default exception is : $exceptions");
    }
  }
}
