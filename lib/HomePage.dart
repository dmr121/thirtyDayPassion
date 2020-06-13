import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thirtyDayPassion/Models/Entries.dart';
import 'package:thirtyDayPassion/QuestionsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'David';
  List<Submission> previousEntries = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    populateList(20);
  }
  
  List<Widget> constructList() {
    List<Widget> listItems = [];
    for (var item in previousEntries.reversed) {
      listItems.add(EntryListItem(index: previousEntries.indexOf(item)));
    }
    return listItems;
  }

  //
  //
  //
  // FOR TESTING PURPOSES
  void populateList(int number) {
    for (int i = 0; i < number; ++i) {
        String entry1  ='Enthusiastic feelings';
        String entry2  = 'Drained feelings';
        String entry3  = 'Learned feelings';
        List<String> entriess = [entry1, entry2, entry3];
        DateTime dateTimee = DateTime.now();
        Submission sub = Submission(entriess, dateTimee);
        previousEntries.add(sub);
    }
  }
  // FOR TESTING PURPOSES
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: SafeArea(
        bottom: false,
        child: Container(
          color: CupertinoColors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    Text(
                      '30 Day Passion',
                      style: TextStyle(
                        fontSize: 30,
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Hello, ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          color: CupertinoColors.black,
                        ),
                        children: [
                          TextSpan(
                            text: userName,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w100,
                              color: CupertinoColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: CupertinoColors.systemRed,
                      pressedOpacity: 0.75,
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => QuestionsPage()));
                      },
                      child: Text(
                        'MAKE A NEW ENTRY',
                        style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                  child: ListView(
                    children: constructList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EntryListItem extends StatelessWidget {

  final int index;

  EntryListItem({
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: CupertinoColors.white,
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            child: RichText(
              text: TextSpan(
                text: 'Day ' + (index+1).toString(),
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w200,
                  color: CupertinoColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
