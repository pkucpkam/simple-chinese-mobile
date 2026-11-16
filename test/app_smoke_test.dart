import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chinese/app/app.dart';
import 'package:simple_chinese/data/db/app_database.dart';
import 'package:simple_chinese/data/providers.dart';

/// Cho I/O thật (asset, SQLite) chạy rồi vẽ lại khung hình. Không dùng
/// pumpAndSettle vì query drift chỉ hoàn tất ngoài fake-async.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('mở app → import nội dung → mở Chi tiết từ', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: const SimpleChineseApp(),
    ));

    // Import chạy trên asset thật (rootBundle) → chờ xong.
    await settle(tester);

    // Tab Học: lộ trình, bài 1 mở (hiện tên), bài 2 khoá.
    expect(find.text('Lộ trình HSK 1'), findsOneWidget);
    expect(find.text('Xin chào'), findsOneWidget);
    expect(find.byIcon(Icons.lock_rounded), findsWidgets);

    // Tab Tra cứu → mở Chi tiết từ.
    await tester.tap(find.text('Tra cứu'));
    await settle(tester);
    await tester.tap(find.text('你').first);
    await settle(tester);

    expect(find.text('NHĨ'), findsOneWidget);
    expect(find.textContaining('ngôi thứ hai'), findsWidgets);

    // Đóng DB và dọn timer của stream query trước khi test kết thúc.
    await tester.pumpWidget(const SizedBox());
    // db.close() dùng timer của fake-async → bơm thời gian cho nó hoàn tất.
    final closing = db.close();
    await tester.pump(const Duration(seconds: 1));
    await closing;
  }, timeout: const Timeout(Duration(minutes: 1)));
}
