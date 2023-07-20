import '../../model/enums/enums.dart';
import '../../services/exceptions/error_exceptions.dart';
import '../../services/api_client/get_repository.dart';
import 'mounted_state_notfier.dart';
import '../../model/profile_model.dart';

class ProfileViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;
  String errorMessage = '';
  dynamic _userprofile;
  dynamic get userprofile => _userprofile;

  ProfileViewModel() {
    getprofile();
  }

  void getprofile() async {
    try {
      _fetchstate = PageState.loading;
      _userprofile = await GetHttpRepository.get.getuserprofile();
      _fetchstate = PageState.loaded;
      notifyListeners();
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errorMessage = e.message;
      notifyListeners();
    }
  }
}

class AuthorProfileViewModel extends MountedStateNotifer {
  PageState _fetchstate = PageState.inital;
  PageState get fetchstate => _fetchstate;
  String errorMessage = '';
  Profile? _userprofile;
  Profile? get userprofile => _userprofile;

  AuthorProfileViewModel(int id) {
    getprofile(id);
  }

  void getprofile(int id) async {
    try {
      _fetchstate = PageState.loading;
      _userprofile = await GetHttpRepository.get.getauthorprofile(id);
      _fetchstate = PageState.loaded;
      notifyListeners();
    } on ExceptionFailuresMessage catch (e) {
      _fetchstate = PageState.error;
      errorMessage = e.message;
      notifyListeners();
    }
  }
}
