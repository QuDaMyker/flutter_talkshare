part of 'supabase_service.dart';

extension Blogervice on SupabaseService {

  Future<String?> uploadImage(File image, String userId) async {
    var uuid = const Uuid();
    final fileName = uuid.v4() + basename(image.path);
    final filePath = '$userId/$fileName';
    final response = await supabase.storage.from('BlogImages').upload(filePath, image,);     

      final publicUrl = supabase.storage.from('BlogImages').getPublicUrl(filePath);
      return publicUrl;  
  }

  Future<void> saveBlog(Blog blog) async {
    final response = await supabase.from(Blog.table.tableName).insert(blog.toJson());    
  }

  Future<List<Blog>> getAllBlogs() async {

    final response = await supabase.from(Blog.table.tableName).select().order('created_at', ascending: false);

    List<Blog> blogs = [];
    if (response != null) {
      for (var json in response!) {       
        blogs.add(Blog.fromJson(json));
      }
    }
    return blogs;
  }
}
