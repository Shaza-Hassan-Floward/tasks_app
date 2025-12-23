import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../../core/native/device_info_service.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceService = DeviceInfoService();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔋 Native info
            FutureBuilder<String>(
              future: deviceService.getBatteryStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    leading: Icon(Icons.battery_unknown),
                    title: Text('Battery Level'),
                    trailing: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data == -1) {
                  return const ListTile(
                    leading: Icon(Icons.battery_alert),
                    title: Text('Battery Level'),
                    trailing: Text('Unavailable'),
                  );
                }

                return ListTile(
                  leading: const Icon(Icons.battery_full),
                  title: const Text('Battery Level'),
                  trailing: Text('${snapshot.data}'),
                );
              },
            ),

            const Divider(height: 32),

            const Spacer(),

            // 🚪 Logout
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}