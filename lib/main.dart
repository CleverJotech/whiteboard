import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'user_input.dart';
import 'white_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'White Board',
      theme: ThemeData(
          canvasColor: colorWhite, scaffoldBackgroundColor: colorMaroon),
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
  bool isActive = false;
  FocusNode myFocus = FocusNode();

  @override
  void initState() {
    userText = TextEditingController();
    super.initState();
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

  userGivenText() {
    if (_text != '') {
      return SubmittedScreen(submittedText: _text);
    } else {
      return const SizedBox(
        height: 300,
        width: 400,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              width: screenSize.width / 10,
            )
          ],
        ),
        leading: Center(
          child: IconButton(
            onPressed: () {
              setState(() {
                _text = '';
              });
            },
            icon: clearIcon,
          ),
        ),
        backgroundColor: colorMaroon,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Transform.rotate(
                    angle: -pi / 2,
                    child: userGivenText(),
                  ),
                ),
              ],
            ),
            InkWell(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenSize.width / 1.2,
                          child: TextField(
                              style: const TextStyle(color: colorWhite),
                              maxLength: 80,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              controller: userText,
                              focusNode: myFocus,
                              autofocus: isActive,
                              keyboardType: TextInputType.name,
                              cursorColor: colorWhite,
                              decoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                      color: colorWhite,
                                      fontWeight: FontWeight.w200),
                                  hintText:
                                      '                      What you wanna say??',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: colorWhite),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: colorBlue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: colorRed),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      borderSide: const BorderSide(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            icon: const Icon(Icons.send_rounded),
                          ),
                        ),
                      ],
                    )
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

class SubmittedScreen extends StatefulWidget {
  final String submittedText;

  const SubmittedScreen({super.key, required this.submittedText});

  @override
  State<SubmittedScreen> createState() => _SubmittedScreenState();
}

class _SubmittedScreenState extends State<SubmittedScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Center(
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
              color: colorWhiteBlend,
              width: screenSize.width / 1.00,
              height: screenSize.height / 1.27,
              child: BackdropFilter(
                blendMode: BlendMode.srcOver,
                filter: ui.ImageFilter.dilate(radiusX: 10.0, radiusY: 10.0),
                child: Center(
                  child: Text(
                    widget.submittedText,
                    textScaleFactor: null,
                    style: const TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w900,
                      color: colorWhite,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
