class Model {
  String? version;
  bool? success;
  List<Result>? result;

  Model({this.version, this.success, this.result});

  Model.fromJson(Map<String, dynamic> json) {
    version = json['Version'];
    success = json['Success'];
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Version'] = this.version;
    data['Success'] = this.success;
    if (this.result != null) {
      data['Result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? key1;

  Result({this.key1});

  Result.fromJson(Map<String, dynamic> json) {
    key1 = json['Key1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key1'] = this.key1;
    return data;
  }
}


// class ParaBirimiModel {
//   String? version;
//   bool? success;
//   List<Result>? result;

//   ParaBirimiModel({this.version, this.success, this.result});

//   ParaBirimiModel.fromJson(Map<String, dynamic> json) {
//     version = json['Version'];
//     success = json['Success'];
//     if (json['ResultBirim'] != null) {
//       result = <Result>[];
//       json['ResultBirim'].forEach((v) {
//         result!.add(new Result.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Version'] = this.version;
//     data['Success'] = this.success;
//     if (this.result != null) {
//       data['ResultBirim'] = this.result!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ResultBirim {
//   String? key1;

//   Result({this.key1});

//   Result.fromJson(Map<String, dynamic> json) {
//     key1 = json['Key1'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Key1'] = this.key1;
//     return data;
//   }
// }

