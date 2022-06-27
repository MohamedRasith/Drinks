import 'package:drinks/models/drink.dart';
import 'package:drinks/utils/api_client.dart';

class DrinksRepository {
  const DrinksRepository._();

  static final _dio = ApiClient.dio;

  static Future<List<Drink>?> getDrinks({
    required String? searchQuery,
  }) async {
    final res = await _dio.get(
      'search.php',
      queryParameters: {'s': searchQuery},
    );

    return res.data?['drinks']
        ?.map((drink) => Drink.fromJson(drink))
        .cast<Drink>()
        .toList();
  }
}
