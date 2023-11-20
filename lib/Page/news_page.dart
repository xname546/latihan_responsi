import 'package:flutter/material.dart';
import 'package:ltihan_responsi/Data_Model/news_model.dart';
import 'package:ltihan_responsi/Detail_Page/news_detail_page.dart';
import 'package:ltihan_responsi/api_data_source.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _PageListNewsState();
}

class _PageListNewsState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News List'),
      ),
      body: _buildListNewsBody(),
    );
  }

  Widget _buildListNewsBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadNews(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            NewsModel newsModel =
            NewsModel.fromJson(snapshot.data);
            return _buildSuccessSection(newsModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection(){
    return Text('gagal');
  }

  Widget _buildLoadingSection(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(NewsModel data){
    return ListView.builder(
        itemCount: data.results!.length,
        itemBuilder: (BuildContext context, int index){
          return _buildItemNews(data.results![index]);
        }
    );
  }

  Widget _buildItemNews(Results newsModel){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(newsModel: newsModel),
          ),
        );
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(newsModel.imageUrl!),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(newsModel.title!),
                Text(newsModel.publishedAt!),
              ],
            )
          ],
        ),
      ),
    );
  }
}
