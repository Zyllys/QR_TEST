class StationsData {
  List<Data>? data;


  StationsData({this.data});

  StationsData.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    // permission = json['permission'] != null
    //     ? Permission.fromJson(json['permission'])
    //     : null;
    // token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    // if (permission != null) {
    //   data['permission'] = permission!.toJson();
    // }
    // data['token'] = token;
    return data;
  }
}

class Data {
  String? recid;
  int? category;
  String? name;
  String? lat;
  String? lon;
  String? tablename;
  int? status;
  String? createdby;
  String? creaateddate;
  String? modifiedby;
  String? modifieddate;
  int? subcategory;

  Data(
      {this.recid,
      this.category,
      this.name,
      this.lat,
      this.lon,
      this.tablename,
      this.status,
      this.createdby,
      this.creaateddate,
      this.modifiedby,
      this.modifieddate,
      this.subcategory});

  Data.fromJson(Map<String, dynamic> json) {
    recid = json['recid'];
    category = json['category'];
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    tablename = json['tablename'];
    status = json['status'];
    createdby = json['createdby'];
    creaateddate = json['creaateddate'];
    modifiedby = json['modifiedby'];
    modifieddate = json['modifieddate'];
    subcategory = json['subcategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recid'] = recid;
    data['category'] = category;
    data['name'] = name;
    data['lat'] = lat;
    data['lon'] = lon;
    data['tablename'] = tablename;
    data['status'] = status;
    data['createdby'] = createdby;
    data['creaateddate'] = creaateddate;
    data['modifiedby'] = modifiedby;
    data['modifieddate'] = modifieddate;
    data['subcategory'] = subcategory;
    return data;
  }
}

class Permission {
  bool? access;
  bool? create;
  bool? update;
  bool? delete;

  Permission({this.access, this.create, this.update, this.delete});

  Permission.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    create = json['create'];
    update = json['update'];
    delete = json['delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['create'] = create;
    data['update'] = update;
    data['delete'] = delete;
    return data;
  }
}
