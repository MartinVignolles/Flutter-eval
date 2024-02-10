import 'dart:convert';
import 'package:appli_mobile/components/logo_connexion.dart';
import 'package:appli_mobile/components/my_button.dart';
import 'package:appli_mobile/decoration/constraints.dart';
import 'package:appli_mobile/decoration/decoration.dart';
import 'package:appli_mobile/pages/login/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:appli_mobile/components/my_textfield.dart';
import 'package:appli_mobile/donnees/model/login_model.dart';
import 'package:appli_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  late List<LoginModel> loginModel;
  bool loaded = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadEvenement();
  }

  Future<void> loadEvenement() async {
    String jsonString =
        await rootBundle.loadString('lib/donnees/json/login_data.json');
    List<dynamic> jsonList = await json.decode(jsonString);
    setState(() {
      loginModel = jsonList.map((json) => LoginModel.fromJson(json)).toList();
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: couleurMinGradient,
      body: Container(
        decoration: GradientContainer.blueGradient,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Image.asset('assets/images/Logo.png'),
          ),

          //username textfield
          MyTextField(
            controller: usernameController,
            hintText: 'Username',
            obscureText: false,
          ),

          //password textfield
          MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
          ),

          //forgot password
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                      ;
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Text('mot de passe oublié',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyButton(
              text: 'Se connecter',
              fontSize: 25,
              onPressed: login,
              background: couleurBoutonLogin,
              fontFamily: 'Inter',
            ),
          ),
          LogoBouton(
              onPressed: signInWithGoogle,
              image: 'assets/images/LogoGoogle.png'),
        ]),
      ),
    );
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;
      changePage(user);
    } catch (error) {
      print('Erreur de connexion Google: $error');
    }
  }

  void changePage(user) {
    if (user != null) {
      // L'utilisateur est connecté avec succès
      print('Connecté avec succès en tant que ${user.displayName}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      print('Erreur de connexion Google');
    }
  }

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
    /*
    final String enteredUsername = usernameController.text;
    final String enteredPassword = passwordController.text;

    bool isUserValid = false;
    isUserValid = true;
    print("login");
    for (var user in loginModel) {
      if (user.login == enteredUsername && user.password == enteredPassword) {
        isUserValid = true;
        break;
      }
    }
    if (isUserValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      print("Nom d'utilisateur ou mot de passe incorrect");
    }*/
  }
}
