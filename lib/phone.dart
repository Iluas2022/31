import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences sharedPrefs;
  bool showSpinner = false;
  String login = '';
  String password = '';
  var loginInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
        loginInputController.text = sharedPrefs.getString('login') ?? '';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/images/dart-logo.png'),
                Container(
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: const Text(
                    'Введите логин',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: TextField(
                    controller:loginInputController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      login = value;
                    },

                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },

                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                    horizontal: 120,
                  ),
                  width: 150,
                  child: TextButton(
                    style: kButtonStyle,
                    child: Text(
                      'Войти',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      try {
                        sharedPrefs.setString('login', login);
                        setState(() {
                          showSpinner = true;
                        });
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        print('login:$login, password:$password');
                        showSpinner = false;
                      });
                     },
                     ),
                        ),
                Container(
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: Text(
                    'Регистрация',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: const Text(
                    'Забыли пароль?',
                    textAlign: TextAlign.center,
                  ),
                   ),
                     ],
                  ),
               ),
            ),
               ),
         );
       }
                 }
