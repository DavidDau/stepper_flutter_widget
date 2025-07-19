import 'package:flutter/material.dart';

void main() => runApp(StepperApp());

class StepperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Becoming a Christian',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: StepperHomePage(),
    );
  }
}

class StepperHomePage extends StatefulWidget {
  @override
  _StepperHomePageState createState() => _StepperHomePageState();
}

class _StepperHomePageState extends State<StepperHomePage> {
  int _currentStep = 0;

  final List<Map<String, dynamic>> _steps = [
    {
      'title': 'Recognize Your Need for God',
      'content': Text(
        'The Bible says, "All have sinned and fall short of the glory of God" (Romans 3:23). Acknowledge that you are a sinner in need of forgiveness.',
      ),
    },
    {
      'title': 'Believe in Jesus Christ',
      'content': Text(
        '"For God so loved the world that He gave His only Son, that whoever believes in Him shall not perish but have eternal life" (John 3:16). Believe that Jesus died on the cross for your sins and rose again.',
      ),
    },
    {
      'title': 'Repent of Your Sins',
      'content': Text(
        'Repent, then, and turn to God, so that your sins may be wiped out" (Acts 3:19). Turn away from sinful ways and ask God for forgiveness.',
      ),
    },
    {
      'title': '"Confess Jesus as Lord and Savior',
      'content': Text(
        '"If you declare with your mouth, ‘Jesus is Lord,’ and believe in your heart that God raised Him from the dead, you will be saved" (Romans 10:9). Pray and surrender your life to Christ.',
      ),
    },
    {
      'title': 'Pray to Receive Christ',
      'content': Text(
        'You can pray something like this "Dear Jesus, I know I am a sinner. I believe You died for my sins and rose again. I repent of my sins and ask for Your forgiveness. I surrender my life to You. Come into my heart and be my Lord and Savior. Thank You for saving me. Amen."',
      ),
    },

    {
      'title': 'Follow Jesus (Live as a Christian)',
      'content': Text(
        'Set your minds on things above, not on earthly things" (Colossians 3:1-2). Start living according to God\'s Word and follow Jesus\' teachings.',
      ),
    },
  ];

  void _onStepContinue() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep += 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome to the Christian Family!")),
      );
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Becoming a Christian: Step-By-Step'),
      ),

      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        steps:
            _steps.asMap().entries.map((entry) {
              int index = entry.key;
              var step = entry.value;
              return Step(
                title: Text(step['title']),
                content: step['content'],
                isActive: _currentStep >= index,
                state:
                    _currentStep > index
                        ? StepState.complete
                        : StepState.indexed,
              );
            }).toList(),
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(
                    _currentStep == _steps.length - 1 ? 'Finish' : 'Continue',
                  ),
                ),
                SizedBox(width: 8),
                if (_currentStep > 0)
                  OutlinedButton(
                    onPressed: details.onStepCancel,
                    child: Text('Back'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
