import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final dynamic hero;

  DetailPage({required this.hero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hero['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Birth Year: ${hero['birth_year']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Death Year: ${hero['death_year']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              hero['description'],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
