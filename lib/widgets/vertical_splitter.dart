import 'package:flutter/material.dart';

class VerticalSplitter extends StatefulWidget {
  final Widget leftChild;
  final Widget rightChild;
  final double initialWeight;

  const VerticalSplitter({
    super.key,
    required this.leftChild,
    required this.rightChild,
    this.initialWeight = 0.5,
  });

  @override
  _VerticalSplitterState createState() => _VerticalSplitterState();
}

class _VerticalSplitterState extends State<VerticalSplitter> {
  late double weight;

  @override
  void initState() {
    super.initState();
    weight = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: (weight * 100).round(),
          child: widget.leftChild,
        ),
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              // Update the weight based on the drag movement
              weight += details.primaryDelta! / context.size!.width;
              weight = weight.clamp(0.0, 1.0);
            });
          },
          child: Container(
            color: Colors.black,
            width: 5.0,
            height: double.infinity,
            child: const Center(
              child: VerticalDivider(
                color: Colors.white,
                thickness: 2.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: ((1 - weight) * 100).round(),
          child: widget.rightChild,
        ),
      ],
    );
  }
}
