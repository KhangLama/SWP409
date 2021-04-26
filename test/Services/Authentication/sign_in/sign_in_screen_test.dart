import 'package:flutter_test/flutter_test.dart';
import 'package:swp409/Models/user.dart';

void main() {
  testWidgets('Given text field is not empty', (tester) async {
    final user = User(
        name: 'khang',
        phone: '0948397339',
        username: 'lamminhkhang123a@gmail.com',
        password: 'King0fGod.');
    expect(user.username, user.username.isNotEmpty);
  });
}
