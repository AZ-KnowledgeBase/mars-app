// models/setting_item.dart

// Model representing a single expandable section on the Info Screen
class SettingItem {
  final String title;           // "About this App", "Terms and Conditions", etc.
  final String content;         // Full text/content for each section
  bool isExpanded;              // Track if section is open/closed

  SettingItem({
    required this.title,
    required this.content,
    this.isExpanded = false,
  });
}