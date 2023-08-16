import 'package:flutter/material.dart';
import 'package:pahlawanku/api_service.dart'; // Sesuaikan path dengan nama proyek Anda
import 'detail_page.dart'; // Impor halaman DetailPage

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> _heroes = [];
  List<dynamic> _filteredHeroes = [];

  @override
  void initState() {
    super.initState();
    _fetchHeroes();
  }

  Future<void> _fetchHeroes() async {
    final heroesData = await ApiService.fetchData('heroes');
    setState(() {
      _heroes = heroesData;
      _filteredHeroes = _heroes;
    });
  }

  void _searchHeroes(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredHeroes = _heroes;
      });
    } else {
      final filteredHeroes = _heroes.where((hero) {
        final name = hero['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
      setState(() {
        _filteredHeroes = filteredHeroes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Pahlawan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchHeroes,
              decoration: InputDecoration(
                labelText: 'Cari berdasarkan nama pahlawan...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredHeroes.length,
              itemBuilder: (context, index) {
                final hero = _filteredHeroes[index];
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      _navigateToDetailPage(context, hero);
                    },
                    child: Text(
                      hero['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
