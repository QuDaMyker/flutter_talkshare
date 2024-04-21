import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_talkshare/core/values/supabase_table.dart';

class Blog {  
  final String blogId;
  final String userName;
  final String avatUrl;
  final DateTime time;
  final List<File> images;
  final String content;
  const Blog({
    required this.blogId,
    required this.userName,
    required this.avatUrl,
    required this.time,
    required this.images,
    required this.content});

  
  static BlogSupabaseTable table = const BlogSupabaseTable();

  static Blog fromJson(Map<String, dynamic> json) => Blog(
        blogId: json[table.blogId] as String,
        userName: json[table.userName] as String,
        avatUrl: json[table.avatUrl] as String,
        time: json[table.time] as DateTime,
        images: json[table.images] as List<File>,
        content: json[table.content] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.blogId: blogId,
        table.userName: userName,
        table.avatUrl: avatUrl,
        table.time: time,
        table.images: images,
        table.content: content,
      };
}