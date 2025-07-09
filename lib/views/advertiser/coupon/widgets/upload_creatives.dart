import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

class UploadCreativesWidget extends StatefulWidget {
  final bool showVirusScan;
  final VoidCallback? onUploadTap;
  final VoidCallback? onVirusScanTap;

  const UploadCreativesWidget({
    Key? key,
    this.showVirusScan = false,
    this.onUploadTap,
    this.onVirusScanTap,
  }) : super(key: key);

  @override
  State<UploadCreativesWidget> createState() => _UploadCreativesWidgetState();
}

class _UploadCreativesWidgetState extends State<UploadCreativesWidget> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];
  PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        setState(() {
          // Limit to maximum 2 images
          _selectedImages = images.take(2).toList();
          _currentImageIndex = 0;
        });

        // Reset page controller to first image
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }

      // Call the original onUploadTap callback if provided
      widget.onUploadTap?.call();
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking images: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
      if (_currentImageIndex >= _selectedImages.length &&
          _selectedImages.isNotEmpty) {
        _currentImageIndex = _selectedImages.length - 1;
        _pageController.animateToPage(
          _currentImageIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget _buildImageOverlay() {
    if (_selectedImages.isEmpty) return SizedBox.shrink();

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            // Image PageView
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: FileImage(File(_selectedImages[index].path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),

            // Remove button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => _removeImage(_currentImageIndex),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),

            // Navigation arrows (only show if more than 1 image)
            if (_selectedImages.length > 1) ...[
              // Left arrow
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_currentImageIndex > 0) {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ),

              // Right arrow
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_currentImageIndex < _selectedImages.length - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicators() {
    if (_selectedImages.isEmpty) {
      // Original progress indicators
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Color(0xFFFF6F61),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
        ],
      );
    } else {
      // Progress indicators for selected images
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _selectedImages.length,
          (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  _currentImageIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 111, 97, 0.08),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main upload area with dotted border
          GestureDetector(
            onTap: _pickImages,
            child: DottedBorder(
              color: Color(0xFFFF6F61),
              strokeWidth: 2.0,
              dashPattern: [8, 4],
              borderType: BorderType.RRect,
              radius: Radius.circular(8.0),
              child: Container(
                width: double.infinity,
                height: 200,
                child: Stack(
                  children: [
                    // Original upload UI
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Cloud upload icon
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 48,
                            color: Color(0xFFFF6F61),
                          ),
                          const SizedBox(height: 16),
                          // Upload text
                          Text(
                            'Upload creatives',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Progress indicators
                          _buildProgressIndicators(),
                        ],
                      ),
                    ),

                    // Image overlay (only shows when images are selected)
                    _buildImageOverlay(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Bottom section with text and virus scan
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Upload information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload a JPG, PNG, or MP4 up to 10 MB',
                      style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Max 2 Images allowed',
                      style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              // Right side - Virus scan widget (optional)
              if (widget.showVirusScan)
                GestureDetector(
                  onTap: widget.onVirusScanTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 111, 97, 0.15),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Virus scan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF6F61),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.close, size: 16, color: Color(0xFFFF6F61)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
