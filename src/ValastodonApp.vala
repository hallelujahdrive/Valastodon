using Json;
using Rest;
using Soup;

namespace Valastodon {
	
	public class ValastodonApp : ValastodonAppBase {
				
		// @website : Instance URL
		// @client_key : Client Key of your ValastodonApp
		// @client_secret : Client Secret of your cpplication
		// @access_token : (oprional) An access token of your app
		public ValastodonApp (string website, string client_key, string client_secret, string? access_token = null) {
			base (website, client_key, client_secret, access_token);
		}
		
		// Getting an access token
		// @code : An authorization code
		public string oauth_with_code (string code) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_oauth_with_code_proxy_call (ref proxy_call, code);
			
			try {
				proxy_call.run ();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				print (proxy_call.get_payload ());
				return _access_token = json_obj.get_string_member ("access_token");

			} catch (Error e) {
				throw e;
			}
		}

		// Getting an account
		// @id : The ID of the account
		public Account get_account (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_account_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Account (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Getting the current user
		public Account verify_credentials () throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_verify_credentials_proxy_call (ref proxy_call);
			
			try {
				
				proxy_call.run();

				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Account (json_obj);
				
			} catch(Error error){
				throw error;
			}
		}
		
		// Updating the current user
		// @display_name : (optional) The name to display in the user's profile
		// @note : (optional) A new biography for the user
		// @avatar : (optional) An image to display as the user's avatar
		// @header : (optional) An image to display as the user's header image
		public Account update_credentials (string? display_name = null, string? note = null, File? avatar = null, File? header = null) throws Error {
			
			Error error = null;
			
			var session = new Soup.Session ();
			var message = update_credentials_message_new (display_name, note, avatar, header);
			
			session.send_message (message);
			
			var data = message.response_body.data;
			var data_str = ((string) data).substring (0, data.length);
			
			if (!handle_error_from_message (message, out error)) {
				throw error;
			}  

			try {
				var json_obj = parse_json_object (data_str);

				return new Account (json_obj);
			
			} catch (Error e) {
				throw e;
			} 
		}
		
		// Getting an account's followers
		// @id : The ID of the account to get followers
		// @ranging_params : (optional) Parameters to select ranges of followers
		// @next_params : (optional) Parameters to select next ranges of followers
		// @prev_params : (optional) Parameters to select prev ranges of followers
		public List<Account> get_followers (int64 id, RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			next_params = null;
			prev_params = null;
			
			var proxy_call = proxy.new_call ();
			setup_get_followers_proxy_call (ref proxy_call, id, ranging_params);
			
			try {
				
				proxy_call.run();
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Account> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Account (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch (Error e) {
				throw e;
			}
		}
		
		// Getting an account's following
		// @id : The ID of the account to get following
		// @ranging_params : (optional) Parameters to select ranges of following
		// @next_params : (optional) Parameters to select next ranges of folloeing
		// @prev_params : (optional) Parameters to select prev ranges of following
		public List<Account> get_following (int64 id, RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_following_proxy_call (ref proxy_call, id, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Account> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Account (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch (Error e) {
				throw e;
			}
		}
		
		// Getting an account's statuses
		// @id : The ID of the account to get statuses
		// @only_media : (optional) Only return statuses that have media attachments
		// @exclude_replices (optional) Skip statuses that reply to other statuses
		// @ranging_params : (optional) Parameters to select ranges of statuses
		// @next_params : (optional) Parameters to select next ranges of statuses
		// @prev_params : (optional) Parameters to select prev ranges of statuses
		public List<Status> get_statuses (int64 id, bool only_media = false, bool exclude_replies = false, RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_statuses_proxy_call (ref proxy_call, id, only_media, exclude_replies, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Status> ();
								
				json_array.foreach_element ((array, index, node) => {
					list.append (new Status (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch (Error e) {
				throw e;
			}
		}
		
		// Following an account
		// @id : The ID of the account to follow
		public Relationship follow (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_follow_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();

				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Relationship (json_obj);
				
			} catch (Error e) {
				throw e;
			}
		}
		
		// Unfollowing an account
		// @id : The ID of the account to unfollow
		public Relationship unfollow (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_unfollow_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Relationship (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}

		// Blocking an account
		// @id : The ID of the account to block
		public Relationship block (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_block_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Relationship (json_obj);
				
			} catch (Error e) {
				throw e;
			}
		}
		
		// Unblocking an account
		// @id : The ID of the account to unblock
		public Relationship unblock (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_unblock_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Relationship (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Muting an account
		// @id : The ID of the account to mute
		public Relationship mute (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_mute_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Relationship (json_obj);
				
			} catch (Error e) {
				throw e;
			}
		}
		
		// Unmuting an account
		// @id : The ID of the account to unmute
		public Relationship unmute (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_unmute_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Relationship (json_obj);
				
			} catch (Error e) {
				throw e;
			}
		}

		// Getting an account's relationships
		// @ids : The IDs of accounts to get relationships
		public List<Relationship> get_relationships (int64[] ids) throws Error {
			
			Error error = null;
			
			var session = new Soup.Session ();
			var message = relationships_message_new (ids);
			
			session.send_message (message);
			
			var data = message.response_body.data;
			var data_str = ((string) data).substring (0, data.length);
			
			if (!handle_error_from_message (message, out error)) {
				throw error;
			}  

			try {
				var json_array = parse_json_array (data_str);

				var list = new List<Relationship> ();
								
				json_array.foreach_element ((array, index, node) => {
					list.append (new Relationship (node.get_object ()));
				});

				return (owned) list;
			
			} catch (Error e) {
				throw e;
			}
		}
		
		// Getting an account's relationship
		// @id : The ID of the account to get relationship
		public Relationship get_relationship (int64 id) throws Error {
			
			try {
				var list = get_relationships ({id});
				return list.nth_data (0);
			} catch (Error e) {
				throw e;
			}
		}
		
		// Searching for accounts
		// @q : What to search for
		// @limit : (optional) Maximum number of matching accounts to return (default: 40)
		public List<Account> search_accounts (string q, int limit = -1) throws Error{
			
			var proxy_call = proxy.new_call ();
			setup_search_accounts_proxy_call (ref proxy_call, q, limit);
			
			try {
				
				proxy_call.run();
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Account> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Account (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch (Error e) {
				throw e;
			}      
		}
		
		// Fetching a user's blocks
		// @ranging_params : (optional) Parameters to select ranges of blocks
		// @next_params : (optional) Parameters to select next ranges of blocks
		// @prev_params : (optional) Parameters to select prev ranges of blocks
		public List<Account> get_blocks (RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_blocks_proxy_call (ref proxy_call, ranging_params);
			
			try {
				
				proxy_call.run();
				
				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Account> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Account (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch (Error e) {
				throw e;
			}
		}

		// Fetching a user's favourites
		// @ranging_params : (optional) Parameters to select ranges of favourites
		// @next_params : (optional) Parameters to select next ranges of favourites
		// @prev_params : (optional) Parameters to select prev ranges of favourites
		public List<Status> get_favourites (RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_favoutrites_proxy_call (ref proxy_call, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Status> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Status (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch (Error e) {
				throw e;
			}
		}
		
		// Fetching  a list of follow requests
		// @ranging_params : (optional) Parameters to select ranges of follow requests
		// @next_params : (optional) Parameters to select next ranges of follow requests
		// @prev_params : (optional) Parameters to select prev ranges of follow requests
		public List<Account> get_follow_requests (RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_follow_requests_proxy_call (ref proxy_call, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Account> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Account (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Authorizing a follow request
		// @id : The ID of the account to authorize
		public void authorize_follow_request (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_authorize_follow_request_proxy_call (ref proxy_call, id);

			try {
				proxy_call.run();
			} catch (Error e) {
				throw e;
			}
		}

		// Rejecting a follow request
		// @id : The ID of the account to reject
		public void reject_follow_request (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_reject_follow_request_proxy_call (ref proxy_call, id);

			try {
				proxy_call.run();
			} catch(Error e){
				throw e;
			}
		}
		
		// Following a remote user
		// @uri : username@domain of the person you want to follow
		public Account remote_follow (string uri) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_remote_follow_proxy_call (ref proxy_call, uri);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Account (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}

		// Getting instance information
		public Instance get_instance () throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_instance_proxy_call (ref proxy_call);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Instance (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Uploading a media attachment
		// file : Media to be uploaded
		public Attachment upload_media (File file) throws Error {

			Error error = null;
			
			var session = new Soup.Session ();
			var message =upload_media_message_new (file);
			
			session.send_message (message);
			
			var data = message.response_body.data;
			var data_str = ((string) data).substring (0, data.length);
			
			if (!handle_error_from_message (message, out error)) {
				throw error;
			}  

			try {
				return new Attachment (parse_json_object (data_str));
			} catch (Error e) {
				throw e;
			}
		}

		// Fetching a user's mutes
		// @ranging_params : (optional) Parameters to select ranges of mutes
		// @next_params : (optional) Parameters to select next ranges of mutes
		// @prev_params : (optional) Parameters to select prev ranges of mutes
		public List<Account> get_mutes (RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_mutes_proxy_call (ref proxy_call, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Account> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Account (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch(Error e){
				throw e;
			}
		}

		// Fetching a user's notifications
		// @ranging_params : (optional) Parameters to select ranges of notifications
		// @next_params : (optional) Parameters to select next ranges of notifications
		// @prev_params : (optional) Parameters to select prev ranges of notifications
		public List<Valastodon.Notification> get_notifications (RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_notifications_proxy_call (ref proxy_call, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Valastodon.Notification> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Valastodon.Notification (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch(Error e){
				throw e;
			}
		}

		// Getting a single notification
		// @id : The ID of the account to get notifications
		public Valastodon.Notification get_notification (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_notification_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();

				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Valastodon.Notification (json_obj);
				
			} catch(Error error){
				throw error;
			}
		}
		
		// Clearing notifications
		public void clear_notifications () throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_clear_notifications_proxy_call (ref proxy_call);
			
			try {
				proxy_call.run();
			} catch(Error error){
				throw error;
			}
		}

		// Fetching a user's reports
		public List<Report> get_reports () throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_reports_proxy_call (ref proxy_call);
			
			try {
				
				proxy_call.run();
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Report> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Report (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Reporting a user
		// @account_id : The ID of the account to report
		// @status_ids : The IDs of statuses to report
		// @comment : A comment to associate with the report
		public Report report (int64 account_id, int64[] status_ids, string comment) throws Error {
			
			Error error = null;
			
			var session = new Soup.Session ();
			var message = report_message_new (account_id, status_ids, comment);
			
			session.send_message (message);
			
			var data = message.response_body.data;
			var data_str = ((string) data).substring (0, data.length);
			
			if (!handle_error_from_message (message, out error)) {
				throw error;
			}  

			try {
				return new Report (parse_json_object (data_str));
			} catch (Error e) {
				throw e;
			}      
		}
		
		// Searching for content
		// @q : The search query
		// @resolve : Whether to resolve non-local accounts
		public Results search (string q, bool resolve) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_search_proxy_call (ref proxy_call, q, resolve);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Results (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Fetching a status
		// @id : The ID of the status
		public Status get_status (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_status_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Status (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Getting status context
		// @id : The ID of the status
		public Context get_context (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_context_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Context (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}

		// Getting a card associated with a status
		// @id : The ID of the status
		public Card get_card (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_card_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Card (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Getting who reblogged a status
		// @ranging_params : (optional) Parameters to select ranges of reblogged by
		// @next_params : (optional) Parameters to select next ranges of reblogged by
		// @prev_params : (optional) Parameters to select prev ranges of reblogged by   
		public List<Account> get_reblogged_by (int64 id, RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_reblogged_by_proxy_call (ref proxy_call, id, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Account> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Account (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch(Error e){
				throw e;
			}
		}

		// Getting who favourited a status
		// @ranging_params : (optional) Parameters to select ranges of favoutited by
		// @next_params : (optional) Parameters to select next ranges of favoutited by
		// @prev_params : (optional) Parameters to select prev ranges of favoutited by
		public List<Account> get_favourited_by (int64 id, RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_favourited_by_proxy_call (ref proxy_call, id, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Account> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Account (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch(Error e){
				throw e;
			}
		}
		
		
		// Posting a new status
		// @status : The text of the status
		// @in_reply_to_id : (optional) local ID of the status you want to reply to
		// @media_ids : (optional) Array of media IDs to attach to the status (maximum 4)
		// @sensitive : (optional) Set this to mark the media of the status as NSFW
		// @spoiler_text : (optional)   Text to be shown as a warning before the actual content
		// @visibility : (optional) Either "direct", "private", "unlisted" or "public"
		public Status post_status (string status, int64 in_reply_to_id = -1, int64[]? media_ids = null, bool sensitive = false, string? spoiler_text = null, string? visibility = null) throws Error {

			Error error = null;
			
			var session = new Soup.Session ();
			var message = post_status_message_new (status, in_reply_to_id, media_ids, sensitive, spoiler_text, visibility);
			
			session.send_message (message);
			
			var data = message.response_body.data;
			var data_str = ((string) data).substring (0, data.length);
			
			if (!handle_error_from_message (message, out error)) {
				throw error;
			}  

			try {
				return new Status (parse_json_object (data_str));
			} catch (Error e) {
				throw e;
			}         
		}
		
		// Reblogging a status
		// @id : The ID of status to reblog
		public Status reblog (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_reblog_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Status (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Unreblogging a status
		// @id : The ID of status to unreblog
		public Status unreblog (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_unreblog_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Status (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}
		
		// favouriting a status
		// @id : The ID of status to favourite
		public Status favourite (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_favourite_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Status (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}
		
		// unfavouriting a status
		// @id : The ID of status to unfavourite
		public Status unfavourite (int64 id) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_unfavourite_proxy_call (ref proxy_call, id);
			
			try {
				
				proxy_call.run();
				
				var json_obj = parse_json_object (proxy_call.get_payload ());
				return new Status (json_obj);
				
			} catch(Error e){
				throw e;
			}
		}

		// Retrieving home timeline
		// @ranging_params : (optional) Parameters to select ranges of statuses
		// @next_params : (optional) Parameters to select next ranges of statuses
		// @prev_params : (optional) Parameters to select prev ranges of statuses
		public List<Status> get_home_timeline (RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_home_timeline_proxy_call (ref proxy_call, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Status> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Status (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Retrieving public timeline
		// @local : (optional) Only return statuses originating from this instance
		// @ranging_params : (optional) Parameters to select ranges of statuses
		// @next_params : (optional) Parameters to select next ranges of statuses
		// @prev_params : (optional) Parameters to select prev ranges of statuses
		public List<Status> get_public_timeline (bool local = true, RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_public_timeline_proxy_call (ref proxy_call, local, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Status> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Status (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch(Error e){
				throw e;
			}
		}
		
		// Retrieving htag timeline
		// @hashtag : The hashtag to search
		// @local : (optional) Only return statuses originating from this instance
		// @ranging_params : (optional) Parameters to select ranges of statuses
		// @next_params : (optional) Parameters to select next ranges of statuses
		// @prev_params : (optional) Parameters to select prev ranges of statuses
		public List<Status> get_tag_timeline (string hashtag, bool local = true, RangingParams? ranging_params = null, out RangingParams next_params = null, out RangingParams prev_params = null) throws Error {
			
			var proxy_call = proxy.new_call ();
			setup_get_tag_timeline_proxy_call (ref proxy_call, hashtag, local, ranging_params);
			
			try {
				
				proxy_call.run();

				var headers = proxy_call.get_response_headers ();
				parse_links (headers.get ("Link"), out next_params, out prev_params);
				
				var json_array = parse_json_array (proxy_call.get_payload ());
				var list = new List<Status> ();
				
				json_array.foreach_element ((array, index, node) => {
					list.append (new Status (node.get_object ()));
				});
				
				return (owned) list;
				
			} catch(Error e){
				throw e;
			}
		}
	}
}
