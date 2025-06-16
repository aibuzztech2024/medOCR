import 'package:avatar/models/map/route_dragabble.dart';
import 'package:get/get.dart';

class RouteDraggableController extends GetxController {
  var selectedIndex = (-1).obs;

  final options =
      <RouteOption>[
        RouteOption(
          title: 'Via String Rd',
          description: 'Fastest route, the usual traffic',
          duration: '12 min',
          distance: '6.7 km',
        ),
        RouteOption(
          title: 'Via Street Rd',
          description: 'Fastest route, the usual traffic',
          duration: '12 min',
          distance: '6.7 km',
        ),
        RouteOption(
          title: 'Via String Rd',
          description: 'Fastest route, the usual traffic',
          duration: '12 min',
          distance: '6.7 km',
        ),
      ].obs;

  void selectIndex(int index) {
    selectedIndex.value = index;
    print('Container selected: ${options[index].title}');
  }
}
