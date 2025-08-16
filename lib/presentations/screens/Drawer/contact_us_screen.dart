import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../widgets/snackbar.dart';

final _keyform = GlobalKey<FormState>();

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void sendMessage() {
    String name = _nameController.text;
    String email = _emailController.text;
    String message = _messageController.text;

    ShowSnack(context, "Thank you! Our team will contact you soon");

    Navigator.pop(context);
  }

  Future<void> _launchURL(String url) async {
    LaunchMode.externalNonBrowserApplication;
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Contact Us")),
      // drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _keyform,
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    "Have a Question for",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Center(
                  child: Text(
                    "Arvabil",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (name) =>
                            name!.isEmpty ? 'Please enter your name' : null,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "E-mail",
                      border: OutlineInputBorder(),
                    ),
                    validator: validateEmail,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Message",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator:
                        (message) =>
                            message!.isEmpty || message.length < 10
                                ? 'Please enter at least 10 characters'
                                : null,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_keyform.currentState!.validate()) {
                        sendMessage();
                      }
                    },
                    style: ElevatedButton.styleFrom(),
                    child: const Text(
                      "Send Message",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    const Text(
                      "Contact",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextButton(
                        onPressed: () {
                          final Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: 'arvabil@gmail.com',
                          );

                          launchUrl(emailUri);
                        },
                        child: Text("arvabil@gmail.com"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      onPressed:
                          () => _launchURL(
                            'https://www.facebook.com/yourprofile',
                          ),
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.instagram),
                      onPressed:
                          () => _launchURL(
                            'http://www.instagram.com/arvabilproducts/',
                          ),
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.globe),
                      onPressed:
                          () => _launchURL('https://www.arvabilproduct.com/'),
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.twitter),
                      onPressed:
                          () => _launchURL(
                            'https://x.com/Arvabil_Dream?t=EYzPyDkLdHosZsmoTihAXw&s=09',
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
