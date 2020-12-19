import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkmark_app/constants.dart';

class SignInPage extends StatelessWidget {
  static final googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  void _signIn({
    @required BuildContext context,
  }) async {
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) return;

    final auth = await signInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user.uid);

    Navigator.of(context).pushNamed(Constants.pageLinkIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInButton(
        Buttons.Google,
        onPressed: () {
          _signIn(context: context);
        },
      ),
    );
  }
}
