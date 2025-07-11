import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 156, 144, 144),
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int heightt = 170;
  int weight = 70;
  int age = 25;
  bool isMale = false;
  bool isFemale = false;

  void refresh() {
    setState(() {
      heightt = 170;
      weight = 70;
      age = 25;
      isMale = false;
      isFemale = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 15, 78),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 32, 15, 78),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: refresh,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Male Box
                  Expanded(
                    child: GestureBox(
                      isActive: isMale,
                      icon: Icons.male,
                      label: 'Male',
                      activeColor: const Color.fromARGB(255, 19, 45, 161),
                      inactiveColor: const Color.fromARGB(255, 57, 59, 83),
                      onTap: () {
                        setState(() {
                          isMale = !isMale;
                          if (isMale) isFemale = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Female Box
                  Expanded(
                    child: GestureBox(
                      isActive: isFemale,
                      icon: Icons.female,
                      label: 'Female',
                      activeColor: const Color.fromARGB(255, 255, 0, 234),
                      inactiveColor: const Color.fromARGB(255, 57, 59, 83),
                      onTap: () {
                        setState(() {
                          isFemale = !isFemale;
                          if (isFemale) isMale = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Height Slider
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 57, 59, 83),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'HEIGHT',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        heightt.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'cm',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: heightt.toDouble(),
                    min: 100,
                    max: 250,
                    activeColor: Colors.blueAccent,
                    inactiveColor: Colors.blueGrey,
                    thumbColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        heightt = value.round();
                      });
                    },
                  ),
                ],
              ),
            ),
            
            // Weight and Age Row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ValueBox(
                      title: 'WEIGHT',
                      value: weight,
                      unit: 'kg',
                      color: Colors.blueAccent,
                      onIncrement: () {
                        setState(() {
                          weight++;
                        });
                      },
                      onDecrement: () {
                        setState(() {
                          if (weight > 1) weight--;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ValueBox(
                      title: 'AGE',
                      value: age,
                      unit: 'yrs',
                      color: Colors.purpleAccent,
                      onIncrement: () {
                        setState(() {
                          age++;
                        });
                      },
                      onDecrement: () {
                        setState(() {
                          if (age > 1) age--;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Calculate Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  shadowColor: Colors.blue.withOpacity(0.5),
                ),
                onPressed: () {
                  double heightInMeters = heightt / 100;
                  double bmi = weight / (heightInMeters * heightInMeters);
                  String category = _getBmiCategory(bmi);
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsPage(
                        bmi: bmi,
                        category: category,
                        isMale: isMale,
                      ),
                    ),
                  );
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'CALCULATE BMI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}

class GestureBox extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final String label;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const GestureBox({
    super.key,
    required this.isActive,
    required this.icon,
    required this.label,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isActive 
                  ? activeColor.withOpacity(0.5)
                  : Colors.transparent,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 50,
              color: isActive ? Colors.white : Colors.white70,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ValueBox extends StatelessWidget {
  final String title;
  final int value;
  final String unit;
  final Color color;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ValueBox({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 57, 59, 83),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleButton(
                icon: Icons.remove,
                onPressed: onDecrement,
                color: color,
              ),
              const SizedBox(width: 16),
              CircleButton(
                icon: Icons.add,
                onPressed: onIncrement,
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.2),
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final double bmi;
  final String category;
  final bool isMale;

  const ResultsPage({
    super.key,
    required this.bmi,
    required this.category,
    required this.isMale,
  });

  @override
  Widget build(BuildContext context) {
    final (String emoji, String title, Color color) = _getBmiDetails();
    final List<String> healthTips = _getHealthTips();
    final List<String> lifestyleTips = _getLifestyleTips();
    final List<String> motivationalTips = _getMotivationalTips();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 15, 78),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 15, 78),
        title: const Text('Your Results'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BMI Result Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 57, 59, 83),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    emoji,
                    style: const TextStyle(fontSize: 50),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    category.toUpperCase(),
                    style: TextStyle(
                      color: color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Body Mass Index',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Health Tips Section
            _buildTipsSection(
              title: 'Health Tips 💡',
              tips: healthTips,
              color: Colors.blueAccent,
            ),
            
            const SizedBox(height: 24),
            
            // Lifestyle Tips Section
            _buildTipsSection(
              title: 'Lifestyle Suggestions 🌱',
              tips: lifestyleTips,
              color: Colors.greenAccent,
            ),
            
            const SizedBox(height: 24),
            
            // Motivational Tips Section
            _buildTipsSection(
              title: 'Motivational Quotes ✨',
              tips: motivationalTips,
              color: Colors.orangeAccent,
            ),
            
            const SizedBox(height: 24),
            
            // Recalculate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'RECALCULATE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsSection({
    required String title,
    required List<String> tips,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 57, 59, 83),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: tips.map((tip) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: color,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  (String, String, Color) _getBmiDetails() {
    if (bmi < 16) {
      return ('😵', 'Severe Thinness', Colors.redAccent);
    } else if (bmi < 17) {
      return ('😟', 'Moderate Thinness', Colors.orangeAccent);
    } else if (bmi < 18.5) {
      return ('🙁', 'Mild Thinness', Colors.yellowAccent);
    } else if (bmi < 25) {
      return ('😊', 'Normal', Colors.greenAccent);
    } else if (bmi < 30) {
      return ('😐', 'Overweight', Colors.orangeAccent);
    } else if (bmi < 35) {
      return ('😕', 'Obese Class I', Colors.redAccent);
    } else if (bmi < 40) {
      return ('😨', 'Obese Class II', Colors.red);
    } else {
      return ('😱', 'Obese Class III', Colors.deepOrange);
    }
  }

  List<String> _getHealthTips() {
    if (bmi < 18.5) {
      return [
        'Consult with a nutritionist to develop a healthy weight gain plan',
        'Increase calorie intake with nutrient-dense foods like nuts, avocados, and whole grains',
        'Consider weight training to build muscle mass',
        'Eat smaller, more frequent meals throughout the day',
        'Monitor your progress with regular check-ups',
      ];
    } else if (bmi < 25) {
      return [
        'Maintain your current healthy habits',
        'Continue balanced diet and regular exercise',
        'Get annual health check-ups to monitor your status',
        'Stay hydrated and get enough sleep',
        'Manage stress through relaxation techniques',
      ];
    } else {
      return [
        'Consult with a healthcare provider for a personalized weight loss plan',
        'Aim for gradual weight loss (0.5-1 kg per week)',
        'Increase physical activity gradually',
        'Focus on whole foods and reduce processed foods',
        'Monitor portion sizes and reduce sugar intake',
      ];
    }
  }

  List<String> _getLifestyleTips() {
    if (bmi < 18.5) {
      return [
        'Establish a regular eating schedule',
        'Incorporate strength training 2-3 times per week',
        'Get enough rest to allow your body to recover',
        'Consider protein supplements if recommended by a doctor',
        'Track your meals to ensure adequate nutrition',
      ];
    } else if (bmi < 25) {
      return [
        'Maintain a consistent exercise routine (150+ minutes/week)',
        'Practice mindful eating habits',
        'Stay socially active and engaged',
        'Find physical activities you enjoy',
        'Balance work and leisure time effectively',
      ];
    } else {
      return [
        'Start with low-impact exercises like walking or swimming',
        'Reduce sedentary time - stand up and move every hour',
        'Get 7-9 hours of quality sleep each night',
        'Find an exercise buddy for motivation',
        'Take stairs instead of elevators when possible',
      ];
    }
  }

  List<String> _getMotivationalTips() {
    if (bmi < 18.5) {
      return [
        'Your journey to a healthier weight is worth every effort',
        'Small consistent changes lead to big results',
        'Your body is capable of amazing transformations',
        'Every healthy meal is a step toward your goal',
        'Progress takes time - be patient with yourself',
      ];
    } else if (bmi < 25) {
      return [
        'You are doing great - keep up the good work!',
        'Maintaining health is a lifelong journey',
        'Your healthy habits inspire others',
        'Consistency is more important than perfection',
        'Celebrate your commitment to wellness',
      ];
    } else {
      return [
        'Every journey begins with a single step - you have started!',
        'Small changes add up to big results over time',
        'Your health is worth the effort',
        'Focus on progress, not perfection',
        'Youre stronger than you think - keep going!',
      ];
    }
  }
}