import 'package:flutter/material.dart';
import 'package:fluttertest/components/helptofill.dart';
import 'package:fluttertest/components/loginsignupheader.dart';
import 'package:fluttertest/pages/login_page.dart';
//import 'package:login_with_signup/Comm/comHelper.dart';
import 'package:fluttertest/components/text_field.dart';
import 'package:fluttertest/databasehandler/databaseconnect.dart';
//import 'package:login_with_signup/Model/UserModel.dart';

class signup_page extends StatefulWidget {
  @override
  _signup_pageState createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  final _conUserGender = TextEditingController();
  var databaseconnect;

  @override
  void initState() {
    super.initState();
    databaseconnect = databaseconnect();
  }

  signup() async {
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;
    String ugender = _conUserGender.text;

    if(form.validate()){
      alertDialog(context, "OK");
    }

//    if (_formKey.currentState.validate()) {
    //     if (passwd != cpasswd) {
    //     alertDialog(context, 'Password Mismatch');
    // } else {
    //  _formKey.currentState.save();

    // UserModel uModel = UserModel(uid, uname, email, passwd);
    //await dbHelper.saveData(uModel).then((userData) {
    //alertDialog(context, "Successfully Saved");

//          Navigator.push(
    //            context, MaterialPageRoute(builder: (_) => LoginForm()));
    //    }).catchError((error) {
    //    print(error);
    //  alertDialog(context, "Error: Data Save Fail");});}}}

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Login with Signup'),
        ),
        // Form(
        // key: _formKey,
        //child:
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginsignupheader('Signup'),
                    text_field(
                        controller: _conUserName,
                        icon: Icons.person_outline,
                        inputType: TextInputType.name,
                        hintName: 'User Name'),
                    SizedBox(height: 5.0),
                    text_field(
                        controller: _conEmail,
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        hintName: 'Email'),
                    SizedBox(height: 5.0),
                    text_field(
                      controller: _conPassword,
                      icon: Icons.lock,
                      hintName: 'Password',
                      isObscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    text_field(
                      controller: _conCPassword,
                      icon: Icons.lock,
                      hintName: 'Confirm Password',
                      isObscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    text_field(
                        controller: _conUserGender,
                        icon: Icons.person,
                        inputType: TextInputType.name,
                        hintName: 'Gender'),

                    Container(
                      margin: EdgeInsets.all(30.0),
                      width: double.infinity,
                      child: FlatButton(
                        child: Text(
                          'Signup',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: signup(),
                      ), //FlatButton
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text('Have account Already? '),
                      FlatButton(
                        textColor: Colors.blue,
                        child: Text('Sign In'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => login_page()),
                                  (Route<dynamic> route) => false);
                        },

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      );
    }
  }
}