import 'package:flutter_test/flutter_test.dart';
import 'package:mars_explorer_app/models/user_model.dart';

void main() {
  group('UserModel', () {
    
    test('toMap() returns correct map with all fields', () {
      final user = UserModel(
        uid: 'abc123',
        email: 'test@mars.com',
        username: 'MarsExplorer',
      );

      final map = user.toMap();

      // Check every field is correctly mapped
      expect(map['uid'], 'abc123');
      expect(map['email'], 'test@mars.com');
      expect(map['username'], 'MarsExplorer');
    });

    test('toMap() returns a map with exactly 3 keys', () {
      final user = UserModel(
        uid: 'abc123',
        email: 'test@mars.com',
        username: 'MarsExplorer',
      );

      expect(user.toMap().length, 3);
    });

  });
}