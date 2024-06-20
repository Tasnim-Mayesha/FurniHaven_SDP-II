import 'package:flutter/material.dart';

class SortBy extends StatefulWidget {
  const SortBy({super.key});

  @override
  _SortByState createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  String? _selectedOption = 'none'; // Initial selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'Sort By',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30.0,top: 10.0),
              child: Text(
                'Best Match',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color:Colors.orange),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  RadioListTile<String>(
                    title: const Text('New arrivals'),
                    value: 'New arrivals',
                    groupValue: _selectedOption,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Discount'),
                    value: 'Discount',
                    groupValue: _selectedOption,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Price: Low to High'),
                    value: 'PriceLtH',
                    groupValue: _selectedOption,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Price: High to Low'),
                    value: 'PriceHtL',
                    groupValue: _selectedOption,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Relevance'),
                    value: 'Relevance',
                    groupValue: _selectedOption,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
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