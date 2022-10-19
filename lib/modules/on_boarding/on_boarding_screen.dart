import 'package:car/layout/home_layout_without_login/home_layout_without_login.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModl {
  final String image;
  final String title;
  final String body;

  BoardingModl({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  List<BoardingModl> boarding = [
    BoardingModl(
        image: 'assets/images/onBoarding0.png',
        title: 'On Board 1 Titel',
        body: 'On Board 1 Body'),
    BoardingModl(
      image: 'assets/images/onBoarding1.webp',
      title: 'On Board 2 Titel',
      body: 'On Board 2 Body',
    ),
    BoardingModl(
      image: 'assets/images/onBoarding2.webp',
      title: 'On Board 3 Titel',
      body: 'On Board 3 Bod',
    ),
  ];
  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then(
      (value) async {
        //print(value);
        if (value == true) {
          await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => home_layout_without_login(),
              ),
              (Route<dynamic> rout) => false);
        }
      },
    );
  }

  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      appBar: AppBar(
        //backgroundColor: Colors.grey[100],
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              "SKIP",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: CustomizableEffect(
                    activeDotDecoration: DotDecoration(
                      width: 32,
                      height: 12,
                      color: Colors.indigo,
                      rotationAngle: 180,
                      verticalOffset: -10,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(2)),
                      //borderRadius: BorderRadius.circular(24),
                      dotBorder: DotBorder(
                        padding: 2,
                        width: 2,
                        color: Colors.indigo,
                      ),
                    ),
                    dotDecoration: DotDecoration(
                      width: 24,
                      height: 12,
                      color: Colors.grey,
                      dotBorder: DotBorder(
                        padding: 2,
                        width: 2,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(2)),
                      // borderRadius: BorderRadius.circular(16),
                      verticalOffset: 0,
                    ),
                    spacing: 6.0,
                    // activeColorOverride: (i) => colors[i],
                    //inActiveColorOverride: (i) => colors[i],
                  ),
                  controller: boardController,
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.indigo,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModl model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
