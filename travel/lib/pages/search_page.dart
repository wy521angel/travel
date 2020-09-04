import 'package:flutter/material.dart';
import 'package:travel/dao/search_dao.dart';
import 'package:travel/model/search_model.dart';
import 'package:travel/widget/search_bar.dart';
import 'package:travel/widget/webview.dart';

const URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key, this.hideLeft, this.searchUrl = URL, this.keyword, this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: searchModel?.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int position) {
                      return _item(position);
                    }),
              )),
        ],
      ),
    );
  }

  _onTextChange(String text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + text;
    SearchDao.fetch(url, text).then((SearchModel model) {
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  _appBar() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            //AppBar渐变遮罩背景
            colors: [Color(0X66000000), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  _item(int position) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: item.url,
                      title: '详情',
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 300,
                  child: Text(
                      '${item.word} ${item.districtname ?? ''} ${item.zonename ?? ''}'),
                ),
                Container(
                  width: 300,
                  child: Text('${item.price ?? ''} ${item.type ?? ''}}'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
