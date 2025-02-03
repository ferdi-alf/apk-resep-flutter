import 'package:apk_resep/screen/detailresep_screen.dart';
import 'package:apk_resep/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart'; // Import provider
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ChangeNotifier {
  int _selectedIndex = 0;
  List<dynamic> recipes = [];
  bool isLoading = true;

  final List<Widget> _pages = [
    HomeContent(), // Halaman Home
    SearchScreen(), // Placeholder untuk Search
    const ProfileScreen(), // Halaman Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserRecipes();
  }

  Future<void> _loadUserRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) return;

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/resep/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          recipes = json.decode(response.body);
          isLoading = false;
        });
        notifyListeners(); // Notify listeners after loading recipes
      } else {
        print("Gagal mengambil data resep: ${response.body}");
        setState(() {
          isLoading = false;
        });
        notifyListeners(); // Notify listeners if there's an error
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
      notifyListeners(); // Notify listeners if there's an exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_HomeScreenState>(
      create: (_) => this, // Provide the current state to the tree
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFFF55722),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: Color(0xFFFF55722),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            Expanded(
              child: Container(color: Colors.white),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              _greetings(),
              const SizedBox(height: 10),
              _cardMaker(),
              const SizedBox(height: 20),
              _buildRecipeList(), // Menambahkan ListView di bawah card
            ],
          ),
        ),
      ],
    );
  }

  Widget _greetings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Come's Recipe?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, size: 26),
            color: Colors.white,
            onPressed: () {
              // Tambahkan aksi search di sini
            },
          ),
        ],
      ),
    );
  }

  Column _cardMaker() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 336 / 184,
            children: [
              _card("Makanan Berat", "assets/images/makanan_berat.png"),
              _card("Makanan Ringan", "assets/images/makanan_ringan.png"),
              _card("Minuman", "assets/images/minuman.png"),
              _card("Dessert", "assets/images/dessert.png"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _card(String title, String imagePath) {
    return AspectRatio(
      aspectRatio: 336 / 184,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromARGB(255, 205, 54, 4),
        ),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDEE1FE),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      border: Border.all(
                        color: Colors.white.withOpacity(.12),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "See Category",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeList() {
    return Consumer<_HomeScreenState>(
      // Consumer to access _HomeScreenState
      builder: (context, state, child) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.recipes.isEmpty) {
          return Center(child: Text("Tidak ada resep tersedia"));
        } else {
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: state.recipes.length,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) {
              final resep = state.recipes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailResep(resepId: resep['id']),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'http://10.0.2.2:8000${resep!['image']}',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: Icon(Icons.image_not_supported, size: 50),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resep['title'] ?? 'Tidak ada judul',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                resep['created_at'] != null
                                    ? formatDate(resep['created_at'])
                                    : 'Tanggal tidak tersedia',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
  }
}
