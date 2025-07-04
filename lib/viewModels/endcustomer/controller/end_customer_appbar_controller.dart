import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/views/endcustomer/profile/profile_screen.dart';
import 'package:avatar/views/pharmacy_app/share/my_cart_view.dart';
import 'package:get/get.dart';

/// Controller for managing the state of the custom app bar.
/// This includes user info, location, weather, notifications, and profile image.
class EndCustomerAppbarController extends GetxController {
  // ----------------- Observable Variables -----------------

  /// The user's name - to be fetched from backend or local DB
  final RxString userName = 'Monika'.obs;

  /// The current formatted date (e.g., "It is Mon, 9 Jun 2025")
  final RxString currentDate = ''.obs;

  /// The user's location - ideally fetched via device or profile
  final RxString location = 'Delhi, India'.obs;

  /// The weather at the user's location - fetched from weather API
  final RxString weather = 'Sunny 32°'.obs;

  /// Notification count - fetched from backend
  final RxInt notificationCount = 0.obs;

  /// Path to profile image - can be network or asset image
  final RxString profileImagePath = 'assets/images/profile_girl.jpg'.obs;

  // ----------------- Lifecycle Hook -----------------

  @override
  void onInit() {
    super.onInit();
    _updateCurrentDate();

    // ✅ TODO: Fetch user profile from backend/local DB and update observables
    // fetchUserProfile();

    // ✅ TODO: Get location and weather using device permission + APIs
    // fetchLocationAndWeather();

    // ✅ TODO: Fetch notification count from server
    // fetchNotificationCount();
  }

  // ----------------- Date Formatter -----------------

  /// Updates [currentDate] with formatted string
  void _updateCurrentDate() {
    final now = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final dayName = days[now.weekday - 1];
    final day = now.day;
    final month = months[now.month - 1];
    final year = now.year;

    currentDate.value = 'It is $dayName, $day $month $year';
  }

  // ----------------- User Interactions -----------------

  /// Triggered when cart icon is tapped
  void onCartTapped() {
    // ✅ TODO: Navigate to Cart screen
    navigateTo(() => MyCartView());
    print('Cart tapped');
  }

  /// Triggered when refresh (notification) icon is tapped
  void onNotificationTapped() {
    // ✅ TODO: Refresh notifications list or navigate to notifications screen
    Get.snackbar(
      'Notifications',
      'Refreshing notifications...',
      snackPosition: SnackPosition.TOP,
    );
    print('Refresh tapped');
  }

  /// Triggered when profile avatar is tapped
  void onProfileTapped() {
    // ✅ TODO: Navigate to Profile screen or show bottom sheet
    // Navigate to the SelectRoleView
    navigateTo(() => const ProfileScreen());
    print('Profile tapped');
  }

  // ----------------- Backend TODO methods -----------------

  /// Fetch user profile from backend and update observables
  ///
  /// ✅ TODO: Implement API integration and replace placeholders
  /*
  Future<void> fetchUserProfile() async {
    final profile = await ApiService.getProfile();
    userName.value = profile.name;
    profileImagePath.value = profile.imageUrl;
    location.value = profile.location;
  }
  */

  /// Fetch current location using geolocation and get weather from API
  ///
  /// ✅ TODO: Integrate location and weather APIs
  /*
  Future<void> fetchLocationAndWeather() async {
    final loc = await LocationService.getCurrentLocation();
    final weatherInfo = await WeatherService.getWeather(loc);
    location.value = loc.city;
    weather.value = '${weatherInfo.condition} ${weatherInfo.temperature}°';
  }
  */

  /// Fetch notification count from backend
  ///
  /// ✅ TODO: Call backend API to get unseen notifications count
  /*
  Future<void> fetchNotificationCount() async {
    final count = await NotificationService.getUnseenCount();
    notificationCount.value = count;
  }
  */
}
