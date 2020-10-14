import 'package:flutter/material.dart';
import 'package:travel/dao/travel_tab_dao.dart';
import 'package:travel/model/travel_model.dart';
import 'package:travel/model/travel_tab_model.dart';
import 'package:travel/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      //fix tab label 空白问题
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 30),
          child: TabBar(
            controller: _controller,
            isScrollable: true,
            labelColor: Colors.black,
            labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Color(0xff1fcfbb), width: 3),
                insets: EdgeInsets.only(bottom: 10)),
            //设置tabbar 的标签显示内容，一般使用Tab对象,当然也可以是其他的Widget
            tabs: tabs.map<Tab>((TravelTab tab) {
              return Tab(
                text: tab.labelName,
              );
            }).toList(),
          ),
        ),
        Flexible(
          child: TabBarView(
            controller: _controller,
            children: tabs.map((TravelTab tab) {
              return TravelTabPage(
                travelUrl: travelTabModel.url,
                groupChannelCode: tab.groupChannelCode,
              );
            }).toList(),
          ),
        )
      ],
    ));
  }
}
