import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
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
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Map<String, dynamic>> allQuestions = [
    {
      'question': "Who is the founder of Microsoft?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'Larry Page'],
      'correctAnswer': 2,
    },
    {
      'question': "Who is the founder of Apple?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'Larry Page'],
      'correctAnswer': 0,
    },
    {
      'question': "Who is the founder of Google?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'Larry Page'],
      'correctAnswer': 3,
    },
    {
      'question': "Who is the founder of OpenAI?",
      'options': ['Steve Jobs', 'Elon Musk', 'Sam Altman', 'Larry Page'],
      'correctAnswer': 2,
    },
    {
      'question': "Who is the founder of SpaceX?",
      'options': ['Steve Jobs', 'Elon Musk', 'Bill Gates', 'Larry Page'],
      'correctAnswer': 1,
    },
  ];

  int currentQuestionIndex = 0;
  int selectedAnswerIndex = -1;
  bool isQuestionPage = true;
  int score = 0;

  // Resets the quiz to its initial state
  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswerIndex = -1;
      score = 0;
      isQuestionPage = true;
    });
  }

  WidgetStatePropertyAll<Color?> checkAnswer(int answerIndex) {
    if (selectedAnswerIndex != -1) {
      if (answerIndex == allQuestions[currentQuestionIndex]['correctAnswer']) {
        return const WidgetStatePropertyAll(Colors.green);
      } else if (selectedAnswerIndex == answerIndex) {
        return const WidgetStatePropertyAll(Colors.red);
      } else {
        return const WidgetStatePropertyAll(null);
      }
    } else {
      return const WidgetStatePropertyAll(null);
    }
  }

  void handleAnswer(int index) {
    if (selectedAnswerIndex == -1) {
      setState(() {
        selectedAnswerIndex = index;
        if (allQuestions[currentQuestionIndex]['correctAnswer'] ==
            selectedAnswerIndex) {
          score++;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return quizAppPage();
  }

  Scaffold quizAppPage() {
    if (isQuestionPage) {
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
        // *** CHANGE: Wrapped Column in a SizedBox to ensure it takes full width ***
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20), // Space from app bar
              Text(
                "Question : ${currentQuestionIndex + 1}/${allQuestions.length}",
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 380,
                child: Text(
                  allQuestions[currentQuestionIndex]['question'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Generates the option buttons dynamically
              ...List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: checkAnswer(index)),
                    onPressed: () => handleAnswer(index),
                    child: Text(
                      allQuestions[currentQuestionIndex]['options'][index],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedAnswerIndex != -1) {
              if (currentQuestionIndex < allQuestions.length - 1) {
                setState(() {
                  currentQuestionIndex++;
                  selectedAnswerIndex = -1;
                });
              } else {
                setState(() {
                  isQuestionPage = false;
                });
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Please select an option",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.redAccent,
                  duration: Duration(seconds: 1),
                ),
              );
            }
          },
          backgroundColor: Colors.blue,
          child: Text(
            currentQuestionIndex == allQuestions.length - 1 ? "Submit" : "Next",
            style: const TextStyle(fontSize: 15, color: Colors.orange),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text("Result", style: TextStyle(fontSize: 30)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://i.pinimg.com/236x/7d/34/ce/7d34cefbf6f06f9f4caefe40dc7c8f90.jpg",
                width: 300,
                height: 300,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 100); // Fallback icon
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Your Score: $score / ${allQuestions.length}",
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              const Text(
                "Congratulations!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: resetQuiz,
                child: const Text("Retake Quiz"),
              ),
            ],
          ),
        ),
      );
    }
  }
}
