import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:henri_sedjame/models/data.dart';
import 'package:henri_sedjame/presentation/notifiers/data-notifier.dart';

typedef WidgetBuilder = Widget Function(Data);

class DataBuilder extends StatefulWidget {

  final WidgetBuilder builder;

  const DataBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  State<DataBuilder> createState() => _DataBuilderState();
}

class _DataBuilderState extends State<DataBuilder> {

  late final DataNotifier dataNotifier;

  @override
  void initState() {
    super.initState();
    dataNotifier = GetIt.I<DataNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Data>(
        stream: dataNotifier.stream,
        initialData: dataNotifier.initialData,
        builder: (ctx, data) {
          if (data.hasData) {
            return widget.builder(data.data!);
          } else {
            return Container();
          }
        }
    );
  }
}
