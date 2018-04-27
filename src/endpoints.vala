namespace Valastodon {
	private const string ENDPOINT_ACCOUNTS = "/api/v1/accounts/%" + int64.FORMAT;
	private const string ENDPOINT_ACCOUNTS_BLOCK = "/api/v1/accounts/%" + int64.FORMAT + "/block";
	private const string ENDPOINT_ACCOUNTS_FOLLOW = "/api/v1/accounts/%" + int64.FORMAT + "/follow";
	private const string ENDPOINT_ACCOUNTS_MUTE = "/api/v1/accounts/%" + int64.FORMAT + "/mute";
	private const string ENDPOINT_ACCOUNTS_FOLLOWERS = "/api/v1/accounts/%" + int64.FORMAT + "/followers";
	private const string ENDPOINT_ACCOUNTS_FOLLOWING = "/api/v1/accounts/%" + int64.FORMAT + "/following";
	private const string ENDPOINT_ACCOUNTS_RELATIONSHIPS = "/api/v1/accounts/relationships";
	private const string ENDPOINT_ACCOUNTS_SEARCH = "/api/v1/accounts/search";
	private const string ENDPOINT_ACCOUNTS_STATUSES = "/api/v1/accounts/%" + int64.FORMAT + "/statuses";
	private const string ENDPOINT_ACCOUNTS_UNBLOCK = "/api/v1/accounts/%" + int64.FORMAT + "/unblock";
	private const string ENDPOINT_ACCOUNTS_UNFOLLOW = "/api/v1/accounts/%" + int64.FORMAT + "/unfollow";
	private const string ENDPOINT_ACCOUNTS_UNMUTE = "/api/v1/accounts/%" + int64.FORMAT + "/unmute";
	private const string ENDPOINT_ACCOUNTS_UPDATE_CREDENTIALS = "/api/v1/accounts/update_credentials";
	private const string ENDPOINT_ACCOUNTS_VERIFY_CREDENTIALS = "/api/v1/accounts/verify_credentials";
	private const string ENDPOINT_APPS = "/api/v1/apps";
	private const string ENDPOINT_BLOCKS = "/api/v1/blocks";
	private const string ENDPOINT_FAVOURITES = "/api/v1/favourites";
	private const string ENDPOINT_FOLLOWS = "/api/v1/follows";
	private const string ENDPOINT_FOLLOW_REQUESTS = "/api/v1/follow_requests";
	private const string ENDPOINT_FOLLOW_REQUESTS_AUTHORIZE = "/api/v1/follow_requests/%" + int64.FORMAT + "/authorize";
	private const string ENDPOINT_FOLLOW_REQUESTS_REJECT = "/api/v1/follow_requests/%" + int64.FORMAT + "/reject";
	private const string ENDPOINT_INSTANCE = "/api/v1/instance";
	private const string ENDPOINT_MEDIA = "/api/v1/media";
	private const string ENDPOINT_MUTES = "/api/v1/mutes";
	private const string ENDPOINT_NOTIFICATION = "/api/v1/notifications/%" + int64.FORMAT;
	private const string ENDPOINT_NOTIFICATIONS = "/api/v1/notifications";
	private const string ENDPOINT_NOTIFICATIONS_CLIEAR = "/api/v1/notifications/clear";
	private const string ENDPOINT_REPORTS = "/api/v1/reports";
	private const string ENDPOINT_OAUTH_TOKEN = "/oauth/token";
	private const string ENDPOINT_SEARCH = "/api/v1/search";
	private const string ENDPOINT_STATUSES = "/api/v1/statuses";
	private const string ENDPOINT_STATUSES_ID = "/api/v1/statuses/%" + int64.FORMAT;
	private const string ENDPOINT_STATUSES_CARD = "/api/v1/statuses/%" + int64.FORMAT + "/card";
	private const string ENDPOINT_STATUSES_CONTEXT = "/api/v1/statuses/%" + int64.FORMAT + "/context";
	private const string ENDPOINT_STATUSES_FAVOURITE = "/api/v1/statuses/%" + int64.FORMAT + "/favourite";
	private const string ENDPOINT_STATUSES_FAVOURITED_BY = "/api/v1/statuses/%" + int64.FORMAT + "/favourited_by";
	private const string ENDPOINT_STATUSES_REBLOG = "/api/v1/statuses/%" + int64.FORMAT + "/reblog";
	private const string ENDPOINT_STATUSES_REBLOGGED_BY = "/api/v1/statuses/%" + int64.FORMAT + "/reblogged_by";
	private const string ENDPOINT_STATUSES_UNFAVOURITE = "/api/v1/statuses/%" + int64.FORMAT + "/unfavourite";
	private const string ENDPOINT_STATUSES_UNREBLOG = "/api/v1/statuses/%" + int64.FORMAT + "/unreblog";
	private const string ENDPOINT_STREAMING_PUBLIC = "/api/v1/streaming/public";
	private const string ENDPOINT_STREAMING_HASHTAG = "/api/v1/streaming/hashtag";
	private const string ENDPOINT_STREAMING_USER = "/api/v1/streaming/user";
	private const string ENDPOINT_TIMELINES_HOME = "/api/v1/timelines/home";
	private const string ENDPOINT_TIMELINES_PUBLIC = "/api/v1/timelines/public";
	private const string ENDPOINT_TIMELINES_TAG = "/api/v1/timelines/tag/%s";
}
