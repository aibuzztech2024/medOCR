import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/divider_with_text.dart';
import 'package:avatar/viewModels/auth/select_role_controller.dart';
import 'package:avatar/views/auth/login/login_view.dart';
import 'package:avatar/views/auth/widget/app_scaffold.dart';
import 'package:avatar/views/auth/widget/header_text.dart';
import 'package:avatar/views/auth/widget/hero_image.dart';
import 'package:avatar/views/auth/widget/selectable_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget is used to select the role of the user
/// It displays a list of roles and allows the user to select one
/// It also provides a button to log in
/// The [SelectRoleController] is used to manage the state of the selected role
/// The selected role is stored in the [SelectRoleController] with [selectedIndex]
/// The selected role can be accessed through (roles[selectedIndex].role)
class SelectRoleView extends StatelessWidget {
  const SelectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the SelectRoleController
    // This controller manages the state of the selected role
    final roleController = Get.put(SelectRoleController());
    // It uses [AppScaffold] for custom scaffoldBackground design
    return AppScaffold(
      showBackButton: false,
      // Wrapped with [SingleChildScrollView] to avoid overflow on small screen
      body: SingleChildScrollView(
        // It uses [SafeArea] to avoid system UI overlaps
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              // Aligns the content to the start of the main axis
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // It uses [HeroImage] for consistent image design across auth screen
                HeroImage(),
                // It uses [HeaderText] for consistent header across auth screen
                HeaderText(title: 'Choose Your Role'),

                // It uses [SelectableButton] for consistent button design across auth screen
                // It uses [List.generate] to create a list of selectable buttons
                // Each button corresponds to a role in the [roles] list
                // The [onTap] callback updates the selected role index in the controller
                // The [isSelected] property determines if the button is selected
                // The [title] and [caption] properties display the role title and caption
                // The [roleController.roles] list contains the available roles
                // The [roleController.selectedRoleIndex] is used to track the selected role index
                ...List.generate(
                  roleController.roles.length,
                  (index) => Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SelectableButton(
                        onTap: () {
                          roleController.updateRole(index);

                          /// Navigate to the specific registration screen as of selected role
                          var page = roleController.roles[index].page;
                          navigateTo(() => page);
                        },
                        isSelected:
                            index == roleController.selectedRoleIndex.value,
                        title: roleController.roles[index].title,
                        caption: roleController.roles[index].caption,
                      ),
                    ),
                  ),
                ),
                HeightBox(15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // It uses [DividerWithText] for consistent divider design across auth screen
                  // It displays a text "Or" in the middle of the divider
                  child: DividerWithText('Or'),
                ),
                HeightBox(25),
                // It uses [AppButton] of type [Outlined] for consistent button design
                // It uses [SizedBox] to make the button take the full width of the screen
                AppButton(
                  width: double.infinity,
                  type: ButtonType.outlined,
                  text: 'Log-in',
                  onPressed: () => navigateTo(() => const LoginView()),
                ),
                HeightBox(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
