import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/feedback_provider.dart';

class ProductFeedbackScreen extends StatefulWidget {
  final String productId;

  const ProductFeedbackScreen({required this.productId, super.key});

  @override
  State<ProductFeedbackScreen> createState() => _ProductFeedbackScreenState();
}

class _ProductFeedbackScreenState extends State<ProductFeedbackScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final feedbackProvider = Provider.of<FeedbackProvider>(
        context,
        listen: false,
      );
      feedbackProvider.fetchFeedbacks(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Feedbacks")),
      body: Consumer<FeedbackProvider>(
        builder: (context, feedbackProvider, child) {
          if (feedbackProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (feedbackProvider.feedbacks.isEmpty) {
            return const Center(
              child: Text("No feedbacks yet.", style: TextStyle(fontSize: 20)),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 2.0,
                color: Colors.grey,
              ); // Adds a divider after each item
            },
            itemCount: feedbackProvider.feedbacks.length,
            itemBuilder: (context, index) {
              final feedback = feedbackProvider.feedbacks[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[400],
                  child:
                      feedback.userImage != null
                          ? ClipOval(
                            child: Image.network(
                              feedback.userImage!,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
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

                title: Text(
                  " ${feedback.username}:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  feedback.feedback,
                  style: TextStyle(fontSize: 15),
                ),
                // horizontalTitleGap: 20,
              );
            },
          );
        },
      ),
    );
  }
}
