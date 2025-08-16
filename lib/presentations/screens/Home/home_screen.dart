import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../../widgets/carousel_slider.dart';
import '../../widgets/category_list.dart';
import '../../widgets/home_grid_items.dart';
import '../Drawer/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().user;
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromRadius(30),
        child: AppBar(
          title: Text("${userProvider.name}"),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {
          //       // Navigate to cart page
          //     },
          //   ),
          // ],
          leading: Builder(
            builder:
                (context) => IconButton(
                  onPressed: Scaffold.of(context).openDrawer,
                  icon: const Icon(Icons.menu),
                ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SectionTitle(title: "Categories"),
            const MyCarouselSlider(),
            const CategoryList(),

            const SectionTitle(title: "Our Products"),
            const HomeGridItems(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 15, top: 10),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
