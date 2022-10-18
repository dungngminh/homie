import 'package:category/data/category_datasource.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';

class RemoteCategoryDatasource implements CategoryDatasource {
  RemoteCategoryDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<List<HouseType>> getHouseType() async {
    try {
      final houseTypeData = await _httpHandler.get(
        ApiPath.categoryHouseType,
      ) as List;
      return houseTypeData
          .map((e) => HouseType.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerErrorException {
      throw Exception();
    }
  }
}
