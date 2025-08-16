import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Welcome to Arvabil"),
      ),
      // drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // About Us Section
            _buildTitleText("About Us"),
            const SizedBox(height: 20),
            _buildContentText(
                "Arvabil Dream Inception was established in 2021. We are designers, developers, and Traders of handmade Hanging Furniture, outdoor furniture and home décor items providing complete solutions for outdoor and indoor décor."),

            const SizedBox(height: 30),

            // Our Vision Section
            _buildTitleText("Our Vision"),
            const SizedBox(height: 20),
            _buildImageSection("assets/icon/icon2.png"),
            const SizedBox(height: 10),
            // _buildContentText(
            //     ""To make many people's everyday lives better." By the grace of Allah, we want to have a beneficial impact on the world. Our products help people live a more sustainable life at home."),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: '"To make many people\'s everyday lives better." ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'By the grace of Allah, we want to have a beneficial impact on the world. '),
                  TextSpan(
                      text:
                          'Our products help people live a more sustainable life at home.',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              textAlign: TextAlign.center, // Align text to justify
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 20), // Use default theme font with size 20
            ),
            const SizedBox(height: 10),
            _buildContentText(
                "Our platform will blend innovative technology with an intuitive user experience, enabling customers to easily navigate through our curated selections, learn about different furniture sets, and find perfect design for your space."),
            const SizedBox(height: 10),
            // _buildContentText(
            //     "Scentify is committed to excellence, authenticity, and sustainability. We partner with renowned brands and artisanal creators to ensure our offerings are of the highest quality."),

            const SizedBox(height: 30),

            // // Our Approach Section
            // _buildTitleText("Our Approach"),
            // const SizedBox(height: 20),
            // _buildImageSection("assets/ArvabilSofa/s17p5.png"),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "At Arvabil, our approach is designed to transform the way people discover and purchase attars and perfumes through a blend of innovation, personalization, and excellence."),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "Curated Excellence: We offer a meticulously curated selection of attars and perfumes from renowned brands and artisanal creators, ensuring that our customers have access to high-quality and exclusive fragrances."),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "Enhanced Discovery: Leveraging advanced technology, our platform provides intuitive search and filter options, along with scent profiling tools to help users find their ideal fragrances effortlessly."),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "Personalized Experience: We use data-driven insights to offer personalized recommendations, tailoring our suggestions based on individual preferences and browsing history."),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "Commitment to Quality: We prioritize authenticity and sustainability by partnering with brands that share our values."),
            //
            // const SizedBox(height: 30),

            // // Our Process Section
            // _buildTitleText("Our Process"),
            // const SizedBox(height: 20),
            // _buildImageSection("assets/ArvabilSwings/s2.png"),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "At Scentify, our process is designed to provide a smooth, enjoyable, and efficient experience for discovering and purchasing attars and perfumes."),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "Curating Our Collection:\n Sourcing: We collaborate with trusted brands and artisanal perfumers to source a diverse range of high-quality attars and perfumes."),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "Enhancing Discovery:\n Scent Profiling: Our platform features scent profiling tools to help users identify and select fragrances based on their preferences."),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "Personalizing the Experience:\n Tailored Recommendations: We utilize algorithms and user data to offer personalized fragrance recommendations."),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "Streamlining Shopping:\n User-Friendly Interface: Our intuitive design ensures easy navigation from product discovery to checkout."),
            // const SizedBox(height: 10),
            // _buildContentText(
            //     "Delivering Excellence:\n Efficient Fulfillment: Orders are processed promptly and shipped with care to ensure timely delivery."),
            //
            // const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Reusable method for title text
  Widget _buildTitleText(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Reusable method for content text
  Widget _buildContentText(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        content,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.justify,
      ),
    );
  }

  // Reusable method for image section
  Widget _buildImageSection(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Image.asset(
        imagePath,
        height: 250,
        fit: BoxFit.cover,
      ),
    );
  }
}
