import 'package:avatar/views/ngo/settings/widgets/underLine_country_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../viewModels/ngo/setting_controller.dart';
import '../../enduser_phone_settings/widgets/country_code_picker.dart';

class AccountInfoScreen extends StatelessWidget {
  final controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            return AbsorbPointer(
              absorbing: controller.isLoading.value,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      const Text('Account Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 4),
                      const Text('Add your Personal Details'),
                      const SizedBox(height: 20),

                      const Text('Email Address'),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: controller.emailController,
                        validator: (value) => value == null || value.trim().isEmpty ? 'Email is required' : null,
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(),
                          errorBorder: UnderlineInputBorder(),
                          focusedErrorBorder: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Country Code'),

                              underLineCountryPicker(onSelect: controller.onCountryCodeSelected),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                const Text('Phone no.'),

                                TextFormField(
                                  controller: controller.phoneController,
                                  validator: (value) => value == null || value.trim().isEmpty ? 'Phone is required' : null,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: UnderlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(),
                                    errorBorder: UnderlineInputBorder(),
                                    focusedErrorBorder: UnderlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      const Text('Website URL'),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: controller.websiteController,
                        validator: (value) => value == null || value.trim().isEmpty ? 'Website is required' : null,
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(),
                          errorBorder: UnderlineInputBorder(),
                          focusedErrorBorder: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
