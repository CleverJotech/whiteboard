import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'user_input.dart';
import 'white_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SampleItem { itemOne, itemTwo }

enum TextSizes { twelve, twentyfour, thirtysix, fortyeight, sixty, seventytwo }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ScreenUtil.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'White Board',
      theme: ThemeData(
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.black87,
        textTheme: theme.textTheme,
      ),
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
  SampleItem? selectedMenu;
  TextSizes? selectedSize;
  late double boardTextSize;
  late int sheetTextLength;
  late String textView;
  late final InAppReview appReview = InAppReview.instance;
  //int _openCount = 0;

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
    colorWhiteBlend = const Color.fromARGB(200, 255, 255, 255);
    colorRed = Colors.redAccent;
    colorBlue = Colors.blueAccent;
    colorNull = Colors.transparent;
    userText = TextEditingController();
    boardTextSize = ScreenUtil().setSp(50);
    sheetTextLength = 70;
    textView = '';
    //_loadCounter();
  }

  // Future<void> _loadCounter() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     if (_openCount < 40) {
  //       _openCount = (prefs.getInt('openCount') ?? 0) + 1;
  //     } else {
  //       _openCount = 0;
  //     }
  //   });
  //   await prefs.setInt('openCount', _openCount);
  // }

  // _reviewMyApp() async {
  //   if (_openCount == 38) {
  //     if (await appReview.isAvailable()) {
  //       appReview.requestReview();
  //       setState(() {
  //         appReview.openStoreListing(appStoreId: 'com');
  //       });
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

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
          colorWhiteBlend = const Color.fromARGB(200, 255, 255, 255);
          colorRed = Colors.redAccent;
          colorBlue = Colors.blueAccent;
          colorNull = Colors.transparent;
        } else {
          colorMaroon = const Color.fromARGB(255, 255, 255, 255);
          colorWhite = const Color.fromARGB(255, 0, 0, 0);
          colorWhiteBlend = Colors.black54;
          colorRed = Colors.redAccent;
          colorBlue = Colors.blueAccent;
          colorNull = Colors.transparent;
        }
        isDarkMode = !isDarkMode;
      });
    }

    setTextMode() {
      setState(() {
        if (selectedSize == TextSizes.twelve) {
          setState(() {
            boardTextSize = ScreenUtil().setSp(12);
            sheetTextLength = 100;
            textView = 'Preview Of Size 12';
          });
        } else if (selectedSize == TextSizes.twentyfour) {
          setState(() {
            boardTextSize = ScreenUtil().setSp(24);
            sheetTextLength = 90;
            textView = 'Preview Of Size 24';
          });
        } else if (selectedSize == TextSizes.thirtysix) {
          setState(() {
            boardTextSize = ScreenUtil().setSp(36);
            sheetTextLength = 80;
            textView = 'Preview Of Size 36';
          });
        } else if (selectedSize == TextSizes.fortyeight) {
          setState(() {
            boardTextSize = ScreenUtil().setSp(48);
            sheetTextLength = 70;
            textView = 'Preview Of Size 48';
          });
        } else if (selectedSize == TextSizes.sixty) {
          setState(() {
            boardTextSize = ScreenUtil().setSp(60);
            sheetTextLength = 40;
            textView = 'Preview Of Size 60';
          });
        } else if (selectedSize == TextSizes.seventytwo) {
          setState(() {
            boardTextSize = ScreenUtil().setSp(72);
            sheetTextLength = 30;
            textView = 'Preview Of Size 72';
          });
        } else {
          setState(() {
            boardTextSize = 50;
            sheetTextLength = 70;
            textView = '';
          });
        }
      });
    }

    userGivenText() {
      if (_text != '') {
        return Flexible(
          flex: 1,
          child: Center(
            child: SlideFadeTransition(
              curve: Curves.elasticInOut,
              delayStart: const Duration(milliseconds: 200),
              animationDuration: const Duration(milliseconds: 800),
              offset: 1.0,
              direction: Direction.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: colorMaroon,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: colorBlue,
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                width: 400.w,
                height: 360.h,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _text,
                      textScaleFactor: null,
                      style: TextStyle(
                        fontSize: boardTextSize,
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
        );
      } else {
        return Expanded(
          child: SizedBox(
            height: 300.h,
            width: 200.w,
          ),
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorMaroon,
          leading:  IconButton(
                      iconSize: 25.sp,
                      focusColor: colorNull,
                      hoverColor: colorNull,
                      splashColor: colorNull,
                      highlightColor: colorNull,
                      onPressed: () {
                        setState(() {
                          _text = '';
                        });
                      },
                      icon: Icon(
                        Icons.cleaning_services_rounded,
                        color: colorWhiteBlend,
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
          actions: [
            IconButton(
                      iconSize: 25.sp,
                      focusColor: colorNull,
                      hoverColor: colorNull,
                      splashColor: colorNull,
                      highlightColor: colorNull,
                      onPressed: () {
                        setState(() {
                          setColorMode();
                        });
                      },
                      icon: Icon(
                        isDarkMode == false
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_rounded,
                        color: colorWhiteBlend,
                      ),
                    ),
            PopupMenuButton(
              splashRadius: 15,
              initialValue: selectedMenu,
              elevation: 8,
              shadowColor: colorBlue,
              color: colorWhiteBlend,
              icon: Icon(
                Icons.more_vert,
                color: colorWhiteBlend,
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<SampleItem>>[
                  PopupMenuItem(
                    value: SampleItem.itemOne,
                    child: PopupMenuButton(
                      initialValue: selectedSize,
                      onSelected: (TextSizes text) {
                        setState(() {
                          selectedSize = text;
                          setTextMode();
                          _text = textView;
                          // _reviewMyApp();
                        });
                      },
                      child: Text(
                        "Board's Text Size",
                        style: TextStyle(
                          color: colorMaroon,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<TextSizes>>[
                          PopupMenuItem(
                            value: TextSizes.twelve,
                            child: Text(
                              '12',
                              style: TextStyle(
                                color: colorMaroon,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: TextSizes.twentyfour,
                            child: Text(
                              '24',
                              style: TextStyle(
                                color: colorMaroon,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: TextSizes.thirtysix,
                            child: Text(
                              '36',
                              style: TextStyle(
                                color: colorMaroon,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: TextSizes.fortyeight,
                            child: Text(
                              '48',
                              style: TextStyle(
                                color: colorMaroon,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: TextSizes.sixty,
                            child: Text(
                              '60',
                              style: TextStyle(
                                color: colorMaroon,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: TextSizes.seventytwo,
                            child: Text(
                              '72',
                              style: TextStyle(
                                color: colorMaroon,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                  // PopupMenuItem(
                  //   value: SampleItem.itemTwo,
                  //   child: Text(
                  //     'About Us',
                  //     style: TextStyle(
                  //       color: colorMaroon,
                  //       fontWeight: FontWeight.w300,
                  //     ),
                  //   ),
                  // ),
                ];
              },
              onSelected: (SampleItem item) {
                setState(() {
                  selectedMenu = item;
                });
              },
            ),
          ],
        ),
        body: Container(
          width: 400.w,
          height: 513.h,
          color: colorWhiteBlend,
          child: Center(
            child: Transform.rotate(
              angle: -pi / 2,
              child: userGivenText(),
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
                                style: TextStyle(color: colorWhiteBlend),
                                maxLength: sheetTextLength,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                controller: userText,
                                focusNode: myFocus,
                                autofocus: isActive,
                                keyboardType: TextInputType.name,
                                cursorColor: colorWhite,
                                decoration: InputDecoration(
                                    counterStyle:
                                        TextStyle(color: colorWhiteBlend),
                                    hintStyle: TextStyle(
                                        color: colorWhiteBlend,
                                        fontWeight: FontWeight.w200),
                                    hintText:
                                        '                      What you wanna say??',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: colorWhiteBlend),
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
                                            color: colorWhiteBlend,
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
                              color: colorWhiteBlend,
                              onPressed: () {
                                setState(() {
                                  _inputText();
                                  userText.clear();
                                  FocusScope.of(context).unfocus();
                                });
                              },
                              icon: Icon(
                                Icons.send_rounded,
                                color: colorWhiteBlend,
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
