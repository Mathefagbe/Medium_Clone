import '../../model/enums/enums.dart';
import '../../services/exceptions/error_exceptions.dart';
import '../../services/api_client/get_repository.dart';
import 'mounted_state_notfier.dart';

class FollowingViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;

  String errorMessage = '';
  dynamic _following;
  dynamic get following => _following;

  FollowingViewModel(int id) {
    getfollowingusers(id);
  }

  void getfollowingusers(int id) async {
    try {
      _fetchstate = PageState.loading;
      _following = await GetHttpRepository.get.getFollowering(id);
      _fetchstate = PageState.loaded;
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errorMessage = e.message;
    }
    notifyListeners();
  }
}
