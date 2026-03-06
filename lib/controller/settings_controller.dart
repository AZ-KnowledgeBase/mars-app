// controller/settings_controller.dart
// Inspect and change accordingly 
import '../models/setting_item.dart';

class SettingsController {
  // All settings items with their content
  late List<SettingItem> settingItems;

  SettingsController() {
    _initializeSettings();
  }

  void _initializeSettings() {
    settingItems = [
      SettingItem(
        title: 'About this App',
        content: '''Mars App v1.0.0

Mars App is your gateway to exploring the Red Planet. Access real-time weather data, stunning satellite imagery, and interactive maps of Mars.

Technical Details:
• Built with Flutter & Dart
• API Integration: Mars Weather Service, NASA Image Library
• Platform: iOS & Android
• Minimum OS: iOS 11.0, Android 5.0
• Storage: ~150MB

Developer: AZ-KnowledgeBase
Last Updated: March 2026
''',
      ),
      SettingItem(
        title: 'Terms and Conditions',
        content: '''TERMS AND CONDITIONS
1. License to Use
You may download and use Mars Explorer App for personal, non-commercial, and educational purposes only. You may not modify, redistribute, or reverse-engineer the App.

2. Intellectual Property
The App's design, code, and features are owned by [Your Name] and protected under the Intellectual Property Act No. 36 of 2003 (Sri Lanka). Mars imagery is provided by NASA under public domain.
© 2026 Az. All rights reserved.

3. Accuracy of Materials
Mars data, forecasts, and imagery may contain errors or inaccuracies. This App is for educational purposes only. Do not rely on it for scientific research or mission-critical decisions. Verify important information from primary sources.

4. Governing Law
These Terms are governed by the laws of Sri Lanka, including:

Computer Crimes Act No. 24 of 2007
Intellectual Property Act No. 36 of 2003
Electronic Transactions Act No. 19 of 2006

Disputes are subject to the exclusive jurisdiction of courts in Colombo, Sri Lanka.

5. Acceptance
By using Mars Explorer App, you agree to these Terms and accept that:

The App is provided "as is" without warranties
Mars App is not liable for any damages from use
You will comply with Sri Lankan law

If you do not agree, do not use the App.
''',
      ),
      SettingItem(
        title: 'Support',
        content: '''SUPPORT & FEEDBACK

We're here to help! If you encounter any issues or have suggestions:

📧 Email: abisheikshakya@gmail.com

⚙️ Github: https://github.com/AZ-KnowledgeBase/mars-app/issues

💡 Feature Request: Share your ideas at abisheikshakya@gmail.com

COMMON ISSUES:

Q: App crashes on startup
A: Try clearing app cache in Settings > Apps > Mars App > Storage > Clear Cache

Q: Weather data not loading
A: Check your internet connection and ensure location services are enabled.

Q: Images not displaying
A: Verify you have sufficient storage space and a stable internet connection.

Q: Map is blank
A: Map tiles require internet connection. Check connectivity and try refreshing.

Version Info Available in "About this App" section
Support Response Time: 24-48 hours
''',
      ),
    ];
  }

  // Toggle expansion state of a setting item
  void toggleExpanded(int index) {
    if (index >= 0 && index < settingItems.length) {
      settingItems[index].isExpanded = !settingItems[index].isExpanded;
    }
  }

  // Get all settings items
  List<SettingItem> getSettings() => settingItems;

  // Get a specific setting by index
  SettingItem? getSetting(int index) {
    if (index >= 0 && index < settingItems.length) {
      return settingItems[index];
    }
    return null;
  }
}