import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTextFieldWidget(),
    );
  }
}

class MyTextFieldWidget extends StatefulWidget {
  MyTextFieldWidget({Key? key}) : super(key: key);
  @override
  _MyTextFieldWidgetState createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  late TextEditingController _emailController;
  late TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 14, 49),
      body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const Icon(
                Icons.app_registration_rounded,
                size: 200,
                color: Color.fromARGB(255, 0, 255, 234),
              ),
              const SizedBox(
                height: 70,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _emailController,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),
                  hintText: "Email",
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                        width: 0.5, color: Color.fromARGB(255, 0, 255, 234)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                        width: 1, color: Color.fromARGB(255, 0, 255, 234)),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _passController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.password_outlined,
                    color: Colors.white,
                  ),
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                        width: 0.5, color: Color.fromARGB(255, 0, 255, 234)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                        width: 1, color: Color.fromARGB(255, 0, 255, 234)),
                  ),
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Center(
                child: SizedBox(
                  height: 40,
                  width: 150,
                  child: TextButton(
                      onPressed: () async {
                        final user = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text.toString(),
                                password: _passController.text.toString());
                        print(user);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 0, 255, 234))),
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 1, 14, 49)),
                      )),
                ),
              ),
            ],
          )),
    );
  }
}
