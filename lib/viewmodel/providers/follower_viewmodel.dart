import '../../model/enums/enums.dart';
import '../../services/exceptions/error_exceptions.dart';
import '../../services/api_client/get_repository.dart';
import 'mounted_state_notfier.dart';

class FollowerViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;

  String errorMessage = "";

  dynamic _follower;
  dynamic get follower => _follower;

  FollowerViewModel(int id) {
    getfollowers(id);
  }

  void getfollowers(int id) async {
    try {
      _fetchstate = PageState.loading;
      _follower = await GetHttpRepository.get.getFollowers(id);
      _fetchstate = PageState.loaded;
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errorMessage = e.message;
    }
    notifyListeners();
  }
}
