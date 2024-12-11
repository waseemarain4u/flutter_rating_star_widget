// Main widget to handle a custom interactive star-based rating system
import 'package:flutter/material.dart';
import 'package:flutter_rating_star_widget/painter/star_border_painter.dart';
import 'package:flutter_rating_star_widget/clipper/star_clipper.dart';

class RatingStarWidget extends StatefulWidget {
  final String title; // Title for the rating section
  final int maxRating; // The maximum number of stars (default is 5)
  final double initialRating; // The initial pre-selected rating value
  final Function(double)
      onRatingSelected; // Callback function for rating updates

  const RatingStarWidget({
    super.key,
    required this.title,
    this.maxRating = 5,
    this.initialRating = 0.0,
    required this.onRatingSelected,
  });

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

// State class for `RatingStarWidget`
class _RatingStarWidgetState extends State<RatingStarWidget> {
  late double _currentRating; // Current rating value

  @override
  void initState() {
    super.initState();
    _currentRating = widget
        .initialRating; // Initialize the current rating with the initial provided value
  }

  // Handles the logic for updating the rating when a star is clicked
  void _handleRatingUpdate(int index) {
    setState(() {
      if (_currentRating == index + 1.0) {
        _currentRating = 0.0; // Reset rating if the same star is clicked
      } else {
        _currentRating =
            index + 1.0; // Set the current rating to the clicked star's value
      }
    });
    widget.onRatingSelected(
        _currentRating); // Notify the parent widget about the updated rating
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row containing stars for user interaction
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.maxRating,
            (index) => GestureDetector(
              onTap: () => _handleRatingUpdate(index), // Handle star clicks
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Star with filled color based on the current rating
                  ClipPath(
                    clipper: StarClipper(),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: index < _currentRating
                          ? Colors
                              .amber // Star filled if it is part of the current rating
                          : Colors.transparent,
                    ),
                  ),
                  // Star border drawn using a custom painter
                  CustomPaint(
                    size: const Size(40, 40),
                    painter: StarBorderPainter(
                      borderColor: Colors.orange, // Define the border color
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0), // Add spacing below the stars
        // Display the title and the current rating value
        Text(
          '${widget.title}: ${_currentRating.toStringAsFixed(1)}',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
