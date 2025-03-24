import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart'; // 👉 เพิ่มตรงนี้

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({required this.score, required this.total, super.key});

  String getFeedbackMessage(double percent) {
    if (percent >= 90) return "สุดยอด! 🎉 คุณเทพมาก!";
    if (percent >= 75) return "เก่งมากเลย! 🥳";
    if (percent >= 50) return "ดีมาก ลองอีกครั้งนะ 💪";
    return "สู้ๆ นะ อย่ายอมแพ้! 🔥";
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = total == 0 ? 0 : (score / total) * 100;
    final feedback = getFeedbackMessage(percentage);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('สรุปผลคะแนน', style: GoogleFonts.poppins()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.indigo.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, size: 80, color: Colors.amber.shade800),
              SizedBox(height: 20),
              Text(
                'คะแนนของคุณ',
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '$score / $total',
                      style: GoogleFonts.poppins(
                        fontSize: 42,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'คิดเป็น ${percentage.toStringAsFixed(1)}%',
                      style: GoogleFonts.prompt(fontSize: 20, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                feedback,
                style: GoogleFonts.prompt(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                },
                icon: Icon(Icons.home_rounded),
                label: Text('กลับหน้าหลัก', style: GoogleFonts.prompt(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
