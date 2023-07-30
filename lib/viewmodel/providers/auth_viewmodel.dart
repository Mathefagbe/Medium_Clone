import 'package:dblog/viewmodel/providers/mounted_state_notfier.dart';
import '../../model/enums/enums.dart';
import '../../services/api_client/authentication_post_repository.dart';
import '../../services/exceptions/error_exceptions.dart';

class SignUpAuthChangeNotifer extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;
  String errormessage = "";

  signUp(Map formdata) async {
    try {
      _fetchstate = PageState.loading;
      notifyListeners();
      await PostAutheniticationHttpRepository.post.signup(formdata);
      _fetchstate = PageState.loaded;
      notifyListeners();
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errormessage = e.toString();
      notifyListeners();
    }
  }
}

class SignInAuthChangeNotifer extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;
  String errormessage = "";

  login(Map formdata) async {
    try {
      _fetchstate = PageState.loading;
      notifyListeners();
      await PostAutheniticationHttpRepository.post.login(formdata);
      _fetchstate = PageState.loaded;
      notifyListeners();
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errormessage = e.toString();
      notifyListeners();
    }
  }
}
