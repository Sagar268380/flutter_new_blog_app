import 'package:flutter/material.dart';
import 'package:flutternewblogapp/Authencation.dart';
import 'package:flutternewblogapp/LoginRegistrationPage.dart';
import 'LoginRegistrationPage.dart';
import 'HomePage.dart';
import 'MappingPage.dart';
import 'Authencation.dart';



//here project will start run
void main()
{
     runApp(new BlogApp());
}

class BlogApp extends StatelessWidget
{
    @override
  Widget build(BuildContext context)
    {
        return new MaterialApp
          (
             title: "Blog App",

             theme: new ThemeData
                 (
                      primarySwatch: Colors.pink,
                 ),
              home: MappingPage(authImplementation: Auth(),),
          );
    }
}