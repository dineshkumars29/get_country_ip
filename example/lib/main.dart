import 'package:flutter/material.dart';
import 'package:get_country_ip/get_country_ip.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ipLocator = GetCountryIp();
  final locationData = await ipLocator.getIPLocation();

  runApp(MyApp(locationData: locationData));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? locationData;

  const MyApp({super.key, required this.locationData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get Country IP Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('IP & Location Info')),
        body: Center(
          child: locationData == null
              ? const Text('Failed to fetch location info.')
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(locationData.toString()),
                ),
        ),
      ),
    );
  }
}
