import 'package:flutter/material.dart';

import '../../models/categoryModel.dart';
import '../../services/user_services.dart';
import '../screens/Home/category_screen.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final UserServices userServices = UserServices();
  List<CategoryModel>? categories;

  @override
  void initState() {
    super.initState();
    fetchAllCategories();
  }

  void navigateToCategoryByProductDetailsScreen(
    BuildContext context,
    String? category,
  ) {
    Navigator.pushNamed(context, CategoryScreen.routeName, arguments: category);
  }

  Future<void> fetchAllCategories() async {
    categories = await userServices.fetchAllCategories(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return categories == null
        ? Center(
          child: CircularProgressIndicator(),
        ) // Show loading indicator while fetching data
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  categories!.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap:
                            () => navigateToCategoryByProductDetailsScreen(
                              context,
                              category.name!,
                            ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35, // Adjust size as needed
                              backgroundImage: NetworkImage(category.image!),
                              backgroundColor:
                                  Colors.grey[200], // Placeholder color
                            ),
                            SizedBox(height: 5),
                            Text(
                              category.name!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        );
  }
}
