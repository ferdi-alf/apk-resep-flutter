import 'dart:io';
import 'package:apk_resep/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostResepScreen extends StatefulWidget {
  const PostResepScreen({super.key});

  @override
  State<PostResepScreen> createState() => _PostResep();
}

class _PostResep extends State<PostResepScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  bool _isLoading = false;

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _pickImageError;

  void _setImageFileFromXFile(XFile? value) {
    _imageFile = value;
  }

  Future<void> _onImageButtonPressed(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      setState(() {
        _setImageFileFromXFile(pickedFile);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e.toString();
      });
    }
  }

  Future<void> _postResepApi() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token'); // Ambil token

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
    if (token == null) {
      print('Token tidak tersedia, user belum login');
      return;
    }

    var uri = Uri.parse('http://10.0.2.2:8000/api/post-resep');

    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['title'] = _title.text
      ..fields['description'] = _description.text;

    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _imageFile!.path,
      ));
    }

    var response = await request.send();
    var responseData = await http.Response.fromStream(response);

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      // Resep berhasil diposting, tampilkan alert & redirect ke ProfileScreen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Resep berhasil ditambahkan!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen()), // Redirect ke ProfileScreen
      );
    } else {
      // Jika gagal, tampilkan pesan error
      print('Gagal memposting resep: ${responseData.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan resep!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post Resep',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF5722),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Bagikan resepmu disini',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Image Preview and Upload Section
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _imageFile != null
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(_imageFile!.path),
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _imageFile = null;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate,
                                      size: 50,
                                      color: Colors.grey[400],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () =>
                                              _onImageButtonPressed(
                                                  ImageSource.gallery),
                                          icon: Icon(
                                            Icons.photo_library,
                                            color: Colors.white,
                                          ),
                                          label: Text('Galeri'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFFF5722),
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        ElevatedButton.icon(
                                          onPressed: () =>
                                              _onImageButtonPressed(
                                                  ImageSource.camera),
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                          label: Text('Kamera'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFFF5722),
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        if (_pickImageError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Error: $_pickImageError',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),

                        SizedBox(height: 16),
                        TextFormField(
                          controller: _title,
                          decoration: InputDecoration(
                            labelText: 'Judul',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF5722)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon masukkan judul resep';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _description,
                          decoration: InputDecoration(
                            labelText: 'Deskripsi',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF5722)),
                            ),
                          ),
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon masukkan deskripsi resep';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        _isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _postResepApi,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 50),
                                  backgroundColor: Color(0xFFFF5722),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  "Post Resep",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
