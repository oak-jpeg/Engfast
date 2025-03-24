import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word.dart';
import '../widgets/word_card.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Word> words = [];
  List<Word> remainingWords = [];
  Word? currentWord;
  bool showMeaning = false;
  int wordsSeen = 0;
  int score = 0;
  final int totalQuestions = 20;
  bool quizMode = false;
  String? selectedAnswer;

  @override
  void initState() {
    super.initState();
    loadWords();
  }

  Future<void> loadWords() async {
    final String response = await rootBundle.loadString('lib/data/word_list.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      words = data.map((item) => Word.fromJson(item)).toList();
      remainingWords = List.from(words)..shuffle();
      randomWord();
    });
  }

  Future<void> saveResultToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_score', score);
    await prefs.setInt('last_total', totalQuestions);
  }

  void randomWord() async {
    if (quizMode && wordsSeen >= totalQuestions) {
      await saveResultToPreferences();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: score, total: totalQuestions),
        ),
      );
      return;
    }

    if (remainingWords.isEmpty) {
      remainingWords = List.from(words)..shuffle();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เริ่มรอบใหม่แล้ว!')),
      );
    }

    setState(() {
      currentWord = remainingWords.removeLast();
      showMeaning = false;
      selectedAnswer = null;
      if (quizMode) wordsSeen++;
    });
  }

  List<String> generateOptions(String correct) {
    final random = Random();
    Set<String> options = {correct};
    while (options.length < 4) {
      String word = words[random.nextInt(words.length)].meaning;
      options.add(word);
    }
    return options.toList()..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("EngFast", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(quizMode ? Icons.school : Icons.lightbulb_outline),
            tooltip: 'สลับโหมด Quiz',
            onPressed: () {
              setState(() {
                quizMode = !quizMode;
                selectedAnswer = null;
                score = 0;
                wordsSeen = 0;
                remainingWords = List.from(words)..shuffle();
                randomWord();
              });
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigoAccent.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: currentWord == null
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    quizMode ? buildQuizCard() : buildWordCard(),
                    SizedBox(height: 30),
                    Text(
                      quizMode
                          ? "ข้อที่: $wordsSeen / $totalQuestions"
                          : "คำที่ผ่านแล้ว: $wordsSeen",
                      style: GoogleFonts.prompt(fontSize: 18, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: randomWord,
                      icon: Icon(Icons.arrow_forward_rounded),
                      label: Text("Next Word", style: GoogleFonts.prompt(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        elevation: 6,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildWordCard() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, spreadRadius: 2)],
      ),
      child: GestureDetector(
        onTap: () => setState(() => showMeaning = !showMeaning),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.translate, color: Colors.indigo, size: 40),
            SizedBox(height: 12),
            Text(
              currentWord!.word,
              style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            if (showMeaning) ...[
              SizedBox(height: 10),
              Text(
                currentWord!.meaning,
                style: GoogleFonts.prompt(fontSize: 22, color: Colors.grey[800]),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget buildQuizCard() {
    final options = generateOptions(currentWord!.meaning);
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currentWord!.word,
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ...options.map((opt) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ElevatedButton(
                    onPressed: selectedAnswer == null
                        ? () {
                            setState(() {
                              selectedAnswer = opt;

                              if (opt == currentWord!.meaning) {
                                score++;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    opt == currentWord!.meaning ? 'ถูกต้อง!' : 'ตอบผิด!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: opt == currentWord!.meaning
                                      ? Colors.green
                                      : Colors.red,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedAnswer == null
                          ? Colors.indigoAccent
                          : (opt == currentWord!.meaning
                              ? Colors.green
                              : (opt == selectedAnswer ? Colors.red : Colors.grey[400])),
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(opt,
                          style: GoogleFonts.prompt(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
