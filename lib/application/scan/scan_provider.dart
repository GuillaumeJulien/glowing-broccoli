import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'scan_provider.g.dart';

@riverpod
class BleScan extends _$BleScan {
  @override
  Stream<List<ScanResult>> build() {
    return FlutterBluePlus.scanResults;
  }

  Future<void> startScan() async {
    await FlutterBluePlus.startScan();
  }

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }
}
