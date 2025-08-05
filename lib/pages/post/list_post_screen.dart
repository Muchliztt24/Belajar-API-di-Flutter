import 'package:flutter/material.dart';
// import 'package:latihan_api/pages/post/detail_post_screen.dart';
import 'package:latihan_api/models/post_model.dart';
import 'package:latihan_api/services/post_service.dart';

void main() {
  runApp(ListPostScreen());
}

class ListPostScreen extends StatelessWidget {
  const ListPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Fetch Data')),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber,
          child: FutureBuilder<List<PostModel>>(
            future: PostService.listPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final albums = snapshot.data ?? [];
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: albums.length,
                itemBuilder: (context, items) {
                  final data = albums[items];
                  return GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (_) => PostDetailScreen(
                    //         id: data.id.toString(),
                    //         title: data.title,
                    //         userId: data.userId.toString(),
                    //       ),
                    //     ),
                    //   );
                    // },
                    child: ListTile(
                      leading: Text(data.id.toString()),
                      title: Text(data.title),
                      subtitle: Text('User ID: ${data.userId}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
