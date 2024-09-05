import 'package:app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class TarihOlusturmaBirimi extends StatefulWidget {
  @override
  _TarihOlusturmaBirimiState createState() => _TarihOlusturmaBirimiState();
}

class _TarihOlusturmaBirimiState extends State<TarihOlusturmaBirimi> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dropboxController1 = TextEditingController();
  final TextEditingController _dropboxController2 = TextEditingController();
  final TextEditingController _dropboxController3 = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String? _selectedDropboxFile1;
  String? _selectedDropboxFile2;
  String? _selectedDropboxFile3;

  // final baseUrl = 'https://mobileapitest.incigsyuasa.com/api/utility/List?listname= $listName';

  final List<String> _dropboxFiles = [];

  final List<String> _dropboxFiles2 = [
    'Lokasyon 1',
    'Lokasyon 2',
    'Lokasyon 3',
    'Lokasyon 4',
  ];

  final List<String> _dropboxFiles3 = [
    'Kategori 1',
    'Kategori 2',
    'Kategori 3',
    'Kategori 4',
  ];

  final List<String> _selectedFiles = [];
  final List<String> _selectedFiles2 = [];
  final List<String> _selectedFiles3 = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${_selectedDate!.toLocal()}'.split(' ')[0];
      });
    }
  }

  var token =
      "2GWpvJI7ZWDqpUiIQ2LUJbkIzQBTMSgXv_1ODGkWiArS8w2g-P9tIV8tPvO-IVt65IBXP7OuZdvyrwN2WfsqNgs5NMBn_88_TzG8sTz0SpzZ0F85K4ds6RmfgLwWFIdzaoNqIX0kr3lsDmq1mE5M2T-cIP1Pmi8txWeZZCzLDKJhP-5EaF5ejx3CT-e5Q-4JPct38k5zDT-_kT9S3xVifQQ45XXxo_l-ZQF_Ip5nKiig0NLSrs9K3N82LVhDlU3e1IgpVn_1jG2isyeSI9z9u6j6Vj8O_907ovY2fK4WGxDLhjKaosncrIVMwM71hypFvtUufM4ZD7p55ONSUNNaZ5m-pveRiLB-CmrQ5tcN_JuTuZxkmFgy3vwGqGQqkjSv4UA_ojtZEdYkwMsN0rETwHdG1XOHdrxJQSNXBa-orvf0IeqZFbuYoUmOnZ0qBswSdJeVPkOTAkIwT_X0BnkrAf6Vd346aHVatARQD0UatSRCM72Gyk0wJSOR4CZmLI0wJ9_npUDda5HOuxXPd54gomiRW_L69e57iOx3jNGgJm0U0jsz6J4X_whXwGq70FaUt3r8ldgwPIUqUEiHzpcvZ0MXiIQF3xZc-An1hM7RtLsI0fqk4_hIR_JUkp9MnggbVHJsp5nINJIbJJ__HbiQNF7YDDSuwlKsmUFkE71iQYA";

  Future<void> fetchDropboxFiles() async {
    // url
    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();

    final url =
        'https://mobileapitest.incigsyuasa.com/api/utility/List?listname=SEYAHAT_TALEP_HARCAMA_TIPLERI';

    var response = await dio.request(url,
        options: Options(
          method: 'GET',
          headers: headers,
        ));

    if (response.statusCode == 200) {
      var data = Model.fromJson(response.data);
      //  List<dynamic> data = jsonDecode(response.body);
      data.result!.forEach((element) {
        _dropboxFiles.add(element.key1!);
      });
    } else {
      // debugger();
      throw Exception('Failed to load dropbox files');
    }
  }

  void _selectDropboxFile(BuildContext context, int dropboxIndex) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: dropboxIndex == 1
              ? _dropboxFiles.length
              : dropboxIndex == 2
                  ? _dropboxFiles2.length
                  : _dropboxFiles3.length,
          itemBuilder: (context, index) {
            final item = dropboxIndex == 1
                ? _dropboxFiles[index]
                : dropboxIndex == 2
                    ? _dropboxFiles2[index]
                    : _dropboxFiles3[index];
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  if (dropboxIndex == 1) {
                    _selectedDropboxFile1 = item;
                    _dropboxController1.text = _selectedDropboxFile1!;
                    _selectedFiles.add(_selectedDropboxFile1!);
                  } else if (dropboxIndex == 2) {
                    _selectedDropboxFile2 = item;
                    _dropboxController2.text = _selectedDropboxFile2!;
                    _selectedFiles2.add(_selectedDropboxFile2!);
                  } else if (dropboxIndex == 3) {
                    _selectedDropboxFile3 = item;
                    _dropboxController3.text = _selectedDropboxFile3!;
                    _selectedFiles3.add(_selectedDropboxFile3!);
                  }
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  List<DropdownMenuItem<String>> dropdownItems = [];

  @override
  Widget build(BuildContext context) {
    dropdownItems = List.generate(_dropboxFiles.length, (index) {
      return DropdownMenuItem(
        child: Text(_dropboxFiles[index]),
        value: _dropboxFiles[index],
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Hesap Sayfası'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Harcama Tarihi',
                  hintText: 'Tarih seçmek için tıklayın',
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              _selectedDate == null
                  ? 'Tarih seçilmedi'
                  : 'Seçilen Tarih: ${_selectedDate!.toLocal()}'.split(' ')[0],
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField(
                  items: dropdownItems,
                  onChanged: (value) {
                    // setState(() {
                    //   _selectedDropboxFile1 = value;
                    //   _dropboxController1.text = _selectedDropboxFile1!;
                    //   _selectedFiles.add(_selectedDropboxFile1!);
                    // });
                  }),
              // child: TextField(
              //   controller: _dropboxController1,
              //   decoration: InputDecoration(
              //     labelText: 'Harcama Tipi 1',
              //     hintText: 'Harcama Tipi 1 seçmek için tıklayın',
              //   ),
              //   readOnly: true,
              //   onTap: () async {
              //     setState(() {
              //       fetchDropboxFiles();
              //       _selectDropboxFile(context, 1);
              //     });
              //   },
              // ),
            ),
            SizedBox(height: 10.0),
            Text(
              _selectedDropboxFile1 == null
                  ? 'Dosya seçilmedi'
                  : 'Seçilen Dosya: $_selectedDropboxFile1',
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _dropboxController2,
                decoration: InputDecoration(
                  labelText: 'Harcama Lokasyonu',
                  hintText: 'Harcama Lokasyonu seçmek için tıklayın',
                ),
                readOnly: true,
                onTap: () => _selectDropboxFile(context, 2),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              _selectedDropboxFile2 == null
                  ? 'Lokasyon seçilmedi'
                  : 'Seçilen Lokasyon: $_selectedDropboxFile2',
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Harcama Miktarı',
                  hintText: 'Miktar girin',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _dropboxController3,
                decoration: InputDecoration(
                  labelText: 'Harcama Kategorisi',
                  hintText: 'Harcama Kategorisi seçmek için tıklayın',
                ),
                readOnly: true,
                onTap: () => _selectDropboxFile(context, 3),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              _selectedDropboxFile3 == null
                  ? 'Kategori seçilmedi'
                  : 'Seçilen Kategori: $_selectedDropboxFile3',
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Harcama Açıklaması',
                  hintText: 'Açıklama girin',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: _selectedFiles.length +
                    _selectedFiles2.length +
                    _selectedFiles3.length,
                itemBuilder: (context, index) {
                  final item = index < _selectedFiles.length
                      ? _selectedFiles[index]
                      : index < _selectedFiles.length + _selectedFiles2.length
                          ? _selectedFiles2[index - _selectedFiles.length]
                          : _selectedFiles3[index -
                              _selectedFiles.length -
                              _selectedFiles2.length];
                  return ListTile(
                    title: Text(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: TarihOlusturmaBirimi(),
    ));
