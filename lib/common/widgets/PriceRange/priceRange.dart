import 'package:flutter/material.dart';

class PriceRange extends StatefulWidget {
  @override
  _PriceRangeFieldState createState() => _PriceRangeFieldState();
}

class _PriceRangeFieldState extends State<PriceRange> {
  RangeValues _currentRangeValues = const RangeValues(100, 1000);
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _minController.text = _currentRangeValues.start.round().toString();
    _maxController.text = _currentRangeValues.end.round().toString();
  }

  void _updateRangeValues(RangeValues values) {
    setState(() {
      _currentRangeValues = values;
      _minController.text = _currentRangeValues.start.round().toString();
      _maxController.text = _currentRangeValues.end.round().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _minController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // labelText: 'Min',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final minPrice = double.tryParse(value) ?? 0;
                  if (minPrice <= _currentRangeValues.end) {
                    _updateRangeValues(RangeValues(minPrice, _currentRangeValues.end));
                  }
                },
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: TextField(
                controller: _maxController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // labelText: 'Max',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final maxPrice = double.tryParse(value) ?? 0;
                  if (maxPrice >= _currentRangeValues.start) {
                    _updateRangeValues(RangeValues(_currentRangeValues.start, maxPrice));
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 5000,
          divisions: 100,
          activeColor: Colors.deepOrangeAccent,
          inactiveColor: Colors.grey,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            _updateRangeValues(values);
          },
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Min'),
            Text('Max'),
          ],
        ),
      ],
    );
  }
}
