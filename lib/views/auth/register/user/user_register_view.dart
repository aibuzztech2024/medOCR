import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/models/auth/steps_model.dart';
import 'package:avatar/viewModels/auth/register/user/register_controller.dart';
import 'package:avatar/views/auth/register/basic_info.dart';
import 'package:avatar/views/auth/register/user/user_profile.dart';
import 'package:avatar/views/auth/register/user/user_security.dart';
import 'package:avatar/views/auth/select_role_view.dart';
import 'package:avatar/views/auth/widget/app_scaffold.dart';
import 'package:avatar/views/auth/widget/app_stepper.dart';
import 'package:avatar/views/auth/widget/header_text.dart';
import 'package:avatar/views/auth/widget/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The main view for user registration.
/// Contains a step-by-step form with animated UI and dynamic behavior.
class UserRegisterView extends StatefulWidget {
  const UserRegisterView({super.key});

  @override
  State<UserRegisterView> createState() => _UserRegisterViewState();
}

class _UserRegisterViewState extends State<UserRegisterView> {
  /// List of registration steps with their titles and icons
  var steps = <StepModel>[
    StepModel(title: 'Basic Info', icon: Icon(Icons.info_outlined)),
    StepModel(title: 'Profile', icon: Icon(Icons.assignment_outlined)),
    StepModel(title: 'Security', icon: Icon(Icons.security_outlined)),
  ];

  /// Returns dynamic subtitle based on the active step
  String getStepInfo(int index) {
    if (index == 0) {
      return 'Start By Verifying Your Contact Details';
    } else if (index < (steps.length - 1)) {
      return 'Almost There';
    } else {
      return 'Last Step';
    }
  }

  /// Initializes or retrieves the `RegisterController` using GetX
  var registerController =
      Get.isRegistered<RegisterController>()
          ? Get.find<RegisterController>()
          : Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Top animated image that adjusts height based on active step
              Obx(
                () => AnimatedContainer(
                  height:
                      registerController.activeStep.value == 1
                          ? context.height * 0.1
                          : context.height * 0.25,
                  duration: Durations.medium1,
                  child: HeroImage(),
                ),
              ),

              /// Header text that changes subtitle dynamically
              Obx(
                () => HeaderText(
                  title: 'Register As User',
                  subtitle: getStepInfo(registerController.activeStep.value),
                ),
              ),

              /// Custom stepper widget for displaying registration steps
              AppStepper(
                activeStep: registerController.activeStep,
                steps: steps,
                content: [
                  // Step 1: Basic Info form
                  BasicInfo(onContinue: () => registerController.activeStep++),
                  // Step 2: User Profile form
                  UserProfile(
                    onContinue: () => registerController.activeStep++,
                  ),
                  // Step 3: Security information form
                  UserSecurity(
                    // Reset back to first step after registration
                    // TODO: implement register logic here
                    // WARN: taking user back to home screen for now only
                    onRegister: () {
                      // Reset the active step to 0
                      registerController.activeStep.value = 0;
                      // Navigate to the SelectRoleView
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
