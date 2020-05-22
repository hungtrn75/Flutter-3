import 'dart:io';
import 'package:dio/dio.dart';

var http = Dio(
  BaseOptions(
    baseUrl: 'https://flutter-train-3.firebaseio.com/',
    connectTimeout: 10000,
    receiveTimeout: 20000,
    contentType: Headers.jsonContentType,
  ),
);
