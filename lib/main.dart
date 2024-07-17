import 'package:flutter/material.dart';

//import 'package:share_plus/share_plus.dart';

void main() {
  runApp(CitationDuJourApp());
}

class CitationDuJourApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
      ),
      home: CitationScreen(),
    );
  }
}

class CitationScreen extends StatefulWidget {
  @override
  _CitationScreenState createState() => _CitationScreenState();
}

class _CitationScreenState extends State<CitationScreen>
    with SingleTickerProviderStateMixin {
  List<String> citations = [
    "La vie est belle.",
    "Le savoir est une arme.",
    "Le bonheur est une direction, pas une destination.",
    "Rien n'est impossible à celui qui croit.",
    "Chaque jour est une nouvelle opportunité."
  ];

  int indexCitation = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    // Commencer l'animation à sa position finale pour afficher la citation par défaut
    _controller.forward();
  }

  // void partagerCitation() {
  //   Share.share(citations[indexCitation]);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void genererCitation(int direction) {
    _controller.reverse().then((_) {
      setState(() {
        indexCitation =
            (indexCitation + direction + citations.length) % citations.length;
      });
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Citation du Jour"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.share),
        //     onPressed: partagerCitation,
        //   ),
        // ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      citations[indexCitation],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          size: 30, color: Colors.white),
                      onPressed: () => genererCitation(-1),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward,
                          size: 30, color: Colors.white),
                      onPressed: () => genererCitation(1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
