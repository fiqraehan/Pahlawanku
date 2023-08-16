import 'package:flutter/material.dart';
import 'package:pahlawanku/api_service.dart';
import 'detail_page.dart';
import 'search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pahlawanku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        '/search': (context) => SearchPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _heroes = [];

  @override
  void initState() {
    super.initState();
    _fetchHeroes();
  }

  Future<void> _fetchHeroes() async {
    final heroesData = await ApiService.fetchData('heroes');
    setState(() {
      _heroes = heroesData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pahlawanku'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: _heroes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _heroes.length,
              itemBuilder: (context, index) {
                final hero = _heroes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      title: GestureDetector(
                        onTap: () {
                          _navigateToDetailPage(context, hero);
                        },
                        child: Text(
                          hero['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _navigateToDetailPage(BuildContext context, dynamic hero) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(hero: hero),
      ),
    );
  }
}
