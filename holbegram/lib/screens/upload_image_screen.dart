import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../methods/auth_method.dart';
import 'login_screen.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const AddPicture({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    _image = null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> selectImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      final Uint8List imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _image = imageBytes;
      });
    }
  }

  Future<void> selectImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      final Uint8List imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _image = imageBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 28),
              Text(
                'Holbegram',
                style: TextStyle(fontFamily: 'Billabong', fontSize: 50),
              ),
              Image.asset('assets/images/logo.png', width: 80, height: 60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${widget.username} Welcome to Holbergram.',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('Choose an image from your gallery or take a new one.',  style: TextStyle(fontSize: 14))
                  ],
                ),
              ),
            SizedBox(height: 28),
            if (_image != null)
              Image.memory(_image!, height: 200, width: 200, fit: BoxFit.cover)
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/authlogo.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: selectImageFromGallery,
                  icon: SvgPicture.asset(
                    'assets/images/imageIcon.svg',
                    width: 45,
                    height: 45,
                    colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: 100),
                IconButton(
                  onPressed: selectImageFromCamera,
                  icon: SvgPicture.asset(
                    'assets/images/cameraIcon.svg',
                    width: 45,
                    height: 45,
                    colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await AuthMethode().signUpUser(
                      email: widget.email,
                      username: widget.username,
                      password: widget.password,
                      file: _image,
                    );
                    if (!mounted) return;

                    if (result == 'success') {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacementNamed(
                        '/login',
                        arguments: {
                          'email': widget.email,
                          'password': widget.password,
                        },
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('Next', style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
