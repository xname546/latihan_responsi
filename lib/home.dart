import 'package:flutter/material.dart';
import 'package:ltihan_responsi/Page/blog_page.dart';
import 'package:ltihan_responsi/Page/news_page.dart';
import 'package:ltihan_responsi/Page/report_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Space Flight News'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildListItem(
              context,
              'News',
              'Explore the latest space flight news and updates.',
              NewsPage(),
            ),
            _buildListItem(
              context,
              'Blog',
              'Read insightful blogs about space exploration.',
              BlogPage(),
            ),
            _buildListItem(
              context,
              'Report',
              'Access detailed reports on space missions and discoveries.',
              ReportPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
      BuildContext context,
      String title,
      String description,
      Widget page,
      ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => page),
        );
      },
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}
