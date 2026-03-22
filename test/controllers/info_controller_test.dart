import 'package:flutter_test/flutter_test.dart';
import 'package:mars_explorer_app/controller/info_controller.dart';

void main() {
  group('SettingsController', () {

    late InfoController controller;

    // Runs before each test — gives every test a fresh controller
    setUp(() {
      controller = InfoController();
    });

    test('loads 3 settings items on initialization', () {
      expect(controller.getSettings().length, 3);
    });

    test('all items start collapsed', () {
      for (final item in controller.getSettings()) {
        expect(item.isExpanded, false);
      }
    });

    test('toggleExpanded() expands a collapsed item', () {
      controller.toggleExpanded(0);
      expect(controller.settingItems[0].isExpanded, true);
    });

    test('toggleExpanded() collapses an already expanded item', () {
      controller.toggleExpanded(0); // Expand
      controller.toggleExpanded(0); // Collapse
      expect(controller.settingItems[0].isExpanded, false);
    });

    test('toggleExpanded() only affects the targeted index', () {
      controller.toggleExpanded(1);
      expect(controller.settingItems[0].isExpanded, false); // Untouched
      expect(controller.settingItems[1].isExpanded, true);  // Toggled
      expect(controller.settingItems[2].isExpanded, false); // Untouched
    });

    test('getSetting() returns correct item by index', () {
      final item = controller.getSetting(0);
      expect(item?.title, 'About this App');
    });

    test('getSetting() returns null for out of bounds index', () {
      expect(controller.getSetting(99), null);
    });

    test('getSetting() returns null for negative index', () {
      expect(controller.getSetting(-1), null);
    });

  });
}