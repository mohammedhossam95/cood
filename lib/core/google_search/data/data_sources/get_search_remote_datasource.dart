import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import '../../core/client/http_client.dart';
import '../../core/error/exceptions/key_empty_exception.dart';
import '../../core/error/exceptions/network_exception.dart';
import '../../core/error/exceptions/server_exception.dart';
import '../../data/data_sources/iget_search_remote_datasource.dart';
import '../../data/models/lat_lng_model.dart';
import '../models/awesome_place_model.dart';

class GetSearchRemoteDataSource implements IGetSearchRemoteDataSource {
  GetSearchRemoteDataSource({
    required this.key,
    required this.http,
  });

  final String key;
  final HttpClient http;
  final url = "maps.googleapis.com";

  @override
  Future<LatLngModel> getLatLng({required String param}) async {
    try {
      var res = await http.get(
        authority: url,
        path: "maps/api/place/details/json",
        param: {
          "language": "ar",
          "placeid": param,
          "key": key,
        },
      );
      if (res.statusCode == 200) {
        final value = json.decode(res.body);
        final body = value['result']['geometry']['location'];

        final LatLngModel result = LatLngModel(
          latModel: body['lat'],
          lngModel: body['lng'],
        );
        return result;
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<AwesomePlacesSearchModel> getPlace(
      {required ParamSearchModel param}) async {
    log(param.key);
    if (param.key.isEmpty || param.key.contains(' ')) {
      throw KeyEmptyException();
    } else {
      try {
        var res = await http.get(
          authority: url,
          path: "maps/api/place/autocomplete/json",
          param: {
            "language": "ar",
            "input": param.value,
            "key": param.key,
          },
        );
        if (res.statusCode == 200) {
          final result = awesomePlacesModelFromJson(res.body);

          return result;
        }
        throw ServerException();
      } on TimeoutException {
        throw NetworkException();
      } catch (e) {
        throw ServerException();
      }
    }
  }
}
