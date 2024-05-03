// Game Page
//
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert';
import 'dart:async';
import 'gameOver.dart';
import 'package:audioplayers/audioplayers.dart';

// API deets
const apiKey = 'D2HmoXMmuwKZMo8IGG9I5N2Q4HVKjKWWzX1pUbKi';
const apiURL = 'https://countryapi.io/api/';

// headers for the API authorization
Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': apiKey,
};

// globals
Map<String, dynamic> randomCountry = {};
List<Map<String, dynamic>> otherCountries = [];
List<Map<String, dynamic>> options = [];
int score = 0;
int guesses = 3;

// audio player
final player = AudioPlayer();


class GamePage extends StatefulWidget {
  // game modes
  final bool flagMode;
  final bool gameSpeed;

// get the values from the options page
  GamePage({required this.flagMode, required this.gameSpeed});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // timer
  late Timer gameTimer;
  int timeLeft = 10;

  // check the game speed (if enabled, reduce the time to 5 seconds)
  @override
  void initState() {
    super.initState();
    if (widget.gameSpeed == false) {
      timeLeft = 5;
    }
  }

  // timer function
  void startTimer() {
    gameTimer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(() {
        if (timeLeft < 1) {
          timer.cancel();
        } else {
          timeLeft--;
        }
      }),
    );
  }

// dispose the timer when the game is over
  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game',
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
            colors: [Colors.yellowAccent, Colors.white],
          ),
        ),
      child: Column(
        children: [

          SizedBox(height: 20),

          // start game button
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
            onPressed: () async {

              // snackbar to show the user that the game has started
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Game Started!'),
                  duration: Duration(seconds: 2),
                ),
              );

              // reset the score and lives
              score = 0;
              guesses = 3;

              // get a random country (the correct answer)
              randomCountry = await getRandomCountry();

              // get other countries (the wrong answers)
              otherCountries = await Future.wait([
                getRandomCountry(),
                getRandomCountry(),
                getRandomCountry(),
              ]);

              // gather all the countries and shuffle them
              options = [randomCountry, ...otherCountries];
              options.shuffle();

              // start the timer
              startTimer();

              // update the UI
              setState(() {});
            },
            child: const Text('Start Game'),
          ),

          const SizedBox(height: 60),


          // timer
          Text('Time: $timeLeft',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
          ),

         // if the flag mode is enabled, show the flag image and ask the user to guess the country
          if (widget.flagMode == true &&
              randomCountry != null &&
              randomCountry['flag'] != null)
            Image.network(
              randomCountry['flag']['medium'],
            ),

          const SizedBox(height: 20),

          // options to choose from
          if (options != null)
            Expanded(
              child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    var country = options[index];
                    return ListTile(
                      title: Text(country['name']),
                      trailing: Icon(Icons.question_answer),
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      hoverColor: Colors.redAccent,
                      selectedTileColor: Colors.greenAccent,
                      minVerticalPadding: 20,
                      enableFeedback: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onTap: () async {
                        // check if the selected country is the correct answer
                        if (country['name'] == randomCountry['name']) {
                          // print('Correct!');

                          // show a snackbar message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Correct!'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // play a sound
                          // player.setAsset('family-feud-good-answer.mp3');
                          // player.play();


                          // add a point
                          setState(() {
                            score++;
                          });

                          // fetch the next question
                          randomCountry = await getRandomCountry();
                          otherCountries = await Future.wait([
                            getRandomCountry(),
                            getRandomCountry(),
                            getRandomCountry(),
                          ]);
                          options = [randomCountry, ...otherCountries];
                          options.shuffle();

                          // reset the timer
                          timeLeft = 10;

                          // update the UI
                          setState(() {});
                        } else {
                          // print('Incorrect!');

                          // show a snackbar message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Incorrect!'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // play the wrong answer sound
                          // player.setAsset('family-feud-wrong-answer.mp3');
                          // player.play();


                          // subtract a point
                          setState(() {
                            guesses--;

                            // end the game if the player runs out of lives or time
                            if (guesses < 1 || timeLeft < 1) {
                              gameTimer.cancel();

                              // grab final score and guesses left
                              var finalScore = score;
                              var guessesLeft = guesses;

                              // game over message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Game Over!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              // get rid of the flags and options
                              randomCountry = {};
                              otherCountries = [];
                              options = [];

                              // reset the score and lives
                              guesses = 3;
                              score = 0;

                              // navigate to the game over page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameOverPage(
                                    finalScore: finalScore,
                                    guessesLeft: guessesLeft,
                                  ),
                                ),
                              );
                            }
                          });
                        }

                        // update the UI
                        setState(() {});
                      },
                    );
                  }),
            ), // expanded

                        // score
          Text('Score: $score',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
          ),

                    // attempts
          Text('Guesses left: $guesses',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
          ),

          const SizedBox(height: 20),

          // test button
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameOverPage(
                    finalScore: score,
                    guessesLeft: guesses,
                  ),
                ),
              );
            },
            child: const Text('End Game'),
          ),

        ],
      ),
    ),
    );
  }
}

// game functions

// get random country that returns a map of the country details
Future<Map<String, dynamic>> getRandomCountry() async {
  Map<String, dynamic> randomCountry = {};

  try {
    var response = await http.get(Uri.parse(apiURL + 'all?apikey=' + apiKey),
        headers: headers);

// check if the response is successful
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      // get a random country from the map
      var random = new Random();
      var keys = data.keys.toList();
      // print("keyss: $keys");
      var randomKey = keys[random.nextInt(keys.length)];
      randomCountry = data[randomKey]; // keys are country codes

      print('country received');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('Error: $e');
  }

  return randomCountry;
}
