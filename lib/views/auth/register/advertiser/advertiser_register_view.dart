import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/models/auth/steps_model.dart';
import 'package:avatar/views/auth/register/advertiser/advertiser_document.dart';
import 'package:avatar/views/auth/register/advertiser/advertiser_profile.dart';
import 'package:avatar/views/auth/register/advertiser/advertiser_security.dart';
import 'package:avatar/views/auth/register/basic_info.dart';
import 'package:avatar/views/auth/register/contact_person.dart';
import 'package:avatar/views/auth/select_role_view.dart';
import 'package:avatar/views/auth/widget/app_scaffold.dart';
import 'package:avatar/views/auth/widget/app_stepper.dart';
import 'package:avatar/views/auth/widget/header_text.dart';
import 'package:avatar/views/auth/widget/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var activeStep = 0.obs;

class AdvertiserRegisterView extends StatelessWidget {
  const AdvertiserRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    /// List of registration steps with their titles and icons
    var steps = <StepModel>[
      StepModel(title: 'Basic Info', icon: Icon(Icons.info_outlined)),
      StepModel(title: 'Profile', icon: Icon(Icons.assignment_outlined)),
      StepModel(title: 'Contact Person', icon: Icon(Icons.phone_in_talk)),
      StepModel(title: 'Documents', icon: Icon(Icons.credit_card)),
      StepModel(title: 'Security', icon: Icon(Icons.security)),
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

    return AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  title: 'Register As Advertiser',
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
                  AdvertiserProfile(onContinue: () => activeStep++),
                  // Step 3: Contact Person
                  ContactPerson(onContinue: () => activeStep++),
                  // Step 4: Documents
                  AdvertiserDocument(onContinue: () => activeStep++),
                  // Step 5: Security
                  AdvertiserSecurity(
                    onRegister: () {
                      // Reset activeStep
                      activeStep.value = 0;
                      // Navigate to the next screen after registration
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
