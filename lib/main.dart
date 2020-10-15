import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentStep = 0;
  String username, email, password;
  List<Step> allSteps;

  @override
  void initState() {
    // TODO: implement initState
    allSteps = stepS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Stepper Example"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Stepper(
          steps: allSteps,
          currentStep: currentStep,
          onStepTapped: (currentTapStep) {
            setState(() {
              currentStep = currentTapStep;
            });
          },
          onStepContinue: () {
            setState(() {
              if (currentStep < allSteps.length - 1) {
                currentStep++;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep--;
              }
            });
          },
        ),
      ),
    );
  }

  stepS() {
    List<Step> steps = [
      Step(
        title: Text("Username"),
        state: StepState.indexed,
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(
            labelText: "Username",
            hintText: "Fatih",
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Step(
        title: Text("Mail Adress"),
        state: StepState.indexed,
        isActive: true,
        content: TextFormField(
          decoration: InputDecoration(
            labelText: "Mail Adress",
            hintText: "example@example.com",
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Step(
        title: Text("Password"),
        state: StepState.indexed,
        isActive: true,
        content: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Pasword",
            hintText: "******",
            border: OutlineInputBorder(),
          ),
        ),
      ),
    ];
    return steps;
  }
}
