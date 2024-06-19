import 'package:flutter/material.dart';
import 'package:sdp2/common/widgets/PriceRange/priceRange.dart';
import '../Sort/sortBy.dart';

class FilterBy extends StatelessWidget {
  const FilterBy({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left:0,top: 10.0),
          child: Text(
            'Filter By',
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: PriceRange(),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text('Brand_sortBy'),
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),

                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SortBy()),
                            );
                          },
                        ),
                      ],
                    ),
                   ),
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                            child: Text('Color'),
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => BrandPage()),
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text('Style'),
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => BrandPage()),
                            // );
                          },
                        ),
                      ],
                    ),

                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text('Newest'),
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => BrandPage()),
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],//children
        ),
      ),
    );
  }
}