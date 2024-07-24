import 'package:commerce_app/constants.dart';
import 'package:commerce_app/product_list_screen.dart';
import 'package:commerce_app/store_service.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String buttonText;
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    buttonText = widget.title == LOGIN ? LOGIN : CREATE_ACCOUNT;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                height: 40,
                child: CupertinoTextField(
                  placeholder: ENTER_USERNAME,
                  controller: usernameTextController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                height: 40,
                child: CupertinoTextField(
                  placeholder: ENTER_PASSWORD,
                  obscureText: true,
                  controller: passwordTextController,
                ),
              ),
            ),
            SizedBox(
              child: CupertinoButton.filled(
                child: Text(buttonText),
                onPressed: () async {
                  var result = await login(
                      usernameTextController.text, passwordTextController.text);
                  if (result.body == USERNAME_OR_PASSWORD_IS_INCORRECT) {
                    if (!mounted) return;
                    showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: const Text(INVALID_CREDENTIALS),
                            content:
                                const Text(USERNAME_OR_PASSWORD_IS_INCORRECT),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text(OK),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    if (!mounted) return;
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const ProductListScreen(),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
