import 'package:ble_test/application/scan/scan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanPage extends ConsumerWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesResult = ref.watch(bleScanProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Scan'),
      ),
      body: devicesResult.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: data[index].device.isConnected
                    ? const Icon(Icons.done)
                    : null,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].device.platformName,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(data[index].device.remoteId.toString()),
                  ],
                ),
                onTap: () async {
                  if (data[index].device.isConnected) {
                    await data[index].device.disconnect();
                    return;
                  }
                  await data[index].device.connect();
                },
              );
            },
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () async {
          await FlutterBluePlus.adapterState
              .where((val) => val == BluetoothAdapterState.on)
              .first;
          ref.read(bleScanProvider.notifier).startScan();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
