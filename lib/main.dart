import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: QuizApp());
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State createState() => _QuizAppState();
}

class _QuizAppState extends State {
  List<Map> allQuestions = [
    {
      'question': "Who is the founder of Microsoft?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'Lary Page'],
      'correctAnswer': 2,
    },

    {
      'question': "Who is the founder of Apple?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'Lary Page'],
      'correctAnswer': 0,
    },

    {
      'question': "Who is the founder of Google?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'Lary Page'],
      'correctAnswer': 3,
    },

    {
      'question': "Who is the founder of OpenAI?",
      'options': ['Steve Jobs', 'Elon Musk', 'Sam Altman', 'Lary Page'],
      'correctAnswer': 2,
    },

    {
      'question': "Who is the founder of SpaceX?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'Lary Page'],
      'correctAnswer': 1,
    },
  ];

  int currentQuestionIndex = 0;
  int selectedAnswerIndex = -1;
  bool isQuestionPage = true;
  int score = 0;

  WidgetStatePropertyAll<Color?> checkAnswer(int answerIndex) {
    if (selectedAnswerIndex != -1) {
      if (answerIndex == allQuestions[currentQuestionIndex]['correctAnswer']) {
        return WidgetStatePropertyAll(Colors.green);
      } else if (selectedAnswerIndex == answerIndex) {
        return WidgetStatePropertyAll(Colors.red);
      } else {
        return WidgetStatePropertyAll(null);
      }
    } else {
      return WidgetStatePropertyAll(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return quizAppPage();
  }

  Scaffold quizAppPage() {
    if (isQuestionPage == true) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "QuizApp",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.orange,
            ),
          ),
          backgroundColor: Colors.blue,
        ),

        body: Column(
          children: [
            const SizedBox(height: 10),

            Row(
              children: [
                const SizedBox(width: 120),
                Text(
                  "Question : ${currentQuestionIndex + 1}/${allQuestions.length}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 380,
              child: Text(
                allQuestions[currentQuestionIndex]['question'],
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.purple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: checkAnswer(0)),
                onPressed: () {
                  if (selectedAnswerIndex == -1) {
                    selectedAnswerIndex = 0;
                    if (allQuestions[currentQuestionIndex]['correctAnswer'] == selectedAnswerIndex) {
                      score++;
                    }
                    setState(() {});
                  }
                },

                child: Text(
                  allQuestions[currentQuestionIndex]['options'][0],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: checkAnswer(1)),
                onPressed: () {
                  if (selectedAnswerIndex == -1) {
                    selectedAnswerIndex = 1;
                    if (allQuestions[currentQuestionIndex]['correctAnswer'] == selectedAnswerIndex) {
                      score++;
                    }
                    setState(() {});
                  }
                },

                child: Text(
                  allQuestions[currentQuestionIndex]['options'][1],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: checkAnswer(2)),
                onPressed: () {
                  if (selectedAnswerIndex == -1) {
                    selectedAnswerIndex = 2;
                    if (allQuestions[currentQuestionIndex]['correctAnswer'] == selectedAnswerIndex) {
                      score++;
                    }
                    setState(() {});
                  }
                },

                child: Text(
                  allQuestions[currentQuestionIndex]['options'][2],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: checkAnswer(3)),
                onPressed: () {
                  if (selectedAnswerIndex == -1) {
                    selectedAnswerIndex = 3;
                    if (allQuestions[currentQuestionIndex]['correctAnswer'] == selectedAnswerIndex) {
                      score++;
                    }
                    setState(() {});
                  }
                },

                child: Text(
                  allQuestions[currentQuestionIndex]['options'][3],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedAnswerIndex != -1) {
              if (currentQuestionIndex < allQuestions.length - 1) {
                currentQuestionIndex++;
                selectedAnswerIndex = -1;
              } else {
                isQuestionPage = false;
              }
              setState(() {});
            }
          },
          backgroundColor: Colors.blue,
          child: const Text(
            "Next",
            style: TextStyle(fontSize: 15, color: Colors.orange),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text("Result ", style: TextStyle(fontSize: 30)),
        ),

        body: Column(
              children: [
              Image.network(
                "https://i.pinimg.com/236x/7d/34/ce/7d34cefbf6f06f9f4caefe40dc7c8f90.jpg",
                width: 400,
                height: 400,
              ),

              SizedBox(height: 5),

                Text(
                  "Your Score: $score / ${allQuestions.length}",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),

              SizedBox(height: 5),

              Text(
                "Congratulations",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ],
          ),
      );
    }
  }
}
