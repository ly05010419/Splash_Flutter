import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

void main() => runApp(MyApp());

var pageList = [
  PageModel(
      imageUrl: "assets/illustration.png",
      title: "MUSIC",
      body: "EXPERIENCE WICKED PLAYLISTS",
      titleGradient: gradients[0]),
  PageModel(
      imageUrl: "assets/illustration2.png",
      title: "SPA",
      body: "FEEL THE MAGIC OF WELLNESS",
      titleGradient: gradients[1]),
  PageModel(
      imageUrl: "assets/illustration3.png",
      title: "TRAVEL",
      body: "LET'S HIKE UP",
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
  int currentPape = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      initialPage: currentPape,
    );

    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF485563), Color(0xFF29323C)],
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
                        y = 1 - delta.abs().clamp(0.0, 1.0);
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
                                        fontSize: 110,
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
                          Transform(
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
                            transform:
                                Matrix4.translationValues(0, 50.0 * (1 - y), 0),
                          ),
                        ],
                      );
                    },
                  );
                }),
            Positioned(
                left: 35,
                bottom: 55,
                child: Container(
                    width: 260,
                    child: PageIndicator(currentPape, pageList.length))),
          ],
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int currenPage;

  final int size;

  PageIndicator(this.currenPage, this.size);

  Widget buildIndicator(bool isActive) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white10,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2.0, 2.0),
                    spreadRadius: 2)
              ]),
          height: 4,
        ),
      ),
    );
  }

  List<Widget> buildIndicatorList() {
    List<Widget> list = new List();

    for (int i = 0; i < 3; i++) {
      list.add(buildIndicator(i == currenPage));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buildIndicatorList(),
    );
  }
}
