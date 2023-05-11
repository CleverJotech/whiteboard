import 'dart:math';
import 'dart:ui' as ui;
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
      home: const WhiteSplash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
      body: ListView(children: [
        Column(
          children: [
            Center(
              child: Transform.rotate(
                angle: -pi / 2,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: SubmittedScreen(submittedText: _text),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        elevation: 50,
        color: colorMaroon,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width / 1.2,
                      child: TextField(
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
                              errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: colorRed),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                      color: colorWhite,
                                      width: 6.0,
                                      style: BorderStyle.solid,
                                      strokeAlign:
                                          BorderSide.strokeAlignInside))),
                          onEditingComplete: () {
                            _inputText();
                            _doneWriting();
                            userText.clear();
                          }),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: IconButton(
                        color: colorWhite,
                        onPressed: () {
                          setState(() {
                            _inputText();
                            userText.clear();
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
        delayStart: const Duration(milliseconds: 5000),
        animationDuration: const Duration(milliseconds: 20000),
        offset: 2.5,
        direction: Direction.horizontal,
        child: Text(
          widget.submittedText,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 90.0,
            color: Colors.black54,
            letterSpacing: 3.0,
          ),
        ),
      ),
    );
  }
}
