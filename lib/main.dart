import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:livres/LivreDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bibliothèque',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: LibraryScreen(),
    );
  }
}

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<dynamic> books = [];

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse('http://192.168.1.9:8000/'));

    if (response.statusCode == 200) {
      final parsedBooks = json.decode(response.body);
      setState(() {
        books = parsedBooks;
      });
    } else {
      setState(() {
        books = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(books: books);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.books,
  });

  final List books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bibliothèque'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/crime.jpeg'),
            fit: BoxFit.cover,
          )
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child:Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image.network(
                        books[index]['image'],
                        width: 100,
                        height: 100,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              books[index]['nom'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                            Text(books[index]['auteur']),
                            const SizedBox(height: 8),
                            Text(books[index]['categorie'],
                              ),
                          ],
                        ),
                    ),
                        IconButton(
                          icon: Icon(Icons.read_more_rounded),
                          onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LivreDetailPage(livre: books[index]),
                              )
                            );
                          },
                        ),
                ],
              ),
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}
