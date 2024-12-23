import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:productivity_app/comps/introButton.dart';
import 'package:productivity_app/pages/introPages/welcome1.dart';
import 'package:productivity_app/pages/introPages/welcome2.dart';
import 'package:productivity_app/pages/introPages/welcome3.dart';
import 'package:productivity_app/pages/root.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 18, 26, 39),
            child: Lottie.asset(
              'lib/animate/mesh.json',
              width: double.infinity,
            ),
          ),

          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 100.0,
                sigmaY: 100.0,
              ),
              child: Container(
                width: double.infinity,
              ),
            ),
          ),

          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              // DIFFERENT PAGES
              Welcome1(),
              Welcome2(),
              Welcome3(),
            ],
          ),

          //LOGO IMAGE
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset('lib/images/LOGO-nav.png'),
          ),

          // DEPENDING ON THE CURRENT PAGE
          onLastPage
              ? GestureDetector(
                  // LAST PAGE => HOME PAGE
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Root();
                    }));
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 680),
                    child: introButton(title: 'Start!'),
                  ),
                )
              : GestureDetector(
                  // NOT LAST PAGE => NEXT PAGE
                  onTap: () {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 680),
                    child: introButton(title: 'Next'),
                  ),
                ),

          // BOTTOM BAR
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
                alignment: const Alignment(-0.8, 0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SMOOTH INDICATOR
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                          activeDotColor: Color.fromARGB(255, 253, 253, 252)),
                    ),

                    // SOCIAL MEDIA LINKS

                    Row(
                      children: [
                        Image.asset('lib/images/insta.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset('lib/images/linkedin.png')
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
