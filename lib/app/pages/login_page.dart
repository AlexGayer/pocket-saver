import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animationHightLogin;
  late Animation<double> logoOpacityAnimation;
  late Animation<double> logoSizeAnimation;
  late Animation<double> commonFadeSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    animationHightLogin = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 1)
              .chain(CurveTween(curve: Curves.fastOutSlowIn)),
          weight: 0.25),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 0.41),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1, end: 0.5)
              .chain(CurveTween(curve: Curves.decelerate)),
          weight: 0.33),
    ]).animate(CurvedAnimation(
        parent: _animationController, curve: const Interval(0, 0.75)));

    logoOpacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
    ));

    logoSizeAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeInOut),
    ));

    commonFadeSlideAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 0.8, curve: Curves.easeInOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Column(
          children: [
            AnimatedLoginScreen(
              animationHightLogin: animationHightLogin,
              logoOpacityAnimation: logoOpacityAnimation,
              logoSizeAnimation: logoSizeAnimation,
              commonFadeSlideAnimation: commonFadeSlideAnimation,
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedLoginScreen extends StatelessWidget {
  final Animation<double> animationHightLogin;
  final Animation<double> logoOpacityAnimation;
  final Animation<double> logoSizeAnimation;
  final Animation<double> commonFadeSlideAnimation;

  const AnimatedLoginScreen(
      {super.key,
      required this.animationHightLogin,
      required this.logoOpacityAnimation,
      required this.logoSizeAnimation,
      required this.commonFadeSlideAnimation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * animationHightLogin.value,
      color: Colors.black,
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16), // Added some padding
            LoginLogo(
                logoOpacityAnimation: logoOpacityAnimation,
                logoSizeAnimation: logoSizeAnimation),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideFadeWidget(
                  commonFadeSlideAnimation: commonFadeSlideAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Login",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        "SignUp",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class LoginLogo extends StatelessWidget {
  final Animation<double> logoOpacityAnimation;
  final Animation<double> logoSizeAnimation;

  const LoginLogo(
      {super.key,
      required this.logoOpacityAnimation,
      required this.logoSizeAnimation});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: logoOpacityAnimation.value,
      child: Icon(
        MdiIcons.check,
        color: Colors.white,
        size: logoSizeAnimation.value * 150,
      ),
    );
  }
}

class SlideFadeWidget extends StatelessWidget {
  final Animation<double> commonFadeSlideAnimation;
  final Widget child;
  const SlideFadeWidget(
      {super.key, required this.commonFadeSlideAnimation, required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
          MediaQuery.of(context).size.width *
              (1 - commonFadeSlideAnimation.value),
          0),
      child: child,
    );
  }
}
