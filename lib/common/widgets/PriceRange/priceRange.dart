import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceRange extends StatefulWidget {
  final RangeValues rangeValues;
  final ValueChanged<RangeValues> onChanged;

  const PriceRange({
    super.key,
    required this.rangeValues,
    required this.onChanged,
  });

  @override
  _PriceRangeState createState() => _PriceRangeState();
}

class _PriceRangeState extends State<PriceRange> {
  late RangeValues _currentRangeValues;
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentRangeValues = widget.rangeValues;
    _minController.text = _currentRangeValues.start.round().toString();
    _maxController.text = _currentRangeValues.end.round().toString();
  }

  void _updateRangeValues(RangeValues values) {
    // Ensure the range values stay within the allowed range
    final int min = 0;
    final int max = 100000;

    int startValue = values.start.round();
    int endValue = values.end.round();

    if (startValue < min) startValue = min;
    if (endValue > max) endValue = max;

    setState(() {
      _currentRangeValues = RangeValues(startValue.toDouble(), endValue.toDouble());
      _minController.text = startValue.toString();
      _maxController.text = endValue.toString();
    });

    widget.onChanged(_currentRangeValues); // Notify the parent widget of the change
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _minController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final minPrice = int.tryParse(value) ?? 0;
                  if (minPrice <= _currentRangeValues.end.round()) {
                    _updateRangeValues(RangeValues(minPrice.toDouble(), _currentRangeValues.end));
                  } else {
                    _minController.text = _currentRangeValues.start.round().toString();
                  }
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: TextField(
                controller: _maxController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final maxPrice = int.tryParse(value) ?? 0;
                  if (maxPrice >= _currentRangeValues.start.round()) {
                    _updateRangeValues(RangeValues(_currentRangeValues.start, maxPrice.toDouble()));
                  } else {
                    _maxController.text = _currentRangeValues.end.round().toString();
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 100000,
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
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Min'.tr),
            Text('Max'.tr),
          ],
        ),
      ],
    );
  }
}
