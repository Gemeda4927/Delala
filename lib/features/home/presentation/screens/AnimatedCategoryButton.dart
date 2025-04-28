import 'package:flutter/material.dart';

class AnimatedCategoryButton extends StatefulWidget {
  final String title;
  final String color;
  final String icon;
  final VoidCallback onTap;
  final int index;

  const AnimatedCategoryButton({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
    required this.index,
  });

  @override
  _AnimatedCategoryButtonState createState() => _AnimatedCategoryButtonState();
}

class _AnimatedCategoryButtonState extends State<AnimatedCategoryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _colorAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(
      begin: Colors.grey.withOpacity(0.3),
      end: _parseColor(widget.color),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutSine,
      ),
    );

    Future.delayed(Duration(milliseconds: widget.index * 150), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getIconData(String? iconName) {
    switch (iconName?.toLowerCase()) {
      case 'casual_shoes':
        return Icons.directions_walk;
      case 'running_shoes':
        return Icons.directions_run;
      case 'athletic_shoes':
        return Icons.fitness_center;
      case 'high_top_shoes':
        return Icons.accessibility_new;
      default:
        return Icons.category;
    }
  }

  Color _parseColor(String color) {
    try {
      var colorString = color.trim();
      if (!colorString.startsWith('#')) {
        colorString = '#$colorString';
      }
      if (colorString.length == 7 || colorString.length == 9) {
        return Color(int.parse(colorString.replaceFirst('#', '0xff')));
      }
      return Colors.grey;
    } catch (e) {
      debugPrint('Error parsing color in AnimatedCategoryButton: $e');
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = _parseColor(widget.color);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value * (_isHovered ? 1.1 : 1.0),
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _colorAnimation.value!.withOpacity(0.9),
                        _colorAnimation.value!.withOpacity(0.7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: baseColor.withOpacity(_isHovered ? 0.4 : 0.2),
                        blurRadius: _isHovered ? 16 : 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.all(_isHovered ? 14 : 12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Colors.white.withOpacity(_isHovered ? 0.4 : 0.3),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          _getIconData(widget.icon),
                          color: Colors.white,
                          size: _isHovered ? 28 : 24,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
