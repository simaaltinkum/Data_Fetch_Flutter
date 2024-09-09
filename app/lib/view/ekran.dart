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

  List<String> _dropboxFiles = [];

  List<String> _dropboxFiles2 = [];

  List<String> _dropboxFiles3 = [];

  List<DropdownMenuItem<String>> dropdownItems = [];

  List<DropdownMenuItem<String>> dropdownItems3 = [];

  // final List<String> _selectedFiles = [];
  // final List<String> _selectedFiles2 = [];
  // final List<String> _selectedFiles3 = [];

  @override
  void initState() {
    super.initState();
    fetchDropboxFiles();
    fetchDropboxFiles3();
  }

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
      "jZRPBUpsAek3t0OJYpsuGHNMDpol1Jq2JMXL_0ec2_nKsIrB552Y1lGCCqSK20g0xEI4PWujTq96rmBrvgQU9VUL14LdWQmJY3Z39mcSsPDEY05q9DT-8ifYi8kO7WOIsDO5dPTexXWj7WvlKOX26dYhZfDFeIVIvjG_peJ882DamcgqBPkXsruhtF21MzBs75OMJKvekGg0Fi_-cF3DbrZ8gRRB36LWaa28tlGVKtHYdv6CXdmkobPJFOumzpB1ExWrj3Y5Fkel59b8Gq9ykHYpKRZeBbKTGd7FUmtuSyES-s9bEYg0hou2BopkSU69Hj8nkyI00OztY4iJm3BqdQei2EfuESfs_pDT_G4l1pMwUuukpFHBPqFQV1uR7NmenwbktCdkadiP4U2wKLWl2AnxXUAF4BfN94fMdotEmBUDt0SPhCq4pMZg_ooClaEnIm6CpaaiwE_J5joXGcgLsrXvPTxaqVZWu7n1g5z5Abr5ATUAZjuXT1yI5X0mA-IvV5RZGQqrlH_tro3Im3Ai6lxNahemAs7Fem2HeDok3MfmakFEEEL3ao-8L74BNXUeXShs3rS6WGP_QRVAoK_rnvO_cLgQOXOrLMndlNtKb4_yYRPKMNML0SQf1SwDcpxIEAKEk-kJDao7sRH4eXBiYmW5C-Hu7u7y982tvMMqfXY";

  

  Future<void> fetchDropboxFiles() async {
    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();

    final url =
        'https://mobileapitest.incigsyuasa.com/api/utility/List?listname=SEYAHAT_TALEP_HARCAMA_TIPLERI';

    try {
      var response = await dio.request(url,
          options: Options(
            method: 'GET',
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = Model.fromJson(response.data);
        setState(() {
          _dropboxFiles = data.result!.map((e) => e.key1!).toList();
          dropdownItems = List.generate(_dropboxFiles.length, (index) {
            return DropdownMenuItem(
              child: Text(_dropboxFiles[index]),
              value: _dropboxFiles[index],
            );
          });
        });
      } else {
        print('Failed to load dropbox files: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.message}');
        if (e.response != null) {
          print('Response data: ${e.response?.data}');
          print('Response headers: ${e.response?.headers}');
          print('Response request: ${e.response?.requestOptions}');
        }
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> fetchDropboxFiles3() async {
    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();

    final url =
        'https://mobileapitest.incigsyuasa.com/api/utility/List?listname=GENEL_PARA_BIRIMI';

    try {
      var response = await dio.request(url,
          options: Options(
            method: 'GET',
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = Model.fromJson(response.data);
        setState(() {
          _dropboxFiles3 = data.result!.map((e) => e.key1!).toList();
          dropdownItems3 = List.generate(_dropboxFiles3.length, (index) {
            return DropdownMenuItem(
              child: Text(_dropboxFiles3[index]),
              value: _dropboxFiles3[index],
            );
          });
        });
      } else {
        print('Failed to load dropbox files: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.message}');
        if (e.response != null) {
          print('Response data: ${e.response?.data}');
          print('Response headers: ${e.response?.headers}');
          print('Response request: ${e.response?.requestOptions}');
        }
      } else {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesap Sayfası'),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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

            Text(
              _selectedDate == null
                  ? 'Tarih seçilmedi'
                  : 'Seçilen Tarih: ${_selectedDate!.toLocal()}'.split(' ')[0],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Harcama Tipi'),
                  items: dropdownItems,
                  onChanged: (value) {}),
            ),

            Text(
              _selectedDropboxFile1 == null
                  ? 'Dosya seçilmedi'
                  : 'Seçilen Dosya: $_selectedDropboxFile1',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                  controller: _dropboxController2,
                  decoration: InputDecoration(
                    labelText: 'Harcama Lokasyonu',
                    hintText: 'Harcama Lokasyonu seçmek için tıklayın',
                  ),
                  readOnly: true,
                  onTap: () {}),
            ),
            SizedBox(height: 10.0),
            Text(
              _selectedDropboxFile2 == null
                  ? 'Lokasyon seçilmedi'
                  : 'Seçilen Lokasyon: $_selectedDropboxFile2',
            ),
            //  SizedBox(height: 10.0),
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
            // SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Harcama Birimi'),
                  items: dropdownItems3,
                  onChanged: (value) {}),
            ),
            //SizedBox(height: 10.0),
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
            //  SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
  }




// void _selectDropboxFile(BuildContext context, int dropboxIndex) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return ListView.builder(
//           itemCount: dropboxIndex == 1
//               ? _dropboxFiles.length
//               : dropboxIndex == 2
//                   ? _dropboxFiles2.length
//                   : _dropboxFiles3.length,
//           itemBuilder: (context, index) {
//             final item = dropboxIndex == 1
//                 ? _dropboxFiles[index]
//                 : dropboxIndex == 2
//                     ? _dropboxFiles2[index]
//                     : _dropboxFiles3[index];
//             return ListTile(
//               title: Text(item),
//               onTap: () {
//                 setState(() {
//                   if (dropboxIndex == 1) {
//                     _selectedDropboxFile1 = item;
//                     _dropboxController1.text = _selectedDropboxFile1!;
//                     _selectedFiles.add(_selectedDropboxFile1!);
//                   } else if (dropboxIndex == 2) {
//                     _selectedDropboxFile2 = item;
//                     _dropboxController2.text = _selectedDropboxFile2!;
//                     _selectedFiles2.add(_selectedDropboxFile2!);
//                   } else if (dropboxIndex == 3) {
//                     _selectedDropboxFile3 = item;
//                     _dropboxController3.text = _selectedDropboxFile3!;
//                     _selectedFiles3.add(_selectedDropboxFile3!);
//                   }
//                 });
//                 Navigator.pop(context);
//               },
//             );
//           },
//         );
//       },
//     );
//   }