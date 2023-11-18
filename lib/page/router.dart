import 'package:ble_test/page/device/device_page.dart';
import 'package:ble_test/page/home/home_page.dart';
import 'package:ble_test/page/scan/scan_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(routes: [
    GoRoute(path: HomePage.path, builder: (context, state) => const HomePage()),
    GoRoute(path: ScanPage.path, builder: (context, state) => const ScanPage()),
    GoRoute(path: DevicePage.path, builder: (context, state) => const DevicePage()),
  ]);
}
