import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:appli_mobile/components/my_text.dart';
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
      backgroundColor: Colors.black,
      body: Column(children: [
        const SizedBox(height: 50),

        const MyText(
          hintText: 'Login',
          fontSize: 40,
        ),

        //username textfield
        MyTextField(
          controller: usernameController,
          hintText: 'Username',
          obscureText: false,
        ),

        const SizedBox(height: 25),

        //password textfield
        MyTextField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
        ),

        const SizedBox(height: 25),

        //forgot password
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        ElevatedButton(onPressed: login, child: const Text("Login")),
        ElevatedButton(
          onPressed: signInWithGoogle,
          child: const Text('Se connecter avec Google'),
        )
      ]),
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
    } catch (error) {
      print('Erreur de connexion Google: $error');
    }
  }

  void login() {
    final String enteredUsername = usernameController.text;
    final String enteredPassword = passwordController.text;

    bool isUserValid = false;
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
    }
  }
}
