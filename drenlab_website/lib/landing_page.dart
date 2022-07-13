import 'dart:math';

import 'package:drenlab_website/theme/style.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'components/project_element.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);


  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  late RiveAnimationController _controller;
  late RiveAnimationController _controllerBlock;
  final ScrollController _scrollController = ScrollController();

  SMITrigger? triggerDesktop;
  SMITrigger? triggerMobile;
  SMITrigger? triggerWeb;

  bool moveTop = false;
  @override
  void initState() {
    _controllerBlock = SimpleAnimation('Animation 1', autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    void _onRiveInit(Artboard artboard) {
      final controller = StateMachineController.fromArtboard(artboard, 'Reload');
      artboard.addController(controller!);
      _controller = controller;
    }

    void _onRiveInitSchermi(Artboard artboard) {
      final controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
      artboard.addController(controller!);
      _controller = controller;
      triggerDesktop = controller.findSMI('desktop');
      triggerMobile = controller.findSMI('mobile');
      triggerWeb = controller.findSMI('web');
    }

    return Scaffold(
      body: WebSmoothScroll(
        controller: _scrollController,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                width: screenSize.width,
                height: screenSize.height,
                color: primaryColor,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: screenSize.width,
                      height: screenSize.height,
                      child: RiveAnimation.asset(
                        'assets/background.riv',
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                        onInit: _onRiveInit
                      ),
                    ),
                    AnimatedPositioned(
                      top: moveTop ? _scrollController.offset : 0.0,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      child: VisibilityDetector(
                        onVisibilityChanged: (VisibilityInfo info) {
                          print(moveTop);
                          print(_scrollController.offset);
                          if(info.visibleFraction != 1){
                            moveTop = true;
                          } else if(_scrollController.offset == 0){
                            moveTop = false;
                          }
                          setState((){});
                        },
                        key: const Key('schermo_1'),
                        child: Container(
                          width: screenSize.width / 2,
                          height: screenSize.width / 2,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: screenSize.width / 2,
                                height: screenSize.width / 2,
                                child: RiveAnimation.asset(
                                  "schermi.riv",
                                  fit: BoxFit.cover,
                                  onInit: _onRiveInitSchermi,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Welcome to the\nMulti-Platform era",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height,
                color: backgroundColor,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedPositioned(
                      top: moveTop ? _scrollController.offset - screenSize.height : 0.0,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              width: screenSize.width / 2,
                              height: screenSize.width / 2,
                              child: RiveAnimation.asset(
                                "schermi.riv",
                                fit: BoxFit.cover,
                                onInit: _onRiveInitSchermi,
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      triggerWeb!.fire();
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 50,
                                      color: primaryColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      triggerDesktop!.fire();
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 50,
                                      color: primaryColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      triggerMobile!.fire();
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 50,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: VisibilityDetector(
                        key: const Key('block_1'),
                        onVisibilityChanged: (VisibilityInfo info) {
                          _controllerBlock.isActive = true;
                        },
                        child: Container(
                          width: screenSize.width / 5,
                          height: screenSize.width / 5,
                          color: Colors.transparent,
                          child: RiveAnimation.asset(
                            "blocks_1.riv",
                            controllers: [_controllerBlock],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height,
                color: primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenSize.width,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 100),
                      child: Text(
                        "Projects"
                      ),
                    ),
                    Container(
                      width: screenSize.width,
                      height: screenSize.height * 0.7,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 100),

                        children: [
                          ProjectElement(),
                          ProjectElement(),
                          ProjectElement(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
