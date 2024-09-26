import 'package:flutter/material.dart';
import '../../../../utils/global_colors.dart';
import 'developer_profile.dart';

class AboutUsPage extends StatelessWidget {
  final List<Developer> developers = [
    Developer('Mayesha Tasnim', 'assets/developers/mayesha.jpg'),
    Developer('S. M. Nafis Ahmed', 'assets/developers/nafis.jpg'),
    Developer('Sadia Bintay Mostafiz', 'assets/developers/sadia.jpg'),
    Developer('Shohanur Rahman Shovo', 'assets/developers/shovo.jpg'),
    Developer('Shaheed Shykh Ash-habul Yamin', 'assets/developers/yamin.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Team', style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: GlobalColors.mainColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: developers.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(developers[index].image),
                ),
                title: Text(
                  developers[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.mainColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    'View',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeveloperProfilePage(
                          developer: developers[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Developer {
  final String name;
  final String image;

  Developer(this.name, this.image);
}