import '../../model/enums/enums.dart';
import '../../services/exceptions/error_exceptions.dart';
import '../../services/api_client/get_repository.dart';
import 'mounted_state_notfier.dart';

class CommentViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;

  String errorMessage = "";

  dynamic _comment;
  dynamic get comment => _comment;

  CommentViewModel(String slug) {
    getcomment(slug);
  }

  void getcomment(String slug) async {
    try {
      _fetchstate = PageState.loading;
      _comment = await GetHttpRepository.get.getcomment(slug);
      _fetchstate = PageState.loaded;
      notifyListeners();
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errorMessage = e.message;
      notifyListeners();
    }
  }

  void commentrefresh(slug) async {
    _comment = await GetHttpRepository.get.getcomment(slug);
    notifyListeners();
  }
}
