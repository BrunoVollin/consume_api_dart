import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2'));

  if (response.statusCode == 200) {
    final info = Album.fromJson(jsonDecode(response.body));
    return info;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Album> fetchAlbumById(int id) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'));

  if (response.statusCode == 200) {
    final info = Album.fromJson(jsonDecode(response.body));
    return info;
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  showAlbum() {
    return '''
      title: ${title}
      IdUser: ${userId} 
      Id: ${id} 
    ''';
  }
}

void main() async {
  var myAlbum = await fetchAlbumById(2);
  print(myAlbum.showAlbum());
}
