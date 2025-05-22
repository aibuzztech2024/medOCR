import 'package:avatar/models/auth/role_model.dart';
import 'package:avatar/views/auth/register/advertiser/advertiser_register_view.dart';
import 'package:avatar/views/auth/register/client/client_register_view.dart';
import 'package:avatar/views/auth/register/medical_provider/medical_provider_register_view.dart';
import 'package:avatar/views/auth/register/ngo/ngo_register_view.dart';
import 'package:avatar/views/auth/register/user/user_register_view.dart';
import 'package:get/get.dart';

/// A GetX controller responsible for handling the selection of user roles
/// during onboarding or registration.
///
/// This controller maintains a list of predefined roles and tracks
/// the index of the currently selected role.
class SelectRoleController extends GetxController {
  /// Predefined list of roles that the user can choose from.
  final roles = <Role>[
    // Customer
    Role(
      role: 'customer',
      title: 'I\'m a Customer',
      caption: 'I Want To Buy Medicine Or Use Health Services',
      page: UserRegisterView(),
    ),
    // Pharmacy
    Role(
      role: 'pharmacy',
      title: 'I\'m a Pharmacy',
      caption: 'I Want To Manage and Sell Medicines',
      page: MedicalProviderRegisterView(),
    ),
    // Client
    Role(
      role: 'client',
      title: 'I\'m a Client',
      caption: 'I Want To Register My Business On The Platform',
      page: ClientRegisterView(),
    ),
    // NGO
    Role(
      role: 'ngo',
      title: 'I\'m a NGO',
      caption: 'I Want To Register My NGO On The Platform',
      page: NgoRegisterView(),
    ),
    // Advertiser
    Role(
      role: 'advertiser',
      title: 'I\'m an Advertiser',
      caption: 'I Want To Advertise My Products Or Services',
      page: AdvertiserRegisterView(),
    ),
  ];

  /// Holds the index of the currently selected role.
  ///
  /// Defaults to -1, which means no role has been selected yet.
  final selectedRoleIndex = (-1).obs;

  /// Updates the selected role index when a user chooses a role.
  ///
  /// [index] should be a valid index of the `roles` list.
  void updateRole(int index) {
    selectedRoleIndex.value = index;
    Get.printInfo(info: 'selected role: ${roles[index].role}');
  }
}
