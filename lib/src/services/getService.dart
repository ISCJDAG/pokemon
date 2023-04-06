import 'package:http/http.dart' as http;

class GetService {
  getPokemonsService(String url, Map<String, String> header) {
    return http
        .get(Uri.parse(url), headers: header)
        .timeout(const Duration(minutes: 1));
  }

  getOnePokemonService(String url, Map<String, String> header) {
    return http
        .get(Uri.parse(url), headers: header)
        .timeout(const Duration(minutes: 1));
  }
}
