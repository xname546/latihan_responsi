import 'package:flutter/material.dart';
import 'package:ltihan_responsi/Data_Model/report_model.dart';
import 'package:ltihan_responsi/Detail_Page/report_detail_page.dart';
import 'package:ltihan_responsi/api_data_source.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report List'),
      ),
      body: _buildListReportBody(),
    );
  }

  Widget _buildListReportBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadReport(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            ReportModel newsModel =
            ReportModel.fromJson(snapshot.data);
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

  Widget _buildSuccessSection(ReportModel data){
    return ListView.builder(
        itemCount: data.results!.length,
        itemBuilder: (BuildContext context, int index){
          return _buildItemReport(data.results![index]);
        }
    );
  }

  Widget _buildItemReport(Results reportModel){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportDetailPage(reportModel: reportModel),
          ),
        );
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(reportModel.imageUrl!),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reportModel.title!),
                Text(reportModel.publishedAt!),
              ],
            )
          ],
        ),
      ),
    );
  }
}
