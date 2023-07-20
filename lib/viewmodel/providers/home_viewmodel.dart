import '../../model/enums/enums.dart';
import '../../services/exceptions/error_exceptions.dart';
import '../../services/api_client/get_repository.dart';
import 'mounted_state_notfier.dart';

class HomeViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;

  String errorMessage = "";

  dynamic _blogpost;
  dynamic get blogpost => _blogpost;

  HomeViewModel(context) {
    getblogpost(context);
  }
  void getblogpost(context) async {
    try {
      _fetchstate = PageState.loading;
      _blogpost = await GetHttpRepository.get.getposts();
      _fetchstate = PageState.loaded;
      notifyListeners();
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errorMessage = e.message;
      notifyListeners();
    }
  }
}

class PostDetailViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;

  String errorMessage = "";

  dynamic _blogpostdetail;
  dynamic get blogpost => _blogpostdetail;

  PostDetailViewModel(slug) {
    getblogpost(slug);
  }
  void getblogpost(String slug) async {
    try {
      _fetchstate = PageState.loading;
      _blogpostdetail = await GetHttpRepository.get.getpost(slug);
      _fetchstate = PageState.loaded;
      notifyListeners();
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errorMessage = e.message;
      notifyListeners();
    }
  }
}
