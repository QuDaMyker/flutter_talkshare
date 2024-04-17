import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:get/get.dart';

class Book {
  final String imageUrl;
  final String title;
  final String type;
  final String author;
  final String description;
  final String snippet;

  Book ({
    required this.imageUrl, 
     required this.title, 
     required this.type,
     required this.author,
     this.description ='',
     this.snippet = '',
});
}

 List<Book> listBooks  = [
  Book(imageUrl: ImageAssets.imageBookPsychology, title: "Uncle Tom's cabin", type: 'Viễn tưởng', author: 'Herriet Beecher Stowe',
   description: """Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu
Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu""", 
snippet:  """Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu
Nguyên âm và phụ âm - Phần kiến thức quan trọng xuất hiện trong mọi kỳ thi Tiếng Anh - Bạn đã nắm được hết?
Hôm nay cô giới thiệu tới bạn trọn bộ Nguyên âm và Phụ âm cực kỳ đầy đủ trong Tiếng Anh. Lưu lại và học ngay bạn nhé! Lưu lại và học ngay bạn nhé! Lưu lại Lưu"""),
  Book(imageUrl: ImageAssets.imageBook1, title: 'Harry Potter và hòn đá phù thủy', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook2, title: 'Harry Potter và phòng chứa bí mật', type: 'Viễn tưởng',author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook3, title: 'Harry Potter và tù nhân nguc', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook4, title: 'Harry Potter và chiếc cốc lửa', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook5, title: 'Harry Potter và hoàng tử lai', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook6, title: 'Harry Potter và bảo bối tử thần', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook1, title: 'Harry Potter và hòn đá phù thủy', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook2, title: 'Harry Potter và phòng chứa bí mật', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook3, title: 'Harry Potter và tù nhân nguc', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook4, title: 'Harry Potter và chiếc cốc lửa', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook5, title: 'Harry Potter và hoàng tử lai', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook6, title: 'Harry Potter và bảo bối tử thần', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook1, title: 'Harry Potter và hòn đá phù thủy', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook2, title: 'Harry Potter và phòng chứa bí mật', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook3, title: 'Harry Potter và tù nhân nguc', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook4, title: 'Harry Potter và chiếc cốc lửa', type: 'Viễn tưởng', author: 'J. K. Rowling'),
  Book(imageUrl: ImageAssets.imageBook5, title: 'Harry Potter và hoàng tử lai', type: 'Viễn tưởng', author: 'J. K. Rowling'),
 ];
