class Submission {
  List<Entry> entries = [];
  DateTime dateTime;

  Submission(List<String> entries, DateTime dateTime) {
    for (int i = 0; i < entries.length; ++i) {
      Entry entry = Entry(content: entries[i], questionNumber: i);
      this.entries.add(entry);
      this.dateTime = dateTime;
    }
  }
}

class Entry {
  String content;
  int questionNumber;

  Entry({
    this.content,
    this.questionNumber,
  });
}