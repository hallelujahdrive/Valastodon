namespace Gomphotherium {
  private const string ENDPOINT_ACCOUNTS = "/api/v1/accounts/%" + int64.FORMAT;
  private const string ENDPOINT_ACCOUNTS_FOLLOWERS = "/api/v1/accounts/%" + int64.FORMAT + "/followers";
  private const string ENDPOINT_ACCOUNTS_FOLLOWING = "/api/v1/accounts/%" + int64.FORMAT + "/following";
  private const string ENDPOINT_ACCOUNTS_RELATIONSHIPS = "/api/v1/accounts/relationships";
  private const string ENDPOINT_ACCOUNTS_SEARCH = "/api/v1/accounts/search";
  private const string ENDPOINT_ACCOUNTS_STATUSES = "/api/v1/accounts/%" + int64.FORMAT + "/statuses";
  private const string ENDPOINT_ACCOUNTS_VERIFY_CREDENTIALS = "/api/v1/accounts/verify_credentials";
  private const string ENDPOINT_APPS = "/api/v1/apps";
  private const string ENDPOINT_BLOCKS = "/api/v1/blocks";
  private const string ENDPOINT_FAVOURITES = "/api/v1/favourites";
  private const string ENDPOINT_FOLLOW_REQUESTS = "/api/v1/follow_requests";
  private const string ENDPOINT_INSTANCE = "/api/v1/instance";
  private const string ENDPOINT_MUTES = "/api/v1/mutes";
  private const string ENDPOINT_NOTIFICATION = "/api/v1/notifications/%" + int64.FORMAT;
  private const string ENDPOINT_NOTIFICATIONS = "/api/v1/notifications";
  private const string ENDPOINT_REPORTS = "/api/v1/reports";
  private const string ENDPOINT_OAUTH_TOKEN = "/oauth/token";
  private const string ENDPOINT_SEARCH = "/api/v1/search";
  private const string ENDPOINT_STATUSES = "/api/v1/statuses/%" + int64.FORMAT;
  private const string ENDPOINT_STATUSES_CARD = "/api/v1/statuses/%" + int64.FORMAT + "/card";
  private const string ENDPOINT_STATUSES_CONTEXT = "/api/v1/statuses/%" + int64.FORMAT + "/context";
  private const string ENDPOINT_STATUSES_FAVOURITED_BY = "/api/v1/statuses/%" + int64.FORMAT + "/favourited_by";
  private const string ENDPOINT_STATUSES_REBLOGGED_BY = "/api/v1/statuses/%" + int64.FORMAT + "/reblogged_by";
  private const string ENDPOINT_TIMELINES_HOME = "/api/v1/timelines/home";
  private const string ENDPOINT_TIMELINES_PUBLIC = "/api/v1/timelines/public";
  private const string ENDPOINT_TIMELINES_TAG = "/api/v1/timelines/tag/%s";
}
