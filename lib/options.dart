// Options page

import 'package:flutter/material.dart';

// globals
bool? flagMode = true;
bool? gameSpeed = true;

// building the options page
class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    // print the current game modes
    print("Flag Mode: $flagMode");
    print("Game Speed: $gameSpeed");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Options',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.redAccent, Colors.white],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30.0),

            // game settings
            Container(
              alignment: Alignment.center,
              child: Text(
                "Here you can change the \n         game settings ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
            ),

            // spacing
            SizedBox(height: 30.0),

            // modes
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 5.0,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Modes: \n",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // radio buttons for modes
                  Container(
                    child: Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: flagMode,
                          onChanged: (value) {
                            setState(() {
                              flagMode = value as bool?;
                            });
                          },
                        ),

                        // flag mode
                        Text("Flag Mode (Default)",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            )),

                        SizedBox(width: 20.0),

                        // capital mode
                        Radio(
                          value: false,
                          groupValue: flagMode,
                          mouseCursor: SystemMouseCursors.forbidden,
                          onChanged: (value) {
                            setState(() {
                              // alert
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Capital Mode",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                        "Sorry! This mode is not available in the current version."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);

                                          // set the flag mode to true
                                          setState(() {
                                            flagMode = true;
                                          });
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );

                              flagMode = value as bool?;
                            });
                          },
                        ),

                        Text("Capital Mode",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // spacing
            SizedBox(height: 30.0),

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 5.0,
                ),
              ),
              child: Column(
                children: [
                  // game speed
                  Container(
                    child: Text(
                      "Game Speed: \n",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // radio buttons for game speed (normal or fast)
                  Container(
                    child: Row(
                      children: [
                        // normal mode (10 second per question)
                        Radio(
                          value: true,
                          groupValue: gameSpeed,
                          onChanged: (value) {
                            setState(() {
                              gameSpeed = value as bool?;
                            });
                          },
                        ),
                        Text("Normal (Default)",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            )),

                        SizedBox(width: 20.0),

                        // fast mode (5 seconds per question)
                        Radio(
                          value: false,
                          groupValue: gameSpeed,
                          onChanged: (value) {
                            setState(() {
                              gameSpeed = value as bool?;
                            });
                          },
                        ),

                        Text("Fast",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 150.0),

            // ready button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                side: BorderSide(
                  color: Colors.black,
                  width: 5.0,
                ),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                // snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Game settings updated!'),
                    duration: Duration(seconds: 2),
                  ),
                );

                // set the game mode variables and close the options page
                setState(() {
                  flagMode = flagMode;
                  gameSpeed = gameSpeed;
                });
                Navigator.pop(context);
              },
              child: Text(
                'IM READY!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
