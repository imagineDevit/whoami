import 'dart:async';

import 'package:henri_sedjame/models/data.dart';


class DataNotifier {

  final StreamController<Data> _controller = StreamController<Data>.broadcast();

  Data initialData;

  DataNotifier(this.initialData) {
    _controller.add(initialData);
  }

  Stream<Data> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }

  void setData(Data data) {
    _controller.add(data);
  }
}