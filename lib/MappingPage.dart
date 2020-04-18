import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'LoginRegistrationPage.dart';
import 'HomePage.dart';
import 'Authencation.dart';

class MappingPage extends StatefulWidget
{
  final AuthImplementation authImplementation;

  MappingPage
  ({
         this.authImplementation,
  });

  @override
  State<StatefulWidget> createState() {
       return _MappingPageState();
  }
}

enum AuthStatus
{
  notSignedIn,
  SignedIn
}

class _MappingPageState extends State<MappingPage>
{

  AuthStatus authStatus=AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.authImplementation.getCurrentUser().then((firebaseUserId)
    {
            authStatus=firebaseUserId==null ? AuthStatus.notSignedIn : AuthStatus.SignedIn;
    });
  }


  void _signedIn()
  {
    setState(() {
      authStatus=AuthStatus.SignedIn;
    });
  }

  void  _signedOut()
  {
    setState(() {
      authStatus=AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    switch(authStatus)
    {
      case AuthStatus.notSignedIn:
        return new LoginRegistrationPage
          (
            authImplementation :widget.authImplementation,
            onSignedIn: _signedIn
          );

      case AuthStatus.SignedIn:
        return new Homepage
          (
            authImplementation :widget.authImplementation,
            onSignedOut: _signedOut
        );


    }
    return null;
  }
}

