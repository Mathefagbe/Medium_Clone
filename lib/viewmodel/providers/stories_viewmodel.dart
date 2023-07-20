import '../../services/api_client/get_repository.dart';
import '../../model/enums/enums.dart';
import '../../services/exceptions/error_exceptions.dart';
import 'mounted_state_notfier.dart';

class UserStoriesViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;
  String errorMessage = '';
  dynamic _stories;
  dynamic get userstories => _stories;

  UserStoriesViewModel() {
    getStories();
  }

  void getStories() async {
    try {
      _fetchstate = PageState.loading;
      _stories = await GetHttpRepository.get.getuserpost();
      _fetchstate = PageState.loaded;
      notifyListeners();
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errorMessage = e.message;
      notifyListeners();
    }
  }

  void refreshstories() async {
    _stories = await GetHttpRepository.get.getuserpost();
    notifyListeners();
  }
}

class AuthorStoriesViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;
  String errorMessage = '';

  dynamic _stories;
  dynamic get stories => _stories;

  AuthorStoriesViewModel(int id) {
    getstories(id);
  }

  void getstories(int id) async {
    try {
      _fetchstate = PageState.loading;
      _stories = await GetHttpRepository.get.getauthorpost(id);
      _fetchstate = PageState.loaded;
      notifyListeners();
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errorMessage = e.message;
    }
  }
}
