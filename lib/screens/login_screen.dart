import 'package:flutter/material.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String e_mail;
  String password;
  bool state=false;
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logoavatar",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  e_mail=value;
                },
                decoration:
                    KtextfeildStyle.copyWith(hintText: "Enter your email"),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                decoration:
                    KtextfeildStyle.copyWith(hintText: 'Enter your password.'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  onPressed: () async{
                    setState(() {
                      state=true;
                    });
                    print(e_mail +" \n "+password);
                    try {
                      final confirm=await _auth.signInWithEmailAndPassword(
                          email: e_mail, password: password);
                      if(confirm!=null)
                        {
                          print("done");
                          Navigator.pushNamed(context, ChatScreen.id);
                        }

                    }
                    catch(e)
                    {
                      print(e);
                    }
                    setState(() {
                      state = false;
                    });
                  },
                  text: 'Log In',
                  color: Colors.lightBlueAccent),
            ],
          ),
        ), inAsyncCall: state,
      ),
    );
  }
}
