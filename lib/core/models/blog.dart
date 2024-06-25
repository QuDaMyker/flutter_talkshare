import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_talkshare/core/values/supabase_table.dart';

class Blog {  
  final String blogId; 
  final String userId;
  final String created_at;
  //final List<String> images;
  final String content;
  const Blog({
    required this.blogId,
    required this.userId,
    required this.created_at,
    //required this.images,
    required this.content});

  
  static BlogSupabaseTable table = const BlogSupabaseTable();

  static Blog fromJson(Map<String, dynamic> json) => Blog(
        blogId: json[table.blogId] as String,
        userId: json[table.userId] as String,
        created_at: json[table.created_at] as String,
        //images: json[table.images] as List<String>,
        content: json[table.content] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.blogId: blogId,
        table.userId: userId,
        table.created_at: created_at,
        //table.images: images,
        table.content: content,
      };
}