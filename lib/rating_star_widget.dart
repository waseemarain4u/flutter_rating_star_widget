import 'export.dart';

// RatingStarWidget: A customizable star rating widget that allows users to select a rating interactively.
// This widget supports customizable styles, titles for stars, and a callback to notify about rating changes.

class RatingStarWidget extends StatefulWidget {
  final int maxRating; // Maximum number of stars displayed (default is 5).
  final double initialRating; // Initial rating value (default is 0.0).
  final ValueChanged<double>?
      onRatingSelected; // Callback triggered when a rating is selected.
  final double startSize; // Size of each star (default is 30.0).
  final double space; // Horizontal space between stars (default is 10.0).
  final TextStyle?
      titleStyle; // Style for the title text associated with each star (optional).
  final List<String>?
      titleList; // Titles for stars corresponding to their ratings (optional).
  final Color? fillColor; // Fill color for selected stars (default is amber).
  final Color? borderColor; // Border color for all stars (default is orange).

  const RatingStarWidget({
    super.key,
    this.maxRating = 5,
    this.initialRating = 0.0,
    this.onRatingSelected,
    this.startSize = 30,
    this.space = 10,
    this.titleStyle,
    this.titleList,
    this.fillColor,
    this.borderColor,
  });

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

class _RatingStarWidgetState extends State<RatingStarWidget> {
  late double _currentRating; // Current rating value selected by the user.

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating; // Initialize with initial rating.
  }

  // Updates the current rating when a star is clicked.
  void _handleRatingUpdate(int index) {
    setState(() {
      // Toggle behavior: deselect if the same star is clicked again.
      if (_currentRating == index + 1.0) {
        _currentRating = 0.0; // Reset to 0 (no rating).
      } else {
        _currentRating = index + 1.0; // Update to the clicked star's rating.
      }
    });
    widget.onRatingSelected?.call(_currentRating); // Trigger callback.
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.maxRating,
        (index) => InkWell(
          // Handle tap only if a callback is provided.
          onTap: widget.onRatingSelected != null
              ? () => _handleRatingUpdate(index)
              : null,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.space),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Star rendering with selection logic.
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background color for selected stars.
                    ClipPath(
                      clipper: StarClipper(), // Custom star-shaped clipper.
                      child: Container(
                        width: widget.startSize,
                        height: widget.startSize,
                        color: index < _currentRating
                            ? widget.fillColor ?? Colors.amber.shade600
                            : Colors.transparent,
                      ),
                    ),
                    // Star border for all stars.
                    CustomPaint(
                      size: Size(widget.startSize, widget.startSize),
                      painter: StarBorderPainter(
                        borderColor:
                            widget.borderColor ?? Colors.orange.shade600,
                      ),
                    ),
                  ],
                ),
                // Optional titles for stars.
                if ((widget.titleList ?? []).isNotEmpty &&
                    (widget.titleList?.length ?? 0) == widget.maxRating)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      widget.titleList?[index] ?? "",
                      style: widget.titleStyle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
