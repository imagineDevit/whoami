
const _name = "name";
const _title = "title";
const _description = "description";

class Me {
  static const delimiter = "<>";

  late final String name;
  late final String title;
  late final String description;

  Me(this.name,  this.title, this.description,);

  factory Me.fromJson(Map<String, dynamic> json) {
    return Me(
      json[_name],
      json[_title],
      json[_description],
    );
  }

  List<String> descriptionLines() {
    return description.split(delimiter).map((e) => e.trim()).toList();
  }

}