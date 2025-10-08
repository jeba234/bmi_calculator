import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String resultText = 'Enter your details';
  double bmiResult = 0.0;

  void calculateBMI()  {
    final String weightText = weightController.text;
    final String heightText = heightController.text;

    if(weightText.isEmpty || heightText.isEmpty) {
      setState(() {
        resultText = 'Please enter both weight and height';
      });
      return;
    }

    final double weight = double.tryParse(weightText) ?? 0;
    final double height = double.tryParse(heightText) ?? 0;

    if (weight <= 0 || height <= 0) {
      setState((){
        resultText = 'please enter valid positive numbers';
      });
      return;
    }
     // Convert height from cm to meters
     final double heightInMeters = height / 100;

     // Calculate BMI: weight (kg) / (height (m) * height (m))
     final double bmi = weight / (heightInMeters * heightInMeters);

     setState((){
      bmiResult = bmi;
      resultText = 'Your BMI: ${bmi.toStringAsFixed(1)}';
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, 
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Weight for input field
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                hintText: 'Enter your weight in kilograms',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.fitness_center),
              ),
            ),
            const SizedBox(height: 20),

            // Height Input field
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                hintText: 'Enter your height in centimeters',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 30),

            // Calculate Button 
            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Calculate BMI',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),

            //Result Display
            Container(
              padding: const EdgeInsets.all(20),
              decoration:BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                resultText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),

            //Formula Display
            const SizedBox(height: 20),
            const Text(
              'BMI Formula: Weight (kg) / (height (m) * height (m))',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }
}