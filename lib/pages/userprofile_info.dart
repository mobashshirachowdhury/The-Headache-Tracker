import 'package:flutter/material.dart';
import 'package:fluttertest/components/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class userprofile_info extends StatefulWidget {
  @override
  _userprofile_infoState createState() => _userprofile_infoState();
}


//          updateSP(user, true).whenComplete(() {
  //          Navigator.pushAndRemoveUntil(
    //            context,
      //          MaterialPageRoute(builder: (_) => LoginForm()),
        //            (Route<dynamic> route) => false);});
//        } else {
  //        alertDialog(context, "Error Update");}
//      }).catchError((error) {
  //      print(error);
    //    alertDialog(context, "Error");}); } }

//  delete() async {
  //  String delUserID = _conDelUserId.text;

    //await dbHelper.deleteUser(delUserID).then((value) {
      //if (value == 1) {
        //alertDialog(context, "Successfully Deleted");

//        updateSP(null, false).whenComplete(() {
  //        Navigator.pushAndRemoveUntil(
    //          context,
      //        MaterialPageRoute(builder: (_) => LoginForm()),
        //          (Route<dynamic> route) => false);
        //});}
   // });
  //}

 // Future updateSP(UserModel user, bool add) async {
    //final SharedPreferences sp = await _pref;

//    if (add) {
  //    sp.setString("user_name", user.user_name);
    //  sp.setString("email", user.email);
      //sp.setString("password", user.password);
//    } else {
  //    sp.remove('user_id');
    //  sp.remove('user_name');
      //sp.remove('email');
      //sp.remove('password');
    //}
  //}
class _userprofileState extends State<userprofile_info> {
  Future<SharedPreference> _pref = SharedPreferences.getInstance();
  String userName = "";

  @override
  void initState(){
    super.initState();
    getUserData();
  }
  Future<void> getUserData()async {
    final SharedPreferences sp = await _pref;

    setState(() {
      userName = sp.getString("user_name")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Info'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            //margin: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                //  Update
                  text_field(
                    //  controller: _conUserId,
                      //isEnable: false,
                      icon: Icons.person,
                      hintName: 'User ID'),
                  SizedBox(height: 10.0),
                  text_field(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'User Name'),
                  SizedBox(height: 10.0),
                  text_field(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  SizedBox(height: 10.0),
                  text_field(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: update,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),

                  //Delete

                  text_field(
                      controller: _conDelUserId,
                      isEnable: false,
                      icon: Icons.person,
                      hintName: 'User ID'),
                  SizedBox(height: 10.0),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        //'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: delete,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
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