import 'package:flutter/material.dart';

// ProfileImageWidget (from your existing code)
class ProfileImageWidget extends StatefulWidget {
  final String? imageUrl;
  final VoidCallback? onEditPressed;
  final VoidCallback? onTap;
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Color editButtonColor;
  final IconData editIcon;
  final bool showEditButton;
  final bool enableClickEffect;
  final bool isSelected;

  const ProfileImageWidget({
    Key? key,
    this.imageUrl,
    this.onEditPressed,
    this.onTap,
    this.size = 134.0,
    this.borderColor = Colors.white,
    this.borderWidth = 1.5,
    this.editButtonColor = const Color(0xFFFF8C00),
    this.editIcon = Icons.edit,
    this.showEditButton = true,
    this.enableClickEffect = false,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  bool _isPressed = false;

  void _handleTap() {
    if (widget.enableClickEffect) {
      setState(() => _isPressed = true);
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) setState(() => _isPressed = false);
      });
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveSize = widget.size * (screenWidth < 600 ? 0.8 : 1.0);
    final editButtonSize = responsiveSize * 0.179;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: responsiveSize,
        height: responsiveSize,
        decoration:
            (_isPressed && widget.enableClickEffect) || widget.isSelected
                ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromRGBO(247, 158, 27, 1),
                    width: 5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(228, 182, 114, 1),
                      blurRadius: 12,
                      spreadRadius: 0.01,
                      offset: const Offset(0, 6),
                    ),
                  ],
                )
                : null,
        child: Stack(
          children: [
            Container(
              width: responsiveSize,
              height: responsiveSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                margin:
                    ((_isPressed && widget.enableClickEffect) ||
                            widget.isSelected)
                        ? EdgeInsets.zero
                        : EdgeInsets.all(widget.borderWidth),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      widget.imageUrl != null
                          ? DecorationImage(
                            image: AssetImage(
                              widget.imageUrl!,
                            ), // Changed to AssetImage for local assets
                            fit: BoxFit.cover,
                          )
                          : null,
                  color: widget.imageUrl == null ? Colors.grey[300] : null,
                ),
                child:
                    widget.imageUrl == null
                        ? Icon(
                          Icons.person,
                          size: responsiveSize * 0.4,
                          color: Colors.grey[600],
                        )
                        : null,
              ),
            ),
            if (widget.showEditButton && widget.onEditPressed != null)
              Positioned(
                bottom: 0,
                right: 12,
                child: GestureDetector(
                  onTap: widget.onEditPressed,
                  child: Container(
                    width: editButtonSize,
                    height: editButtonSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.editButtonColor,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 2,
                          spreadRadius: 0.5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.editIcon,
                      color: Colors.white,
                      size: editButtonSize * 0.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
