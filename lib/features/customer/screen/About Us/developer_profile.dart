import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utils/global_colors.dart';
import 'about_us.dart';

class DeveloperProfilePage extends StatelessWidget {
  final Developer developer;

  DeveloperProfilePage({required this.developer});

  // Method to get the contribution based on the developer's name
  String getContribution(String name) {
    switch (name) {
      case 'Mayesha Tasnim':
        return 'Contributions of Mayesha Tasnim: Developer 1.';
      case 'S. M. Nafis Ahmed':
        return 'Contributions of S. M. Nafis Ahmed: Developer 2.';
      case 'Sadia Bintay Mostafiz':
        return 'Contributions of Sadia Bintay Mostafiz: Developer 3.';
      case 'Shohanur Rahman Shovo':
        return 'Contributions of Shohanur Rahman Shovo: Developer 4';
      case 'Shaheed Shykh Ash-habul Yamin':
        return 'Do not think of those who have been killed in the way of Allah as dead. Rather, they are alive with their Lord, receiving provision - Surah Al-Imran (3:169-171)';
      default:
        return 'Contribution details not available.';
    }
  }

  @override
  Widget build(BuildContext context) {
    String contribution = getContribution(developer.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          developer.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: GlobalColors.mainColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Conditional widget: If developer is Shaheed Shykh Ash-habul Yamin, display a square image
              if (developer.name == 'Shaheed Shykh Ash-habul Yamin')
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(developer.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              else
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(developer.image),
                  ),
                ),
              SizedBox(height: 30),

              // Developer's name with bigger font
              Text(
                developer.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.mainColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Contribution text
              Text(
                contribution,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}