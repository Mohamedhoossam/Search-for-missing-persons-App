import 'dart:math';
import 'package:flutter/material.dart';
import 'package:newnew/modules/user_authentication/login_screen.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/local/share_pereference.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  bool isLast =false;
  String text ='Next';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:defaultColor,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,

       child:
        Stack(
          children:  [
            const Image(image: AssetImage('assets/images/onboardinImage.jpg')
              ,fit: BoxFit.cover,),
            Positioned(
                top: 75,
                right: 5,
                left: 5,

              child:
              Lottie.asset(
                tabs[_currentIndex].lottieFile,
                key: Key('${Random().nextInt(999999999)}'),
                width: 300,
                height: 300,
                alignment: Alignment.topCenter,
                animate: true,

              ),
            ),
            Positioned(
              top: 40,
              right: 5,
              child: TextButton(
                  onPressed: (){
                    CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
                      navigateToAndRemove(context, LoginScreen());

                    });
                    },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        color: defaultColor,
                        fontSize: 16

                    ),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 270,
                child: Column(
                  children: [
                    Flexible(
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: _pageController,
                        itemCount: tabs.length,
                        itemBuilder: (BuildContext context, int index) {
                          OnboardingModel tab = tabs[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tab.title,
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  tab.subtitle,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white70,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          );
                        },
                        onPageChanged: (int index ) {
                          _currentIndex = index;

                          setState(() {});
                          if(_currentIndex == tabs.length -1){
                            setState(() {
                              isLast =true;
                              text ='Get Started';

                            });
                          }else{
                            setState(() {
                              isLast = false;
                              text ='Next';

                            });
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int index = 0; index < tabs.length; index++)
                          _DotIndicator(isSelected: index == _currentIndex),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 45,
                      width:200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:defaultColor,
                      ),
                      child: MaterialButton(
                        highlightColor: defaultColor,
                        onPressed: (){
                          if(isLast){
                            CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
                              navigateToAndRemove(context, LoginScreen());

                            });
                          }
                          else{
                            _pageController.nextPage(
                              duration: const Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                          }
                        },
                        child:Text(text ,
                          style: const TextStyle(
                            color: Colors.white,

                          ),
                        ) ,
                        animationDuration: const Duration(milliseconds: 750),
                        minWidth: double.infinity,
                        height:45 ,

                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),


          ],
        ),

      ),
    );
  }
}


class _DotIndicator extends StatelessWidget {
  final bool isSelected;

  const _DotIndicator({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isSelected ==true?13:10,
        width: isSelected ==true?13:10,
        decoration: BoxDecoration(
         // borderRadius: BorderRadius.circular(5),
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Colors.white38,
        ),
      ),
    );
  }
}

class OnboardingModel {
  final String lottieFile;
  final String title;
  final String subtitle;

  OnboardingModel(this.lottieFile, this.title, this.subtitle);
}

List<OnboardingModel> tabs = [
  OnboardingModel(
    'assets/images/search1.json',
    'Search for the missing',
    'Search and help find the missing for a better world with them.',
  ),
  OnboardingModel(
    'assets/images/search3.json',
    'Maybe here',
    'You may find your lost loved ones here',
  ),
  OnboardingModel(
    'assets/images/search2.json',
    'Your lost things !',
    'Your lost things may be found here too',
  ),
];
