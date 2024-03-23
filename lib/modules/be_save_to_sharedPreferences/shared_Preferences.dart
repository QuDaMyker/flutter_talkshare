// class SharedPreferences {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();

//   await prefs.setInt('counter', 10);
//   // Lưu giá trị boolean vào key 'repeat'
//   await prefs.setBool('repeat', true);
//   // Lưu 1 số thực vào key 'decimal'
//   await prefs.setDouble('decimal', 1.5);
//   // Lưu 1 chuỗi vào key 'action'
//   await prefs.setString('action', 'Start');
//   // Lưu 1 list String vào key 'items'
//   await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
// }