class BaseClientEndPoints {
  static const String _apibaseurl = "192.168.43.73:8000";
  // static const String _apibaseurl = "blogapi-ctzx.onrender.com";

  Uri _buildUrl({required String endpoint}) {
    return Uri.parse("http://$_apibaseurl/$endpoint");
  }

  Uri blogPosts() {
    return _buildUrl(endpoint: "api/posts/");
  }

  Uri blogPost(String slug) {
    return _buildUrl(endpoint: "api/post/$slug");
  }

  Uri searchpost(String search) {
    return _buildUrl(endpoint: "api/posts?search=$search");
  }

  Uri postfollowing() {
    return _buildUrl(endpoint: "api/following/create/");
  }

  Uri followers(int id) {
    return _buildUrl(endpoint: "api/followers/$id");
  }

  Uri following(int id) {
    return _buildUrl(endpoint: "api/followings/$id");
  }

  Uri comment(String slug) {
    return _buildUrl(endpoint: "api/comment/$slug/");
  }

  Uri authorposts(int id) {
    return _buildUrl(endpoint: "api/posts/author/$id");
  }

  Uri userpost() {
    return _buildUrl(endpoint: "api/posts/user/");
  }

  Uri userprofile() {
    return _buildUrl(endpoint: "api/profile/");
  }

  Uri authorprofile(int id) {
    return _buildUrl(endpoint: "api/profile/$id");
  }

  Uri postcomment(String slug) {
    return _buildUrl(endpoint: "api/comment/$slug/create/");
  }

  Uri signup() {
    return _buildUrl(endpoint: "api/signup/");
  }

  Uri login() {
    return _buildUrl(endpoint: "api/auth/login/");
  }

  Uri likepost(String slug) {
    return _buildUrl(endpoint: "api/post/$slug/likes/");
  }

  Uri updateprofile() {
    return _buildUrl(endpoint: "api/profile/");
  }

  Uri createpost() {
    return _buildUrl(endpoint: "api/posts/user/");
  }

  Uri editpost(String slug) {
    return _buildUrl(endpoint: "api/post/user/$slug/");
  }

  Uri deletepost(String slug) {
    return _buildUrl(endpoint: "api/post/user/$slug/");
  }

  Uri logout() {
    return _buildUrl(endpoint: "api/auth/logout/");
  }
}
