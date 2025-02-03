import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DetailResep extends StatefulWidget {
  final int resepId;

  const DetailResep({Key? key, required this.resepId}) : super(key: key);

  @override
  _DetailResepState createState() => _DetailResepState();
}

class _DetailResepState extends State<DetailResep> {
  Map<String, dynamic>? resep;
  List<dynamic> userRecipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchResepDetail();
    _loadUserRecipes();
  }

  Future<void> _fetchResepDetail() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) return;
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/resep/${widget.resepId}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        resep = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengambil data resep")),
      );
    }
  }

  Future<void> _loadUserRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) return;

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/resep/user'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          userRecipes = data is List ? data : [];
        });
      } else {
        print("Gagal mengambil data resep: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Resep")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : resep == null
              ? Center(child: Text("Resep tidak ditemukan"))
              : Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'http://10.0.2.2:8000${resep!['image']}',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey[300],
                              child: Icon(Icons.image_not_supported, size: 50),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      // Judul Resep
                      Text(
                        resep!['title'] ?? 'Tidak ada judul',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Deskripsi
                      Text(
                        resep!['description'] ?? 'Tidak ada deskripsi',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
    );
  }
}
