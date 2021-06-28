import 'package:flutter/material.dart';
import 'package:login_new_account_assignment1/HomeScreen.dart';
import 'package:login_new_account_assignment1/widget/custom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phoneNo = new TextEditingController();
  TextEditingController address = new TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkValue = false;
  SharedPreferences prefs;
     @override
  void initState() {
    super.initState();
    getData();
  }

  _onChange(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      prefs.setBool("check", checkValue);
       prefs.setString("name", name.text);
      prefs.setString("email", email.text);
      prefs.setString("password", password.text);
      prefs.setString("phoneNo", phoneNo.text);
      prefs.setString("address", address.text);

      getData();
    });
  }
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checkValue = prefs.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          name.text = prefs.getString("name");
          email.text = prefs.getString("email");
          password.text = prefs.getString("password");
          phoneNo.text = prefs.getString("phoneNo");
          address.text = prefs.getString("address");
        } else {
          name.clear();
          email.clear();
          password.clear();
          phoneNo.clear();
          address.clear();
          prefs.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                'Create New account ',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Add your details to sign up  ',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  textFeild(
                      controller: name,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.length == 0 || value == null) {
                          return 'Required Feild ';
                        }
                      },
                      hint: 'Name'),
                  SizedBox(
                    height: 10,
                  ),
                  textFeild(
                      controller: email,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.length == 0 || value == null) {
                          return 'Required Feild ';
                        } else if (!isEmail(value)) {
                          return 'inccorect email address';
                        }
                      },
                      hint: 'Email'),
                  SizedBox(
                    height: 10,
                  ),
                  textFeild(
                      controller: phoneNo,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value.length == 0 || value == null) {
                          return 'Required Feild ';
                        } else if (value.length < 10) {
                          return 'Incrrocet phone number';
                        }
                      },
                      hint: 'Phone Number'),
                  SizedBox(
                    height: 10,
                  ),
                  textFeild(
                      controller: address,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.length == 0 || value == null) {
                          return 'Required Feild ';
                        }
                      },
                      hint: 'Address'),
                  SizedBox(
                    height: 10,
                  ),
                  textFeild(
                    controller: password,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.length == 0 || value == null) {
                        return 'Required Feild';
                      } else if (value.length < 6) {
                        return 'Password must be longer than 6 letters';
                      }
                    },
                    hint: 'Password',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CheckboxListTile(
                    value: checkValue,
                    onChanged: _onChange,
                    title: new Text(
                      "Keep me Logged in",
                      style: TextStyle(color: Colors.redAccent, fontSize: 14),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  RaisedButton(
                    child: Text('Sign Up'),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
