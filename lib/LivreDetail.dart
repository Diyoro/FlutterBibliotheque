import 'package:flutter/material.dart';
import 'package:livres/Lecture.dart';

class LivreDetailPage extends StatefulWidget {
  final Map<String, dynamic> livre;

  LivreDetailPage({required this.livre});

  @override
  _LivreDetailPageState createState() => _LivreDetailPageState();
}

class _LivreDetailPageState extends State<LivreDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livre['nom']), // Titre de la page
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.livre['image'],
              width: 200, // Ajustez la largeur de l'image selon vos préférences
              height: 200, // Ajustez la hauteur de l'image selon vos préférences
            ),
            SizedBox(height: 16),
            Text(
              'Auteur: ${widget.livre['auteur']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Categorie: ${widget.livre['categorie']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Description: ${widget.livre['description']}',
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Center(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                  backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent)
                ),
                  onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => PageLecture(livre: widget.livre)
                    )
                  );
                  },
                  label: Text("Lire",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                   icon: Icon(Icons.book),
              ),
            )
          ],
        ),
      ),
    );
  }
}
