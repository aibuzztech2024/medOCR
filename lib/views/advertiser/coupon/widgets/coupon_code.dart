import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:avatar/models/coupon/coupon_model.dart';

class CouponCodeComponent extends StatelessWidget {
  final CouponModel coupon;
  final VoidCallback? onTap;
  final VoidCallback? onCopy;

  const CouponCodeComponent({
    Key? key,
    required this.coupon,
    this.onTap,
    this.onCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - Coupon Code section
          Container(
            width: 150,
            decoration: const BoxDecoration(color: Color(0xFFFF6B6B)),
            padding: const EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Coupon Code',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  coupon.code,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    if (coupon.isCopyable) {
                      Clipboard.setData(ClipboardData(text: coupon.code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Coupon code "${coupon.code}" copied to clipboard',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      onCopy?.call();
                    }
                  },
                  child: Container(
                    width: 39,
                    height: 39,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.content_copy,
                      color:
                          coupon.isCopyable
                              ? const Color(0xFFFF6B6B)
                              : Colors.grey,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right side - Details section
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: const Color.fromRGBO(255, 111, 97, 0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 69,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(
                              int.parse(
                                coupon.statusBackgroundColor.replaceAll(
                                  '#',
                                  '0xFF',
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            coupon.status,
                            style: TextStyle(
                              color: Color(
                                int.parse(
                                  coupon.statusColor.replaceAll('#', '0xFF'),
                                ),
                              ),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                          size: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      coupon.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Expiry: ${coupon.formattedExpiryDate}',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          'View Details',
                          style: TextStyle(
                            color: Color(0xFFFF6B6B),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFFF6B6B),
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
