import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:testing_app/components/Button.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome Page',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ButtonOne(
                  text: 'Get started with Email',
                  color: Colors.green,
                  onTap: () => print('email'),
                  textColor: Colors.white),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ButtonOne(
                  text: 'Get started with Google',
                  color: Colors.blue,
                  onTap: () => print('google'),
                  textColor: Colors.white),
            ),
            Container(
              padding: EdgeInsets.only(left: 70, right: 70),
              child: FlatButton(
                  onPressed: () => print('sign in'),
                  child: Row(
                    children: [
                      Text('Already have an account?',
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 5),
                      Text('Sign in',
                          style: TextStyle(color: Colors.deepPurple))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
