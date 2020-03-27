import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lazy Loading ListView',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LazyLoadingListViewPage(),
    );
  }
}

class LazyLoadingListViewPage extends StatefulWidget {
  @override
  _LazyLoadingListViewPageState createState() =>
      _LazyLoadingListViewPageState();
}

class _LazyLoadingListViewPageState extends State<LazyLoadingListViewPage> {
  List<String> _items;
  int _currentMaxLength = 10;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _items = List.generate(_currentMaxLength, (index) {
      return 'Items ${index + 1}';
    });

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreItems();
      }
    });
  }

  void _loadMoreItems() async {
    if (_currentMaxLength > 350) return;
    for (int i = _currentMaxLength; i < _currentMaxLength + 10; i++) {
      _items.add('Items ${i + 1}');
    }
    
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _currentMaxLength += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll to Load more!'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _currentMaxLength + 1,
        itemBuilder: (ctx, index) {
          if (index == _currentMaxLength) {
            return CupertinoActivityIndicator();
          }

          return ListTile(
            onTap: () {},
            title: Text(_items[index]),
            subtitle: Text('Subtitle ${index + 1}'),
            leading: CircleAvatar(),
          );
        },
      ),
    );
  }
}
