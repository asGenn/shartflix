abstract class NavigationService {
  Future<dynamic> navigateTo(String routeName, {dynamic arguments});
  Future<dynamic> navigateAndReplace(String routeName, {dynamic arguments});
  void goBack({dynamic result});

}
