import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'user_input.dart';
import 'white_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'White Board',
      theme: ThemeData(
          canvasColor: Colors.white, scaffoldBackgroundColor: Colors.black87),
      home: const WhiteSplash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController userText;
  late String _text = '';
  bool isActive = true;
  bool isDarkMode = false;
  FocusNode myFocus = FocusNode();

  late Color colorMaroon;
  late Color colorWhite;
  late Color colorWhiteBlend;
  late Color colorRed;
  late Color colorBlue;
  late Color colorNull;

  @override
  void initState() {
    super.initState();
    userText = TextEditingController();
    _text = '';
    colorMaroon = Colors.black;
    colorWhite = const Color.fromARGB(255, 255, 255, 255);
    colorWhiteBlend = const Color.fromARGB(230, 255, 255, 255);
    colorRed = Colors.redAccent;
    colorBlue = Colors.blueAccent;
    colorNull = Colors.transparent;
    userText = TextEditingController();
  }

  @override
  void dispose() {
    userText.dispose();
    myFocus.dispose();
    super.dispose();
  }

  void _inputText() {
    setState(() {
      _text = userText.text;
    });
  }

  void _doneWriting() {
    setState(() {
      isActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    setColorMode() {
      setState(() {
        if (isDarkMode == true) {
          colorMaroon = Colors.black;
          colorWhite = const Color.fromARGB(255, 255, 255, 255);
          colorWhiteBlend = const Color.fromARGB(230, 255, 255, 255);
          colorRed = Colors.redAccent;
          colorBlue = Colors.blueAccent;
          colorNull = Colors.transparent;
        } else {
          colorMaroon = const Color.fromARGB(255, 255, 255, 255);
          colorWhite = const Color.fromARGB(255, 0, 0, 0);
          colorWhiteBlend = Colors.black87;
          colorRed = Colors.redAccent;
          colorBlue = Colors.blueAccent;
          colorNull = Colors.transparent;
        }
        isDarkMode = !isDarkMode;
      });
    }

    userGivenText() {
      if (_text != '') {
        return Flexible(
          flex: 2,
          child: Center(
            child: SlideFadeTransition(
              curve: Curves.elasticInOut,
              delayStart: const Duration(milliseconds: 200),
              animationDuration: const Duration(milliseconds: 800),
              offset: 1.0,
              direction: Direction.horizontal,
              child: Center(
                child: ClipRect(
                  clipper: null,
                  child: Container(
                    color: colorMaroon,
                    width: 900.w,
                    height: 380.h,
                    child: BackdropFilter(
                      blendMode: BlendMode.srcOver,
                      filter:
                          ui.ImageFilter.dilate(radiusX: 10.0, radiusY: 10.0),
                      child: Center(
                        child: Text(
                          _text,
                          textScaleFactor: null,
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w900,
                            color: colorMaroon,
                            letterSpacing: 3.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        return Expanded(
          child: SizedBox(
            height: screenSize.height / 1.47,
            width: screenSize.width / 1.2,
          ),
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorMaroon,
          leadingWidth: screenSize.width / 5,
          leading: Flexible(
            flex: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: Expanded(
                        child: IconButton(
                          color: colorWhite,
                          focusColor: colorNull,
                          hoverColor: colorNull,
                          splashColor: colorNull,
                          highlightColor: colorNull,
                          onPressed: () {
                            setState(() {
                              _text = '';
                            });
                          },
                          icon: clearIcon,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: screenSize.width / 90,
                      indent: 13,
                      endIndent: 13,
                      height: 13,
                    ),
                    // SizedBox(
                    //   width: screenSize.width / 15,
                    // ),
                    Expanded(
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: IconButton(
                          focusColor: colorNull,
                          hoverColor: colorNull,
                          splashColor: colorNull,
                          highlightColor: colorNull,
                          onPressed: () {
                            setState(() {
                              //toggleTheme();
                              //toggleMode();
                              setColorMode();
                            });
                          },
                          icon: Icon(
                            Theme.of(context).brightness == Brightness.light
                                ? Icons.light_mode_outlined // dark mode icon
                                : Icons.dark_mode_rounded, // light mode icon
                            color: colorWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Container(),
                ),
              ],
            ),
          ),
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(
              color: colorWhiteBlend,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: Center(
          child: Container(
            color: colorWhiteBlend,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: userGivenText(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: colorMaroon,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 2, right: 12, left: 12, top: 12),
            child: InkWell(
              onTap: () {
                setState(() {});
              },
              child: SizedBox(
                height: screenSize.height / 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width / 50,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenSize.width / 1.2,
                            child: TextField(
                                style: TextStyle(color: colorWhite),
                                maxLength: 80,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                controller: userText,
                                focusNode: myFocus,
                                autofocus: isActive,
                                keyboardType: TextInputType.name,
                                cursorColor: colorWhite,
                                decoration: InputDecoration(
                                    counterStyle: TextStyle(color: colorWhite),
                                    hintStyle: TextStyle(
                                        color: colorWhite,
                                        fontWeight: FontWeight.w200),
                                    hintText:
                                        '                      What you wanna say??',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: colorWhite),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5, color: colorBlue),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 2, color: colorRed),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        borderSide: BorderSide(
                                            color:
                                                colorWhite, // set the border color to white
                                            width: 2.0,
                                            style: BorderStyle.solid,
                                            strokeAlign:
                                                BorderSide.strokeAlignInside))),
                                onEditingComplete: () {
                                  _inputText();
                                  _doneWriting();
                                  userText.clear();
                                  FocusScope.of(context).unfocus();
                                }),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: IconButton(
                              color: colorWhite,
                              onPressed: () {
                                setState(() {
                                  _inputText();
                                  userText.clear();
                                  FocusScope.of(context).unfocus();
                                });
                              },
                              icon: Icon(
                                Icons.send_rounded,
                                color: colorWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
