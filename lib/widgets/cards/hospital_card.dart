import 'package:flutter/material.dart';
import '../../models/hospital/hospital_place_model.dart';
import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';

class HospitalCard extends StatelessWidget {
  final HospitalPlaceModel hospital;

  const HospitalCard({Key? key, required this.hospital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🖼 Top image with bookmark
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  hospital.imageUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      color: Colors.grey[200],
                      child: Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.bookmark, size: 20, color: Colors.white),
              ),
            ],
          ),

          // 📄 Hospital Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.heading(hospital.name, fontSize: 16),
                SizedBox(height: 4),
                AppText.caption(
                  hospital.address,
                  color: Colors.grey[600],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    AppText.caption("${hospital.rating}"),
                    SizedBox(width: 4),
                    Row(
                      children: List.generate(
                        5,
                            (index) =>
                            Icon(Icons.star, size: 14, color: Colors.amber),
                      ),
                    ),
                    SizedBox(width: 4),
                    AppText.caption(
                      "(${hospital.reviews})",
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Spacer(),

          // 🔘 Bottom Buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButton(
                  type: ButtonType.text,
                  onPressed: () {},
                  child: Icon(
                    Icons.location_on,
                    size: 20,
                    color: Colors.grey.shade700,
                  ),
                ),
                AppButton(
                  type: ButtonType.text,
                  onPressed: () {},
                  child: Icon(
                    Icons.phone,
                    size: 20,
                    color: Colors.grey.shade700,
                  ),
                ),
                AppButton(
                  type: ButtonType.text,
                  onPressed: () {},
                  child: Icon(
                    Icons.share,
                    size: 20,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}