import 'package:flutter/material.dart';
import 'package:sdp2/common/widgets/PriceRange/priceRange.dart';
import '../Sort/sortBy.dart';

class FilterBy extends StatelessWidget {
  const FilterBy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left:0,top: 10.0),
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

            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  const ListTile(
                    title: PriceRange(),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Expanded(
                          child: Text('Brand_sortBy'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.navigate_next),

                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SortBy()),
                            );
                          },
                        ),
                      ],
                    ),
                   ),
                  ListTile(
                    title: Row(
                      children: [
                        const Expanded(
                            child: Text('Color'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.navigate_next),
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
                        const Expanded(child: Text('Style'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.navigate_next),
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
                        const Expanded(child: Text('Newest'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.navigate_next),
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