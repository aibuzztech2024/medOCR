import 'package:animate_do/animate_do.dart';
import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/models/auth/steps_model.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStepper extends StatelessWidget {
  final RxInt activeStep;
  final List<StepModel> steps;
  final List<Widget> content;
  const AppStepper({
    super.key,
    required this.activeStep,
    required this.steps,
    required this.content,
  })
    // Exception to be thrown if content length is not equal to steps length
    : assert(
         content.length == steps.length,
         'Steps and Content length must be equal',
       );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 100,
            child: EasyStepper(
              // Sets radius of step circles
              stepRadius: 25,

              // Sets padding between step and line
              internalPadding: 35,

              // Manages weather click event is allowed on steps or not
              enableStepTapping: true,

              // Show/Hide loading animation for active step
              showLoadingAnimation: false,

              // Duration of slide animation
              stepAnimationDuration: Durations.medium1,

              // INFO: For Active STep
              // Sets active step
              activeStep: activeStep.value,
              // Sets background color of active step
              activeStepBackgroundColor: context.theme.primaryColor,
              // Sets text color of active step
              activeStepTextColor: context.theme.primaryColor,
              // Sets icon color of active step
              activeStepIconColor: Colors.white,

              // INFO: For completed steps
              // Sets icon color of completed step
              finishedStepIconColor: context.theme.hintColor,
              // Sets background color of completed step
              finishedStepBackgroundColor: Colors.transparent,
              // Sets border color of completed step
              finishedStepBorderColor: context.theme.hintColor,
              // Sets text color of completed step
              finishedStepTextColor: context.theme.hintColor,

              // INFO: For incomplete steps
              // Sets icon color of incomplete steps
              unreachedStepIconColor: context.theme.hintColor,
              // Sets border color of incomplete steps
              unreachedStepBorderColor: context.theme.hintColor,

              steppingEnabled: false,

              // INFO: Update steps
              // Invoked on change of steps
              onStepReached: (index) => activeStep.value = index,

              // Sets divider line style
              lineStyle: LineStyle(
                // Line type
                lineType: LineType.normal,
                lineThickness: 1.5,
                // Color of line next to active step
                activeLineColor: context.theme.primaryColor,
                // color or incomplete steps line
                unreachedLineColor: context.theme.hintColor.withOpacity(.4),
              ),

              // Sets default border type
              defaultStepBorderType: BorderType.normal,

              // Generates steps
              steps: List.generate(steps.length, (index) {
                return EasyStep(
                  icon: steps[index].icon,
                  activeIcon: steps[index].icon,
                  title: steps[index].title,
                );
              }),
            ),
          ),
          HeightBox(20),
          // Active step content
          KeyedSubtree(
            // ensures rebuild on step change, so that content animation occurs each time step changes
            key: ValueKey(activeStep.value),
            // Animated content
            // Fade in and slide down animation
            // INFO: The animation extension is from [animate_do] package
            child: content[activeStep.value]
                .fadeIn(duration: Durations.medium2)
                .slideDown(duration: Durations.medium1),
          ),
        ],
      ),
    );
  }
}
