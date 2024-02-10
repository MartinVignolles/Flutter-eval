import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController mailConfirmationController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 80, 146),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: mailController,
              decoration: const InputDecoration(labelText: 'Adresse mail'),
            ),
            TextField(
              controller: mailConfirmationController,
              decoration:
                  const InputDecoration(labelText: 'Adresse mail confirmation'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            TextField(
              controller: passwordConfirmationController,
              decoration:
                  const InputDecoration(labelText: 'Mot de passe confirmation'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                signUp(context);
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(BuildContext context) {
    final String mail = mailController.text;
    final String confirmedMail = mailConfirmationController.text;
    final String password = passwordController.text;
    final String confirmedPassword = passwordConfirmationController.text;

    if (mail != "" &&
        confirmedMail != "" &&
        password != "" &&
        confirmedPassword != "") {
      if (mail == confirmedMail && password == confirmedPassword) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign Up Successful'),
              content: Text('Welcome, $mail!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                  'Les mots de passe et les adresses mail ne sont pas égales'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Merci de remplir tous les champs'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    // Ajouter la logique d'inscription ici (par exemple, sauvegarder dans une base de données, etc.)
  }
}
