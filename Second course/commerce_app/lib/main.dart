import 'package:commerce_app/constants.dart';
import 'package:commerce_app/login_screen.dart';
import 'package:commerce_app/product_list_screen.dart';
import 'package:commerce_app/store_service.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'E-Commerce App',
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: MyHomePage(title: 'E-Commerce Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    clearLists();
    getProductsAndImages(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(HAVE_AN_ACCOUNT),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250,
              child: CupertinoButton.filled(
                child: const Text(LOGIN),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const LoginScreen(title: LOGIN)),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 40,
              child: Text(NEW_USER),
            ),
            SizedBox(
              width: 250,
              child: CupertinoButton.filled(
                child: const Text(CREATE_ACCOUNT),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            const LoginScreen(title: CREATE_ACCOUNT)),
                  );
                },
              ),
            ),
            const Spacer(),
            CupertinoButton(
              child: const Text(CONTINUE_AS_GUEST),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const ProductListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
