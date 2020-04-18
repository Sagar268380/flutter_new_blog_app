import 'package:flutter/material.dart';
import 'Authencation.dart';
import 'MappingPage.dart';
import 'DialogBox.dart';

class LoginRegistrationPage extends StatefulWidget
{

 LoginRegistrationPage
 ({
        this.authImplementation,
        this.onSignedIn,
});
  final AuthImplementation authImplementation;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState()
  {
    return _LoginRegisterState();

  }
}

enum FormType
{
  login,
  register
}

class _LoginRegisterState extends State<LoginRegistrationPage>
{

  DialogBox dialogBox=new DialogBox();

  final fromKey=new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email="";
  String _password="";
  //method
 bool validateAndSave()
  {
    final form=fromKey.currentState;
      if(form.validate())
      {
        form.save();
        return true;
      }
      else
        {
        return false;
      }
  }

  void validateAndSubmit() async
  {
              if(validateAndSave())
                {
                  try
                  {
                    if(_formType==FormType.login)
                    {
                         String  userId=await widget.authImplementation.SignIn(_email,_password);
                         dialogBox.information(context, "Congratulations = ", "your login sucessful");
                         print("login userId = "+userId);
                    }
                    else
                      {
                        String  userId=await widget.authImplementation.SignIn(_email,_password);
                        dialogBox.information(context, "Congratulations = ", "your Account has been creted");
                        print("register userId = "+userId);
                      }
                    widget.onSignedIn();
                  }
                  catch(e){
                    dialogBox.information(context, "Error = ", e.toString());
                      print("Error = "+e.toString());
                  }
                }
  }

  void moveToRegister()
  {
         fromKey.currentState.reset();
         setState(()
         {
             _formType=FormType.register;
         });
  }

  void moveToLogin()
  {
    fromKey.currentState.reset();
    setState(()
    {
      _formType=FormType.login;
    });
  }

  //Designing
  @override
  Widget build(BuildContext context) {
    return new Scaffold
      (
           appBar: new AppBar
             (
                title: new Text("Flutter Blog App"),
             ),

      body: new Container
        (
             margin: EdgeInsets.all(15.0),
             child: new Form
               (

               key: fromKey,

                  child: new Column
                   (
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: createInputs() + createButtons(),
                   ),
              ),
        ),

      );
  }

  List<Widget>createInputs()
  {
      return
          [
            SizedBox(height: 10.0,),
            logo(),
            SizedBox(height: 20.0,),
            new TextFormField
              (
                 decoration: new InputDecoration(labelText: 'Email'),
                 validator: (value){
                 return value.isEmpty ? 'Email id required' : null;
                },

              onSaved: (value)
                {
                  return _email=value;
                },
              ),
            SizedBox(height: 10.0,),
            new TextFormField
              (
                decoration: new InputDecoration(labelText: 'password'),
                obscureText: true,
                validator: (value){
                return value.isEmpty ? 'password is required' : null;
              },
              onSaved: (value){
                  return _password=value;
              },
            ),
            SizedBox(height: 20.0,),
          ];
  }

  Widget logo()
  {
    return new Hero
      (
      tag: 'hero',
        child: new CircleAvatar
        (
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('images/image19.jpg'),
      ),
    );
  }

  List<Widget>createButtons()
  {
    if(_formType==FormType.login)
      {
        return
          [
            new RaisedButton
              (
              child: new Text("Login", style: new TextStyle(fontSize: 20.0)),
              textColor: Colors.white,
              color: Colors.pink,

              onPressed: validateAndSubmit,
            ),

            new FlatButton
              (
              child: new Text("Not have an Account? Create Account", style: new TextStyle(fontSize: 14.0)),
              textColor: Colors.pink,

              onPressed: moveToRegister,
            ),
          ];
      }
    else{
      return
        [
          new RaisedButton
            (
            child: new Text("Create Account", style: new TextStyle(fontSize: 20.0)),
            textColor: Colors.white,
            color: Colors.pink,

            onPressed: validateAndSubmit,
          ),

          new FlatButton
            (
            child: new Text("Already have an Account? Login", style: new TextStyle(fontSize: 14.0)),
            textColor: Colors.pink,

            onPressed: moveToLogin,
          ),
        ];
    }
  }

}