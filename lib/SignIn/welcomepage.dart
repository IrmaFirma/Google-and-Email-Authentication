import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/Registration/email_password_register_page.dart';
import 'package:testing_app/SignIn/signin_manager.dart';
import 'package:testing_app/SignIn/social_sign_in_button.dart';
import 'package:testing_app/components/platform_exception_dialog.dart';
import 'package:testing_app/components/strings.dart';
import 'package:testing_app/services/auth_service.dart';

import 'email_password_sign_in_page.dart';

class WelcomePageBuilder extends StatelessWidget {
  // P<ValueNotifier>
  //   P<SignInManager>(valueNotifier)
  //     SignInPage(value)
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, SignInManager manager, __) => SignInPage._(
              isLoading: isLoading.value,
              manager: manager,
              title: 'iChange',
            ),
          ),
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage._({Key key, this.isLoading, this.manager, this.title})
      : super(key: key);
  final SignInManager manager;
  final String title;
  final bool isLoading;

  static const Key googleButtonKey = Key('google');
  static const Key emailPasswordButtonKey = Key('email-password');

  Future<void> _showSignInError(
      BuildContext context, FirebaseException exception) async {
    await PlatformExceptionAlertDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on FirebaseException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    final navigator = Navigator.of(context);
    await EmailPasswordSignInPage.show(
      context,
      onSignedIn: navigator.pop,
    );
  }

  Future<void> _registerWithEmailAndPassword(BuildContext context) async {
    final navigator = Navigator.of(context);
    await EmailPasswordRegisterPage.show(
      context,
      onSignedIn: navigator.pop,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(title),
      ),
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      Strings.signIn,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 200, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 32.0),
            SizedBox(
              height: 50.0,
              child: _buildHeader(),
            ),
            SocialSignInButton(
              key: googleButtonKey,
              assetName: 'assets/go-logo.png',
              text: Strings.signInWithGoogle,
              onPressed: isLoading ? null : () => _signInWithGoogle(context),
              color: Colors.white,
            ),
            SizedBox(height: 8),
            SignInButton(
              key: emailPasswordButtonKey,
              text: Strings.signInWithEmailPassword,
              onPressed:
                  isLoading ? null : () => _registerWithEmailAndPassword(context),
              textColor: Colors.white,
              color: Colors.teal[700],
            ),
            SizedBox(height: 8),
            Text(
              Strings.or,
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: FlatButton(
                  child: Row(
                    children: [
                      Text('Already have an account? ', style: TextStyle(color: Colors.grey),),
                      Text('Sign In', style: TextStyle(color: Colors.indigo),)
                    ],
                  ),
                onPressed:
                    isLoading ? null : () => _signInWithEmailAndPassword(context)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
