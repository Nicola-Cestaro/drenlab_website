import 'package:drenlab_website/theme/style.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);


  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  late RiveAnimationController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

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
                  alignment: Alignment.bottomCenter,
                  children: [
                    RiveAnimation.asset(
                      'assets/background.riv',
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
                      onInit: _onRiveInit
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: screenSize.height * 0.1),
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
              Container(
                width: screenSize.width,
                height: screenSize.height,
                color: backgroundColor,
              ),
            ],
          ),
        ),
      )
    );
  }
}
