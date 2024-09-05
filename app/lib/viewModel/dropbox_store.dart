import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

part 'dropbox_store.g.dart';

class DropboxStore = _DropboxStore with _$DropboxStore;

abstract class _DropboxStore with Store {
  @observable
  ObservableList<String> dropboxFiles = ObservableList<String>();

  @action
  Future<void> fetchDropboxFiles() async {
    final url = Uri.parse('https://mobileapitest.incigsyuasa.com/api/utility/List?listname=SEYAHAT_TALEP_HARCAMA_TIPLERI');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      dropboxFiles.clear();
      for (var item in data) {
        dropboxFiles.add(item['listname']);
        print(item['listname']);
      }
    } else {
      throw Exception('Failed to load dropbox files');
    }
  }
}