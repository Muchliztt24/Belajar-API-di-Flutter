import 'package:flutter/material.dart';
// import 'package:latihan_api/pages/post/detail_post_screen.dart';
import 'package:latihan_api/models/quran_model.dart';
import 'package:latihan_api/services/quran_service.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(ListQuranScreen());
}

class ListQuranScreen extends StatelessWidget {
  const ListQuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Fetch Data')),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 11, 207, 11),
          child: FutureBuilder<List<QuranModel>>(
            future: QuranService.listQuran(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final quran = snapshot.data ?? [];
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: quran.length,
                itemBuilder: (context, items) {
                  final data = quran[items];
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
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      elevation: 2,
                      child: ListTile(
                      leading: CircleAvatar(
                        child: Text(data.nomor.toString()),
                      ),
                      title: Text(data.nama),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Nama: ${data.nama}'),
                        Text('Asma: ${data.asma}'),
                        Text('Arti: ${data.arti}'),
                        Text('Tipe: ${data.type}'),
                        Text('Rukuk: ${data.rukuk}'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                          final url = data.audio;
                          if (url != null && url.isNotEmpty) {
                            if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                            }
                          }
                          },
                          child: Text('Dengarkan Audio'),
                        ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        Text('Ayat: ${data.ayat}'),
                        SizedBox(height: 4),
                        Text(
                          'Audio tersedia',
                          style: TextStyle(fontSize: 12),
                        ),
                        ],
                      ),
                      ),
                    )
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
