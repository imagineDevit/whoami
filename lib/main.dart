import 'package:flutter/material.dart';
import 'package:henri_sedjame/misc/images.dart';
import 'package:henri_sedjame/misc/logo-properties.dart';
import 'package:henri_sedjame/presentation/pages/first-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WHOAMI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late ScrollController _scrollController;
  double logoPositionTop = 0.0;
  double? logoPositionLeft;
  double logoSize = 1000.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController() ..addListener(() {
      var offset = _scrollController.offset;
      logoPositionTop = offset;
      var screenHeight = MediaQuery.of(context).size.height;
      var initialPositionLeft = (MediaQuery.of(context).size.width/2) - (maxLogoSize/2);
      if (offset < screenHeight) {
        logoSize = maxLogoSize - (((maxLogoSize - minLogoSize)/screenHeight)*offset);
        logoPositionLeft = initialPositionLeft - ((initialPositionLeft/screenHeight)*offset);
      }
      setState(() => {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const FirstPage(),
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(28, 24, 33, 1),
                  ),
                ),
              ],
            ),
            Positioned(
                top: logoPositionTop,
                left: logoPositionLeft,
                child: Image(
                    image: const AssetImage(logoImg),
                    width: logoSize,
                )
            ),
          ],
        ),
      ),
    );
  }
}
