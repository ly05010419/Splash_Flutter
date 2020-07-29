import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

import 'PageIndicator.dart';

void main() => runApp(MyApp());

var pageList = [
  PageModel(
      imageUrl: "assets/illustration.png",
      title: "MUSIC",
      body: "MUSIC MUSIC MUSIC",
      titleGradient: gradients[0]),
  PageModel(
      imageUrl: "assets/illustration2.png",
      title: "FARBE",
      body: "FARBE FARBE FARBE",
      titleGradient: gradients[1]),
  PageModel(
      imageUrl: "assets/illustration3.png",
      title: "2020",
      body: "2020 2020 2020",
      titleGradient: gradients[2]),
];

List<List<Color>> gradients = [
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFFE2859F), Color(0xFFFCCF31)],
  [Color(0xFF5EFCE8), Color(0xFF736EFE)],
];

class PageModel {
  var imageUrl;
  var title;
  var body;
  List<Color> titleGradient = [];

  PageModel({this.imageUrl, this.title, this.body, this.titleGradient});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  PageController pageController;

  AnimationController animationController;
  Animation<double> scaleAnimation;

  int currentPape = 0;

  double scale = 0;

  bool lastPage = false;

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      initialPage: currentPape,
    );

    animationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);

    scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF485563), Color(0xFF185563)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
                controller: pageController,
                itemCount: pageList.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPape = index;
                    if (index == pageList.length - 1) {
                      lastPage = true;
                      animationController.reset();
                      animationController.forward();
                    } else {
                      lastPage = false;
                    }
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (context, widget) {
                      PageModel page = pageList[index];

                      var delta;
                      var y = 1.0;

                      if (pageController.position.haveDimensions) {
                        delta = pageController.page - index;

                        y = delta.abs();
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(page.imageUrl),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Stack(
                              children: <Widget>[
                                Opacity(
                                  child: GradientText(
                                    page.title,
                                    gradient: LinearGradient(
                                        colors: page.titleGradient),
                                    style: TextStyle(
                                        fontSize: 80,
                                        fontFamily: "Montserrat-Black",
                                        letterSpacing: 1.0),
                                  ),
                                  opacity: 0.1,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 22, top: 30),
                                  child: GradientText(
                                    page.title,
                                    gradient: LinearGradient(
                                        colors: page.titleGradient),
                                    style: TextStyle(
                                        fontSize: 80,
                                        fontFamily: "Montserrat-Black",
                                        letterSpacing: 1.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0.0, 50.0 * (1 - y)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, left: 30),
                              child: Text(
                                page.body,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: "Montserrat-Medium",
                                    color: Colors.white30),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Align(
                 alignment: Alignment.bottomCenter,
                  child: Container(
                      width: 260,
                      child: PageIndicator(currentPape, pageList.length))),
            ),

          ],
        ),
      ),
    );
  }
}

