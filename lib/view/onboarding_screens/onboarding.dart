import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylish_flutter/view/onboarding_screens/screen1.dart';
import 'package:stylish_flutter/view/onboarding_screens/screen2.dart';
import 'package:stylish_flutter/view/onboarding_screens/screen3.dart';

// ignore: must_be_immutable
class Onboarding extends StatefulWidget {
  ValueChanged<bool> onThemeChanged;
  bool isDarkMode;
  Onboarding({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: const [Screen1(), Screen2(), Screen3()],
          ),
          const SizedBox(
            height: 20,
          ),
          Positioned(
              bottom: 20.0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                          dotColor: Colors.orange,
                          activeDotColor: Colors.grey,
                          dotHeight: 12,
                          dotWidth: 12,
                          spacing: 8),
                    ),
                    if (_currentPage == 2)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
