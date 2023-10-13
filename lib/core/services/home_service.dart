import '../../ui/ui_helpers/ui_snackbar_helper.dart';

class HomeService {
  Future<List<String>> getHomeData() async {
    await Future.delayed(const Duration(seconds: 2));
    return ['Hello', 'World', '!'];
  }

  Future<List<String>> getMoreData() async {
    await Future.delayed(const Duration(seconds: 1));
    showSnackbar(titre: 'More data successfully loaded');
    return ['world', '.', 'execute', '(', 'me', ')', ';'];
  }
}
