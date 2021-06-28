import 'package:flutter/material.dart';
import 'package:login_new_account_assignment1/HomeScreen.dart';
import 'package:login_new_account_assignment1/register.dart';
import 'package:login_new_account_assignment1/widget/custom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
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
      prefs.setString("email", email.text);
      prefs.setString("password", password.text);

      getData();
    });
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checkValue = prefs.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          email.text = prefs.getString("email");
          password.text = prefs.getString("password");
        } else {
          email.clear();
          password.clear();
          prefs.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  _navigator() {
    bool isValidate = formKey.currentState.validate();

    if (isValidate == true) {
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
            builder: (BuildContext context) => new HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Login ',
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
              'Add your details to login ',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  textFeild(
                    controller: email,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value.length == 0 || value == null) {
                        return 'Required Feild ';
                      } else if (!isEmail(value)) {
                        return 'inccorect email address';
                      }
                    },
                    hint: 'Your Email',
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
                ],
              )),
          CheckboxListTile(
            value: checkValue,
            onChanged: _onChange,
            title: new Text(
              "Remember me ",
              style: TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          RaisedButton(
            color: Colors.redAccent,
            onPressed: _navigator,
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(
            children: [
              SizedBox(height: 60),
              Text('Dont have an account? '),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
