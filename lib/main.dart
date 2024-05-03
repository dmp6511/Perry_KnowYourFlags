import 'package:flutter/material.dart';
import 'learn.dart';
import 'options.dart';
import 'game.dart';
import 'package:url_launcher/url_launcher.dart';

// globals
const apiKey = 'D2HmoXMmuwKZMo8IGG9I5N2Q4HVKjKWWzX1pUbKi';
const apiURL = 'https://countryapi.io/api/';

// headers for the API authorization
Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': apiKey,
};

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

///////////////////////
// building the home page
///////////////////////

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Know Your Flags!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.redAccent,

        // map icon
        leading: const IconButton(
          icon: Icon(
            Icons.map,
            color: Colors.black,
            size: 25.0,
          ),
          // send to the home page
          onPressed: null,
        ),

        // actions
        actions: [
          // settings icon
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
              size: 25.0,
            ),
            // return a dialog box
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Credits'),
                    content: const Text('IGME 430 - Project 3\n\nBy: DeAndre Perry\n\nFall 2024\n\nRIT'),
                    actions: [
                      // launch documentation URL
                      TextButton(
                        onPressed: () {
                          // launch the documentation URL
                          launch('https://docs.google.com/document/d/e/2PACX-1vST73WXfNUBrnbny5CV1VZZBJ0dpt83JmB5_DJvU1BC-Bs6DMV1n01rt69c-g_z4Y6fmEKb8pq7CDMw/pub');
                        },
                        child: const Text('Documentation'),
                      ),

                      // close button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      // body
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.brown[200],
        child: SingleChildScrollView(
          child: Column(
            children: [
              // flags image
              Transform.translate(
                offset: Offset(0, 0),
                child: Container(
                  height: 220,
                  width: 470,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                   gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.white],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    border: Border.all(
                      width: 0.0,
                      color: Colors.black,
                    ),
                  ),
                  child: Image.network(
                    'https://i5.walmartimages.com/asr/f71c7cc9-b63f-42f7-99dc-b699494fce89.1fbf8b276963f3482e597f051b7eaa2b.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // game title
              Container(
                height: 150,
                width: 450,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.yellow, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  '        Think you \n Know Your Flags?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // spacing
              SizedBox(height: 35),


              MouseRegion(
                onEnter: (event) {
                  // change the cursor to a click
                  color: Colors.greenAccent;
                  print('Mouse entered');
                },
                cursor: SystemMouseCursors.click,
                child:
                    // start button
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

                  // send to game page on default game mode (flag mode and normal speed)
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GamePage(flagMode: true, gameSpeed: true)),
                    );
                  },
                  child: Text(
                    'START',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // spacing
              SizedBox(height: 15),

              // learn button
              Tooltip(
                message: 'Learn about the game',
                child:
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
                    MaterialPageRoute(builder: (context) => LearnPage()),
                  );
                }, // send to learn page
                child: Text(
                  'LEARN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ),

              // spacing
              SizedBox(height: 15),

              // options button
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
                    MaterialPageRoute(builder: (context) => OptionsPage()),
                  );
                }, // send to options page
                child: Text(
                  'OPTIONS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // end of body
    );
  }
}
