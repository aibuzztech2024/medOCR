import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/models/auth/steps_model.dart';
import 'package:avatar/services/auth/api_service.dart';
import 'package:avatar/viewModels/auth/register/contact_controller.dart';
import 'package:avatar/viewModels/auth/register/user/register_controller.dart';
import 'package:avatar/views/auth/register/basic_info.dart';
import 'package:avatar/views/auth/register/client/client_documents.dart';
import 'package:avatar/views/auth/register/client/client_profile.dart';
import 'package:avatar/views/auth/register/client/client_security.dart';
import 'package:avatar/views/auth/register/contact_person.dart';
import 'package:avatar/views/auth/select_role_view.dart';
import 'package:avatar/views/auth/widget/app_scaffold.dart';
import 'package:avatar/views/auth/widget/app_stepper.dart';
import 'package:avatar/views/auth/widget/header_text.dart';
import 'package:avatar/views/auth/widget/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var activeStep = 0.obs;

class ClientRegisterView extends StatelessWidget {
  const ClientRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(RegisterController(), permanent: false);
    final _ = Get.put(ContactController(), permanent: false);
    // List of registration steps with their titles and icons
    var steps = <StepModel>[
      StepModel(title: 'Basic Info', icon: Icon(Icons.info_outlined)),
      StepModel(title: 'Profile', icon: Icon(Icons.assignment_outlined)),
      StepModel(title: 'Contact Person', icon: Icon(Icons.phone_in_talk)),
      StepModel(title: 'Documents', icon: Icon(Icons.credit_card)),
      StepModel(title: 'Security', icon: Icon(Icons.security)),
    ];

    // Returns dynamic subtitle based on the active step
    String getStepInfo(int index) {
      if (index == 0) {
        return 'Start By Verifying Your Contact Details';
      } else if (index < (steps.length - 1)) {
        return 'Almost There';
      } else {
        return 'Last Step';
      }
    }

    return AppScaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Obx(
                () => AnimatedContainer(
                  duration: Durations.medium1,
                  height:
                      activeStep.value == 0 ||
                              activeStep.value == steps.length - 1
                          ? context.height * 0.25
                          : context.height * 0.1,
                  child: HeroImage(),
                ),
              ),
              Obx(
                () => HeaderText(
                  title: 'Register As Client',
                  subtitle: getStepInfo(activeStep.value),
                ),
              ),
              AppStepper(
                activeStep: activeStep,
                steps: steps,
                content: [
                  // Step 1: Basic info
                  BasicInfo(onContinue: () => activeStep++),
                  // Step 2: Profile
                  ClientProfile(onContinue: () => activeStep++),
                  // Step 3: Contact Person
                  ContactPerson(onContinue: () => activeStep++),
                  // Step 4: Documents
                  ClientDocuments(onContinue: () => activeStep++),
                  // Step 5: Security
                  ClientSecurity(
                    onRegister: () async {
                      // Show loading dialog
                      Get.dialog(
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('Testing API...'),
                                SizedBox(height: 8),
                                Text(
                                  'Making registration call',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        barrierDismissible: false,
                      );

                      // Test the API call
                      await ClientApiService.testClientRegistration();

                      // Close loading dialog
                      Get.back();

                      // Wait a moment for user to see the result
                      await Future.delayed(Duration(seconds: 2));

                      // Reset activeStep and navigate
                      activeStep.value = 0;
                      navigateTo(() => const SelectRoleView());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
