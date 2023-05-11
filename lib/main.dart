import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:whiteboard/constants.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard/user_input.dart';
import 'package:whiteboard/white_splash.dart';

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
      title: 'WhiteBoard',
      theme: ThemeData(canvasColor: colorWhite),
      home: const MyHomePage(title: 'WhiteBoard'),
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        backgroundColor: colorMaroon,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  width: screenSize.width / 5,
                  height: screenSize.height / 1.34,
                  child: ClipRect(
                    child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: SubmittedScreen(submittedText: _text)
                        //Text(
                        //   _text,
                        //   style: const TextStyle(
                        //     fontWeight: FontWeight.w900,
                        //     fontSize: 90.0,
                        //     color: Colors.black54,
                        //     letterSpacing: 3.0,
                        //   ),
                        // ),
                        ),
                  ),
                ),
              ),
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
                              maxLength: 100,
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
                                    borderSide: BorderSide(
                                        width: 1, color: colorMaroon),
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
                                              colorMaroon, // set the border color to white
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: IconButton(
                            color: colorMaroon,
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
    return Center(
      child: SlideFadeTransition(
        curve: Curves.elasticInOut,
        delayStart: const Duration(milliseconds: 1800),
        animationDuration: const Duration(milliseconds: 5000),
        offset: 1.0,
        direction: Direction.horizontal,
        child: Center(
          child: Text(
            widget.submittedText,
            textScaleFactor: null,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black54,
              letterSpacing: 3.0,
            ),
          ),
        ),
      ),
    );
  }
}
