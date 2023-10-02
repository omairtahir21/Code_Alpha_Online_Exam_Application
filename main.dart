import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Exam App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/create_exam': (context) => ExamCreationScreen(),
        '/exam': (context) => ExamScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Exam App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Online Exam App!'),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/create_exam');
              },
              icon: Icon(Icons.add),
              label: Text('Create Exam'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/exam');
              },
              icon: Icon(Icons.quiz),
              label: Text('Take Exam'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamCreationScreen extends StatefulWidget {
  @override
  _ExamCreationScreenState createState() => _ExamCreationScreenState();
}

class _ExamCreationScreenState extends State<ExamCreationScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController optionController = TextEditingController();

  List<String> options = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Exam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Question:'),
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                hintText: 'Enter your question...',
              ),
            ),
            SizedBox(height: 20),
            Text('Enter Options:'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: optionController,
                    decoration: InputDecoration(
                      hintText: 'Enter an option...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      options.add(optionController.text);
                      optionController.clear();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Options:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: options
                  .map(
                    (option) => ListTile(
                  title: Text(option),
                ),
              )
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the question and options
                // You can store these in a data structure or database
                List<String> questions = [questionController.text, ...options];

                Navigator.pushNamed(
                  context,
                  '/exam',
                  arguments: {'questions': questions},
                );
              },
              child: Text('Save Exam'),
            ),
          ],
        ),
      ),
    );
  }
}
class ExamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve questions from arguments
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Check if args is not null before accessing its properties
    final List<String> questions = args?['questions'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Take Exam'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(' ${index + 1}: ${questions[index]}'),
          );
        },
      ),
    );
  }
}
