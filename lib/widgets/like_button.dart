import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int initialLikes;
  final ValueChanged<bool>? onLikeChanged;
  final bool showCount;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? size;

  const LikeButton({
    Key? key,
    this.initialLikes = 0,
    this.onLikeChanged,
    this.showCount = true,
    this.activeColor,
    this.inactiveColor,
    this.size,
  }) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {
  late bool _isLiked;
  late int _likeCount;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _isLiked = false;
    _likeCount = widget.initialLikes;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    widget.onLikeChanged?.call(_isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleLike,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked
                        ? widget.activeColor ?? Colors.red
                        : widget.inactiveColor ?? Colors.grey,
                    size: widget.size ?? 24,
                  ),
                  if (widget.showCount) ...[
                    const SizedBox(width: 8),
                    Text(
                      '$_likeCount',
                      style: TextStyle(
                        fontSize: widget.size != null ? widget.size!! * 0.6 : 14,
                        fontWeight: FontWeight.w600,
                        color: _isLiked
                            ? widget.activeColor ?? Colors.red
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class RatingWidget extends StatefulWidget {
  final double initialRating;
  final int maxRating;
  final ValueChanged<double>? onRatingChanged;
  final bool interactive;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const RatingWidget({
    Key? key,
    this.initialRating = 0.0,
    this.maxRating = 5,
    this.onRatingChanged,
    this.interactive = true,
    this.size = 24,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _handleRatingChange(double rating) {
    if (!widget.interactive) return;
    
    setState(() {
      _currentRating = rating;
    });
    
    widget.onRatingChanged?.call(rating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) {
        final starValue = index + 1.0;
        final isActive = starValue <= _currentRating;
        
        return GestureDetector(
          onTap: () => _handleRatingChange(starValue),
          child: Icon(
            isActive ? Icons.star : Icons.star_border,
            color: isActive
                ? widget.activeColor ?? Colors.orange
                : widget.inactiveColor ?? Colors.grey.shade300,
            size: widget.size,
          ),
        );
      }),
    );
  }
}
