<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Note

Get Country IP 🌍
A Flutter plugin to fetch the public IP address and location (country, region, city, etc.) of the user using background computation via compute, so the main UI thread remains responsive.

## 🧠 Overview
The get_country_ip package provides an easy and efficient way to fetch a device's public IP and look up its corresponding geolocation data such as country, city, region, ISP, and more. It's optimized with Dart isolates (compute) to avoid blocking the main thread.

## look this simple way

``` dart

import 'package:get_country_ip/get_country_ip.dart';

void fetchLocation() async {
  final ipService = GetCountryIp();
  final location = await ipService.getIPLocation();

  if (location != null) {
    print("Location Info: $location");
  } else {
    print("Failed to get location.");
  }
}


```

## Sample Output

{
  "status": "success",
  "country": "India",
  "countryCode": "IN",
  "region": "TN",
  "regionName": "Tamil Nadu",
  "city": "Chennai",
  "zip": "600006",
  "lat": 0.0895,
  "lon": 0.2739,
  "timezone": "Asia/Kolkata",
  "isp": "Bharti Airtel",
  "org": "Bharti Airtel Ltd.",
  "as": "Bharti Airtel Ltd.",
  "query": "1.1.1.1"
}


## 🔧 Installation
Add the dependency in your pubspec.yaml:

```

dependencies:
  get_country_ip: ^<latest_version>

```

## ⚙️ Internals
This package uses Dart's compute function to offload heavy network work from the main UI thread. This ensures your UI stays smooth and responsive.



## 📁 Project Structure

```

get_country_ip/
  example/
    lib/
      main.dart

```

## ✨ Features

✅ Get public IP address

✅ Lookup geolocation details using the IP

✅ Runs network logic in a background isolate using compute

✅ Lightweight and easy to integrate

✅ Ideal for geo-based customization, analytics, and debugging tools

## Getting started
This package uses Dart's compute() to perform background work, ensuring your app UI stays smooth and responsive even during network-heavy operations. It's designed to be plug-and-play for developers looking to:

*  Personalize content based on user location

*  Perform light IP-based analytics

*  Add geolocation-based logging or debugging

## 💡 Additional information
This package leverages background processing and external APIs to gather accurate data without slowing down the app. Whether you're building a feature-rich application or a lightweight utility, integrating IP geolocation using get_country_ip provides flexibility and performance.

The possibilities for customization and expansion are vast — from localization to IP-based analytics dashboards — all while maintaining clean architecture and responsive UI performance.