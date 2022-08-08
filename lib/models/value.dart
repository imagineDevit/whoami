
class Value<T> {
  late final T fr;
  late final T en;

  Value();

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value()
        ..fr = json["fr"]
        ..en = json["en"];
  }
}