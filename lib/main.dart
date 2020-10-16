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
  bool mistake = false;
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    allSteps = stepS();
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
          /*onStepTapped: (currentTapStep) {             // Deactive, because, when i click currentStep, i dont want change
            setState(() {                                // I want to change for the click to "continue" button.
              currentStep = currentTapStep;
            });
          },*/
          onStepContinue: () {
            setState(() {
              continueButtonControl();
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
        state: iconStatus(0),
        isActive: true,
        content: TextFormField(
          key: key0,
          decoration: InputDecoration(
            labelText: "Username",
            hintText: "Fatih",
            border: OutlineInputBorder(),
          ),
          validator: (inputValue) {
            if (inputValue.length < 6) {
              return "En az 6 karakter giriniz";
            }
          },
          onSaved: (inputValue) {
            username = inputValue;
          },
        ),
      ),
      Step(
        title: Text("Mail Adress"),
        state: iconStatus(1),
        isActive: true,
        content: TextFormField(
          key: key1,
          decoration: InputDecoration(
            labelText: "Mail Adress",
            hintText: "example@example.com",
            border: OutlineInputBorder(),
          ),
          validator: (inputValue) {
            if (!inputValue.contains("@")) {
              return "Lütfen mail formatı giriniz.";
            }
          },
          onSaved: (inputValue) {
            email = inputValue;
          },
        ),
      ),
      Step(
        title: Text("Password"),
        state: iconStatus(2),
        isActive: true,
        content: TextFormField(
          key: key2,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Pasword",
            hintText: "******",
            border: OutlineInputBorder(),
          ),
          validator: (inputValue) {
            if (inputValue.length < 6) {
              return "En az 6 karakter giriniz";
            }
          },
          onSaved: (inputValue) {
            password = inputValue;
          },
        ),
      ),
    ];
    return steps;
  }

  StepState iconStatus(int currentStepp) {
    if (currentStep == currentStepp) {
      if (mistake) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else {
      return StepState.complete;
    }
  }

  void continueButtonControl() {
    switch (currentStep) {
      case 0:
        if (key0.currentState.validate()) {
          key0.currentState.save();
          mistake = false;
          currentStep++;
        } else {
          mistake = true;
        }
        break;
      case 1:
        if (key1.currentState.validate()) {
          key1.currentState.save();
          mistake = false;
          currentStep++;
        } else {
          mistake = true;
        }
        break;
      case 2:
        if (key2.currentState.validate()) {
          key2.currentState.save();
          mistake = false;
        } else {
          mistake = true;
        }
        break;
    }
  }
}
