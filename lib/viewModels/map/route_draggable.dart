import 'package:avatar/models/map/route_draggable.dart';
import 'package:get/get.dart';

class RouteDraggableController extends GetxController {
  var selectedIndex = 0.obs;

  final options =
      <RouteOption>[
        RouteOption(
          title: 'Via String Rd',
          description: 'Fastest route, the usual traffic',
          duration: '12 min',
          distance: '6.7 km',
          creditpoint: '2.8',
        ),
        RouteOption(
          title: 'Via Street Rd',
          description: 'Fastest routes, the usual traffic',
          duration: '14 min',
          distance: '6.8 km',
          creditpoint: '2.5',
        ),
        RouteOption(
          title: 'Via Stream Rd',
          description: 'Fastest route, usual traffic',
          duration: '16 min',
          distance: '6.9 km',
          creditpoint: '2.1',
        ),
      ].obs;

  void selectIndex(int index) {
    selectedIndex.value = index;
    print('Container selected: ${options[index].title}');
  }
}
