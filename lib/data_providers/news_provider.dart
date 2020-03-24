import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:covid19cuba/models/models.dart';
import 'package:covid19cuba/utils/utils.dart';

const news_url = 'http://www.cusobu.nat.cu/covid/telegram/get';

Future<NewsModel> getneswsdata(int date) async {
    var response = await post(news_url, headers: {'Content-Type': 'application/json'} , body: jsonEncode({ 'from' : date.toString() }));
    if(response.statusCode == 404) {
      throw InvalidSourceException('Source is invalid');
    }
    else if (response.statusCode != 200) {
      throw BadRequestException('Bad request');
    }
    NewsModel result;
    try {
      result = NewsModel.fromJson(jsonDecode(response.body));
    } catch (error) {
      log(error.toString());
      print(error);
      //throw ParseException('Parse error');
    }
    return result;
}