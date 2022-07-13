import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager{
  final Dio dio = Dio();

  upload(File imageFile) async {
  // ignore: deprecated_member_use
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));  // get file length
    var length = await imageFile.length();

  // string to uri
  var uri =
  Uri.parse("https://jaundice-classfire.herokuapp.com//predict");

  // create multipart request
  var request = http.MultipartRequest("POST", uri);

  // multipart that takes file
  var multipartFile = http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();

  // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      value;
    });
  }}
