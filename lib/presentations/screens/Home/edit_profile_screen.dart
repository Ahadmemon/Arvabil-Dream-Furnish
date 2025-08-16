import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../../../services/auth_service.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "editProfileScreen";

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfileScreen> {
  File? _profileImage;
  String? _imageUrl; // Store the uploaded image URL
  final ImagePicker _picker = ImagePicker();
  final AuthService authService = AuthService();

  TextEditingController? nameController;
  TextEditingController? contactController;
  TextEditingController? addressController;
  TextEditingController? mailController;

  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    nameController = TextEditingController(text: userProvider.user.name);
    contactController = TextEditingController(text: userProvider.user.phone);
    addressController = TextEditingController(text: userProvider.user.address);
    mailController = TextEditingController(text: userProvider.user.email);
    _imageUrl = userProvider.user.profileImage; // Load existing profile pic
  }

  // Function to select an image
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      if (mounted) {
        setState(() {
          _profileImage = File(pickedImage.path);
        });
      }
      await _uploadImageToCloudinary(); // Upload after setting image
    }
  }

  // Function to upload image to Cloudinary
  Future<void> _uploadImageToCloudinary() async {
    if (_profileImage == null) return;
    try {
      final cloudinary = CloudinaryPublic("dixkmzeoe", "my_upload_preset");
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(_profileImage!.path),
      );
      if (mounted) {
        setState(() {
          _imageUrl = res.secureUrl;
        });
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  // Function to show image selection dialog
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Choose Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Capture from Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Select from Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }

  // Function to edit profile
  void editProfile() {
    authService.editProfile(
      context: context,
      email: mailController!.text.trim(),
      phone: contactController!.text.trim(),
      address: addressController!.text.trim(),
      name: nameController!.text.trim(),
      profileImage: _imageUrl!, // Save Cloudinary URL
    );
    Navigator.pushReplacementNamed(context, BottomNavBar.routeName);
  }

  @override
  Widget build(BuildContext context) {
    // Get current keyboard height to adjust padding
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Set to false to avoid default resize
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom:
              keyboardHeight == 0
                  ? 16.0
                  : keyboardHeight +
                      16.0, // Adjust padding based on keyboard visibility
        ),
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: _showImageSourceDialog,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[400],
                      child:
                          _profileImage != null
                              ? ClipOval(
                                child: Image.file(
                                  _profileImage!,
                                  // Display the local image before uploading
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              )
                              : _imageUrl != null
                              ? ClipOval(
                                child: Image.network(
                                  _imageUrl!,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.grey[900],
                                    );
                                  },
                                ),
                              )
                              : const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Name Field
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Contact Number Field
            TextFormField(
              controller: contactController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                hintText: "+91 1234567890",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Address Field
            TextFormField(
              controller: addressController,
              maxLines: 3,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on),
                hintText: "2 Abc society, city, state - pincode",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Save Button
            CustomButton(onPressed: editProfile, label: 'Save Changes'),
          ],
        ),
      ),
    );
  }
}
