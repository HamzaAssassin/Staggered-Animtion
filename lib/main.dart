import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerBurger;
  late Animation<Offset> _animationUpperBun;
  late Animation<Offset> _animationOnion;
  late Animation<Offset> _animationCheese;
  // late Animation<Offset> _animationBurgerPatties;
  late Animation<Offset> _animationBottomBun;

  late Tween<Offset> _tweenUpperBun;
  late Tween<Offset> _tweenBottomBun;
  // late Tween<Offset> _tweenBurgerPatties;
  late Tween<Offset> _tweenOnion;
  late Tween<Offset> _tweenCheese;

  @override
  void initState() {
    super.initState();
    _tweenUpperBun =
        Tween<Offset>(begin: const Offset(0, -6), end: Offset.zero);
    _tweenBottomBun =
        Tween<Offset>(begin: const Offset(0, -20), end: Offset.zero);
    // _tweenBurgerPatties =
    //     Tween<Offset>(begin: const Offset(0, -15), end: Offset.zero);
    _tweenOnion = Tween<Offset>(begin: const Offset(0, -17), end: Offset.zero);
    _tweenCheese = Tween<Offset>(begin: const Offset(0, -14), end: Offset.zero);

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..forward();

    _controllerBurger = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))..forward();

    _animationBottomBun = _tweenBottomBun.animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0, 0.25)));
    // _animationBurgerPatties = _tweenBurgerPatties.animate(
    //     CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)));
    _animationCheese = _tweenCheese.animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.25, 0.5)));
    _animationOnion = _tweenOnion.animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.5, 0.75)));
    _animationUpperBun = _tweenUpperBun.animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.75, 1)));
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerBurger.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: _controllerBurger,
            curve: Curves.elasticInOut,
          )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: height*0.5,
              width: width*0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SlideTransition(
                    position: _animationUpperBun,
                    child: Container(
                      width: width * 0.5,
                      height: height * 0.08,
                      child: Image.asset(
                        "assets/images/upperburger .png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _animationOnion,
                    child: Container(
                      width: width * 0.5,
                      height: height * 0.05,
                      child: Image.asset(
                        "assets/images/Onionburger.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _animationCheese,
                    child: Container(
                      width: width * 0.5,
                      height: height * 0.05,
                      child: Image.asset(
                        "assets/images/pattiesburger.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _animationBottomBun,
                    child: Container(
                      width: width * 0.5,
                      height: height * 0.08,
                      child: Image.asset(
                        "assets/images/bottomburger.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("Reset"),
        onPressed: () {
          _controller.reset();
          _controller.forward();
          // if (_controller.isCompleted) {
          //   _controllerBurger.repeat();
          // }
        },
      ),
    );
  }
}
