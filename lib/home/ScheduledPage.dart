import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/LiveProfileModel.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:side_header_list_view/side_header_list_view.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';



class ScheduledPage extends StatefulWidget {

  final String title;
  final List<StationData> stationsDatas;
  ScheduledPage({Key key, this.title, this.stationsDatas}) : super(key: key);

  @override
  _ScheduledPageState createState() => new _ScheduledPageState(title, stationsDatas);
}

class _ScheduledPageState extends State<ScheduledPage> {
  _ScheduledPageState(this._title, this._stationDatas);

  final String _title;
  List<StationData> _stationDatas;
  List<String> _startTimeHeaders;
  List<Data> _programDatas;
  LiveProfileModel _liveProfileModel = new LiveProfileModel();

  @override
  void initState() {
    super.initState();
    _startTimeHeaders = <String>[];
    _programDatas = _liveProfileModel.getScheduleDataByCallLetter(_stationDatas.map((data) => data.shortDesc).toList());
    _programDatas.forEach((value) {
      String start = value.start;
      if (!_startTimeHeaders.contains(start))
        _startTimeHeaders.add(start);
    });
  }

  void onUpdateView(List<StationData> stationDatas) {
    setState(() {
      _stationDatas = stationDatas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SideHeaderListView(
        itemCount: _programDatas.length,
        padding: new EdgeInsets.all(16.0),
        itemExtend: 116.0,
        headerBuilder: (BuildContext context, int index) {
          return new SizedBox(width: 100.0,child: new Text(_programDatas[index].start, style: Theme.of(context).textTheme.headline,));
        },
        itemBuilder: (BuildContext context, int index) {
          return new Text(_programDatas[index].name, style: Theme.of(context).textTheme.headline,);
        },
        hasSameHeader: (int a, int b) {
          return _programDatas[a].start == _programDatas[b].start;
        },
      ),
    );
  }
}
