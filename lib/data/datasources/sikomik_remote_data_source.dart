import 'package:http/http.dart' as http;

import '../../common/const.dart';

abstract class SiKomikRemoteDataSource {}

class SiKomikRemoteDataSourceImpl implements SiKomikRemoteDataSource {
  static const url = baseUrl;

  final http.Client client;

  SiKomikRemoteDataSourceImpl({
    required this.client,
  });
}
