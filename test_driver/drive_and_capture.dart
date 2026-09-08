import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';

void main() async {
  print('Connecting to Flutter Driver...');
  final driver = await FlutterDriver.connect(
    dartVmServiceUrl: 'http://127.0.0.1:65419/EMXZf-WiWlA=/',
  );
  print('Connected!');

  const artifactDir = '/Users/Syed/.gemini/antigravity-ide/brain/30cf4c11-9557-49cf-a229-927fade70ffc';

  Future<void> capture(String name) async {
    await Future.delayed(const Duration(milliseconds: 800));
    Process.runSync('xcrun', [
      'simctl',
      'io',
      'booted',
      'screenshot',
      '$artifactDir/$name.png',
    ]);
    print('Captured $name.png');
  }

  // 1. Navigate to Goals
  print('1. Navigating to Goals...');
  await driver.tap(find.text('Goals'));
  await capture('01_goals_weekly');

  // 2. Switch to Monthly Goals
  print('2. Switching to Monthly Goals...');
  await driver.tap(find.text('Monthly Goals'));
  await capture('02_goals_monthly');

  // Switch back to Weekly Goals
  print('3. Switching back to Weekly Goals...');
  await driver.tap(find.text('Weekly Goals'));

  // 3. Navigate to Planner
  print('4. Navigating to Planner...');
  await driver.tap(find.text('Planner'));
  await capture('03_planner_today');

  // 4. Navigate to Home
  print('5. Navigating to Home...');
  await driver.tap(find.text('Home'));
  await capture('04_home_dashboard');

  await driver.close();
  print('Done!');
}
