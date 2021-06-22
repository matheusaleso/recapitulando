class StateModel {
  String state;
  String alias;
  List<String> lgas;

  StateModel({this.state, this.alias, this.lgas});

  StateModel.fromJson(Map<String, dynamic> json) {
    state = json['temporada'];
    lgas = json['episodios'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temporada'] = this.state;
    data['episodios'] = this.lgas;
    return data;
  }
}
