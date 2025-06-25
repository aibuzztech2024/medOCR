
import 'package:flutter/material.dart';

import '../../../../core/constants/appColors.dart';

Future<void> showDeleteProfileDialog(BuildContext context) async {
  String? selectedReason = "I found a better alternative";
  String otherReason = '';
  bool isYesSelected = true;

  final reasons = [
    "I found a better alternative",
    "The app is hard to use",
    "Not getting enough value",
    "Just taking a break",
    "Other (please specify)",
  ];

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (_) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: StatefulBuilder(
        builder:
            (context, setState) => SizedBox(
          width: 350,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: const Text("Do you want to delete your profile ?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                const SizedBox(height: 16),

                // Yes / No buttons
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() => Navigator.of(context).pop());
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("No",style: TextStyle(color: Colors.black ,fontWeight: FontWeight.normal),),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => isYesSelected = true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(176, 0, 32, 1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                if (isYesSelected) ...[
                  const Text("We are sorry you are going. Please select your reason", style: TextStyle(fontSize: 15 ,fontWeight:
                  FontWeight.w500)),
                  const SizedBox(height: 10),

                  // Radio list with right-aligned radio and minimal spacing
                  ...reasons.map((reason) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(reason, style: const TextStyle(fontSize: 14)),
                        trailing: Radio<String>(
                          value: reason,
                          groupValue: selectedReason,
                          activeColor: AppColors.pharmacy_PrimaryColor,
                          onChanged: (val) => setState(() => selectedReason = val),
                        ),
                        onTap: () => setState(() => selectedReason = reason),
                      ),
                    );
                  }).toList(),

                  // Show TextField for "Other"
                  if (selectedReason == "Other (please specify)")
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        onChanged: (val) => otherReason = val,
                        decoration:  InputDecoration(

                          hintText: "Specify your reason (10 words)",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.6
                            )
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.pharmacy_PrimaryColor, foregroundColor: Colors.white),
                      onPressed: () {
                        if (selectedReason == "Other (please specify)" && otherReason.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your reason")));
                          return;
                        }

                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile deletion submitted")));

                        // TODO: Handle actual deletion here
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

