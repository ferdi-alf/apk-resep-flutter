import 'package:apk_resep/screen/detailresep_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _allRecipes = []; // Semua data resep dari API
  List<dynamic> _filteredRecipes = []; // Hasil pencarian yang difilter
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("Token tidak ditemukan!");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:8000/api/resep'), // Ganti dengan endpoint yang sesuai
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _allRecipes = data is List ? data : [];
          _filteredRecipes = _allRecipes;
          _isLoading = false;
        });
      } else {
        print("Gagal mengambil data resep: ${response.body}");
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterRecipes(String query) {
    setState(() {
      _filteredRecipes = _allRecipes
          .where((recipe) =>
              recipe['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cari Resep")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Input Search
            TextField(
              controller: _searchController,
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                hintText: "Cari berdasarkan judul...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredRecipes.isEmpty
                    ? Center(child: Text("Tidak ada resep yang ditemukan"))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _filteredRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = _filteredRecipes[index];
                            return Card(
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'http://10.0.2.2:8000${recipe['image']}',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.image_not_supported);
                                    },
                                  ),
                                ),
                                title: Text(recipe['title']),
                                subtitle: Text(
                                  recipe['description'] ??
                                      'Tidak ada deskripsi',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailResep(
                                        resepId: recipe['id'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
