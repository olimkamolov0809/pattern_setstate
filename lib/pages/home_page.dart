import 'package:flutter/material.dart';
import 'package:pattern_setstate/model/post_model.dart';
import 'package:pattern_setstate/services/http_services.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading = false;
  List<Post> items = [];

  void _apiPostList() async{
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    setState(() {
      if(response != null){
        items = Network.parsePostList(response);
      }else{
        items = [];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("setState"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index){
              return itemsOfPost(items[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget itemsOfPost(Post post){
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Column(
        children: [
          Text(post.title.toUpperCase()),
          SizedBox(height: 5),
          Text(post.body.toUpperCase()),
        ],
      ),
    );
  }
}
