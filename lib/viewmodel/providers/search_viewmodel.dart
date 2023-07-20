// ignore: file_names
import '../../model/enums/enums.dart';
import '../../services/api_client/get_repository.dart';
import 'mounted_state_notfier.dart';

class SearchViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;

  String errrormessage = "";

  dynamic _searchPost;
  dynamic get searchpost => _searchPost;

  void getsearchpost(String search) async {
    try {
      _fetchstate = PageState.loading;
      _searchPost = await GetHttpRepository.get.getsearchpost(search);
      _fetchstate = PageState.loaded;
      notifyListeners();
    } catch (e) {
      _fetchstate = PageState.error;
      errrormessage = e.toString();
      notifyListeners();
    }
  }
}
