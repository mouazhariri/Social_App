import 'dart:math';

import 'package:flutter/material.dart';
import '../bmi_result/bmi_result_screen.dart';

class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  bool isgamer = true;
  double height = 150.0;
  double width = 50.0;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isgamer = true;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                'assets/images/768px-Male_symbol_-_black.png',
                              ),
                              height: 100.0,
                              width: 190.0,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Male',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: isgamer ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isgamer = false;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/female-icon-28.jpg'),
                              height: 100.0,
                              width: 190.0,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: isgamer ? Colors.grey : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${height.round()}',
                          style: TextStyle(
                              fontSize: 45.0, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'CM',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    Slider(
                        value: height,
                        max: 250.0,
                        min: 80.0,
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                        })
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Weight',
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Text(
                              '${width.round()}',
                              style: TextStyle(
                                  fontSize: 45.0, fontWeight: FontWeight.w900),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {},
                                  mini: true,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        width--;
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {},
                                  mini: true,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          width++;
                                        });
                                      },
                                      icon: Icon(Icons.add)),
                                ),
                              ],
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'AGE',
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Text(
                              '${age.round()}',
                              style: TextStyle(
                                  fontSize: 45.0, fontWeight: FontWeight.w900),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {},
                                  mini: true,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        age--;
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {},
                                  mini: true,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          age++;
                                        });
                                      },
                                      icon: Icon(Icons.add)),
                                ),
                              ],
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.black,
          child: MaterialButton(
              height: 50.0,
              onPressed: () {
                // ignore: unused_local_variable
                double result = width / pow(height / 100, 2);
                print('result.round');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BMIResultScreen(
                      isgamer: isgamer,
                      age: age,
                      result: result.round(),
                    ),
                  ),
                );
              },
              child: Text(
                'CALCULATOR',
                style: TextStyle(color: Colors.red),
              )),
        ),
      ]),
    );
  }
}
