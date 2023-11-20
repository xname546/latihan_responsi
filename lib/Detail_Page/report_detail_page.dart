import 'package:flutter/material.dart';
import 'package:ltihan_responsi/Data_Model/report_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetailPage extends StatelessWidget {
  final Results reportModel;

  const ReportDetailPage({required this.reportModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                reportModel.imageUrl!,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                reportModel.title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(reportModel.publishedAt!),
              SizedBox(height: 10),
              Text(reportModel.summary!),
              SizedBox(height: 60,)
              // Tambahkan informasi lainnya sesuai kebutuhan
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchURL(reportModel.url!);
        },
        icon: Icon(Icons.link),
        label: Text('Website : ' +reportModel.newsSite!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
