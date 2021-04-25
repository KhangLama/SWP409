import 'package:flutter_test/flutter_test.dart';
import 'package:swp409/Models/user.dart';

void main() {
  testWidgets('Given text field is not empty', (tester) async {
    // TODO: Implement test
    final user = User(
        name: 'khang',
        phone: '0948397339',
        email: 'lamminhkhang123a@gmail.com',
        password: 'King0fGod.');
    expect(user.email, user.email.isNotEmpty);
    
  });
}
