import 'package:flutter/cupertino.dart';
import 'Models/FileManager.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  // MARK: VARIABLES
  PageController pageController = PageController(initialPage: 0);
  List<FocusNode> textFocusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  List<TextEditingController> textControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool keyboardIsShowing = false;
  FileManager fileManager = FileManager(fileName: 'entries.txt');

  //MARK: METHODS
  @override
  void initState() {
    super.initState();
    // Page listener that focuses the keyboard whenever the page changes
    addPageControllerListener();
    addTextControllerListeners();
  }

  @override
  void dispose() {
    // Disposing the page controller and focusNodes for the textFields
    disposeElements();
    super.dispose();
  }

  void disposeElements() {
    for (int i = 0; i < textFocusNodes.length; ++i) {
      textFocusNodes[i].dispose();
      textControllers[i].dispose();
    }
    pageController.dispose();
  }

  void addTextControllerListeners() {
    for (int i = 0; i < textFocusNodes.length; ++i) {
      textFocusNodes[i].addListener(() {
        if (textFocusNodes[i].hasFocus) {
          keyboardIsShowing = true;
        } else {
          keyboardIsShowing = false;
        }
      });
    }
  }

  void addPageControllerListener() {
    pageController.addListener(() {
      double page = pageController.page;
      if (keyboardIsShowing) {
        textFocusNodes[page.round()].requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //MARK: Component UI Items
    final AlertView = CupertinoAlertDialog(
      title: Text('Don\'t Forget'),
      content: Text('It\'s important to answer each question.'),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );

    //MARK: Main Page
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Daily Questions',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.black,
          previousPageTitle: 'Exit',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      //
      //
      // Here is the pageview:
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: PageView(controller: pageController, children: [
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.translate(
                    offset: Offset(50, 0),
                    child: Image.asset(
                      'assets/images/enthusiastic_human.png',
                      width: 200,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: QuestionView(
                  textFocusNode: textFocusNodes[0],
                  textController: textControllers[0],
                  question: 'What filled you with enthusiasm today?',
                  textFieldPlaceholder: 'Keep is short and sweet...',
                  buttonText: 'next question',
                  buttonColor: CupertinoColors.black,
                  buttonTextColor: CupertinoColors.white,
                  buttonAction: () {
                    pageController.animateToPage(
                        pageController.page.toInt() + 1,
                        duration: Duration(milliseconds: 700),
                        curve: Curves.ease);
                  },
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/drained_human.png',
                        width: 200,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: QuestionView(
                  textFocusNode: textFocusNodes[1],
                  textController: textControllers[1],
                  question: 'What drained you of energy today?',
                  textFieldPlaceholder: 'Tell it like it is...',
                  buttonText: 'next question',
                  buttonColor: CupertinoColors.black,
                  buttonTextColor: CupertinoColors.white,
                  buttonAction: () {
                    pageController.animateToPage(
                        pageController.page.toInt() + 1,
                        duration: Duration(milliseconds: 700),
                        curve: Curves.ease);
                  },
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset(
                          'assets/images/learning_human.png',
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: QuestionView(
                  textFocusNode: textFocusNodes[2],
                  textController: textControllers[2],
                  question: 'What did you learn about yourself today?',
                  textFieldPlaceholder: 'This is a time of discovery...',
                  buttonText: 'submit answers',
                  buttonColor: CupertinoColors.systemRed,
                  buttonTextColor: CupertinoColors.white,
                  buttonAction: () async {
                    List<String> entries = [];
                    for (TextEditingController controller in textControllers) {
                      if (controller.text.trim().isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertView;
                          },
                        );
                        break;
                      }
                      entries.add(controller.text.trim());
                    }
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class QuestionView extends StatefulWidget {
  final String question;
  final String textFieldPlaceholder;
  final String buttonText;
  final Function buttonAction;
  final FocusNode textFocusNode;
  final TextEditingController textController;
  final Color buttonColor;
  final Color buttonTextColor;

  QuestionView({
    @required this.question,
    @required this.textFieldPlaceholder,
    @required this.buttonText,
    @required this.buttonAction,
    @required this.textFocusNode,
    @required this.buttonColor,
    @required this.buttonTextColor,
    this.textController,
  });

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  int numCharacters = 140;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CupertinoColors.systemBackground,
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: Offset.zero,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.question,
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: CupertinoColors.black),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: CupertinoTextField(
                    focusNode: widget.textFocusNode,
                    controller: widget.textController,
                    autocorrect: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 140,
                    maxLengthEnforced: true,
                    textInputAction: TextInputAction.done,
                    enableInteractiveSelection: false,
                    placeholder: widget.textFieldPlaceholder,
                    cursorColor: CupertinoColors.systemRed,
                    padding: EdgeInsets.all(16),
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 18,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.extraLightBackgroundGray,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onSubmitted: (value) {
                      // Dismisses the keyboard
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {
                      setState(() {
                        // Sets the correct number of remaining characters
                        numCharacters = 140 - value.length;
                      });
                    },
                  ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 16, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$numCharacters characters remaining',
                      style: TextStyle(
                        color: CupertinoColors.systemRed,
                      ),
                    ),

                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        height: 38,
                        child: CupertinoButton(
                          child: Text(
                            widget.buttonText,
                            style: TextStyle(
                              color: widget.buttonTextColor,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: widget.buttonColor,  //widget.buttonColor,
                          pressedOpacity: 0.75,
                          onPressed: widget.buttonAction,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: CupertinoColors.systemGreen.withOpacity(0),
            ),
          ),
        )
      ],
    );
  }
}