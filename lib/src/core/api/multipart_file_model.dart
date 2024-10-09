class MultipartFileModel {
  ///
  MultipartFileModel({this.field, this.path});

  ///
  String? field;

  ///
  String? path;

  ///
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['field'] = field;
    data['path'] = path;
    return data;
  }
}
