import 'package:flutter/material.dart';

class ShimmerBox extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  const ShimmerBox({super.key, this.width, this.height, this.borderRadius});

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(-1 + 2 * _controller.value, 0),
              end: Alignment(1 + 2 * _controller.value, 0),
              colors: [
                scheme.surfaceVariant.withValues(alpha: 0.6),
                scheme.surfaceVariant.withValues(alpha: 0.3),
                scheme.surfaceVariant.withValues(alpha: 0.6),
              ],
              stops: const [0.1, 0.3, 0.4],
            ),
          ),
        );
      },
    );
  }
}
