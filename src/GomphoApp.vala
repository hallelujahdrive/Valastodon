using Json;
using Rest;
using Soup;

namespace Gomphotherium {
  
  public class GomphoApp {
    
    // Property-backing fields
    private string _website;
    private string _client_id;
    private string _client_secret;
    private string _access_token;
    
    private Rest.Proxy proxy;

    // Propaties   
    public unowned string website {
      get { return _website; }
    }
    public unowned string client_id {
      get { return _client_id; }
    }
    public unowned string client_secret {
      get { return _client_secret; }
    }
    public unowned string access_token {
      get { return _access_token; }
    }
    
    // @website : Instance URL
    // @client_id : Client ID of your GomphoApp
    // @client_secret : Client Secret of your cpplication
    // @access_token : (optional) Your access token
    public GomphoApp (string website, string client_id, string client_secret, string? access_token = null) {
      _website = website;
      _client_id = client_id;
      _client_secret = client_secret;
      
      proxy = new Rest.Proxy (_website, false);
      
      if (access_token != null){
        _access_token = access_token;
      }
    }
    
    // Getting an access token
    // @email : A E-mail address of your account
    // @password : Your password
    // @scope : This can be a space-separated list of the following items: "read", "write" and "follow"
    public string oauth_token (string email, string password, string scope) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_oauth_proxy_call (ref proxy_call, email, password, scope);
      
      try {
        proxy_call.run ();
        
        var json_obj = parse_json_object (proxy_call.get_payload ());
        return _access_token = json_obj.get_string_member ("access_token");

      } catch (Error e) {
        throw e;
      }
    }
    
    // Getting an access token asynchronously
    public async string oauth_token_async (string email, string password, string scope) throws Error {
      
      Error error = null;
      
      var proxy_call = proxy.new_call ();
      setup_oauth_proxy_call (ref proxy_call, email, password, scope);
      
      proxy_call.invoke_async.begin (null, (obj, res) => {
          
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload ());
          _access_token = json_obj.get_string_member ("access_token");
          
        } catch (Error e) {
          error = e;
        }
        
        oauth_token_async.callback ();
        
      });
      
      yield;
      
      if (error != null) {
        throw error;
      }
      
      return _access_token;
    }
    
    // Gettinh an account
    public Account get_account (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_account_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Account (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting an account asynchronously
    public async Account get_account_async (int64 id) throws Error {
      
      Error error = null;      
      Account account = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_account_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          account = new Account (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_account_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return account;
    }
    
    // Getting a current user
    public Account verify_credentials () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_verify_credentials_proxy_call (ref proxy_call);
      
      try{
        
        proxy_call.run();

        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Account (json_obj);
        
      }catch(Error error){
        throw error;
      }
    }
    
    
    // Getting a current user asynchronously
    public async Account verify_credentials_async () throws Error {
      
      Error error = null;
      Account account = null;
      
      var proxy_call = proxy.new_call ();
      setup_verify_credentials_proxy_call (ref proxy_call);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          account = new Account (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        verify_credentials_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return account;
    }
    
    // Getting an account's followers
    public List<Account> get_followers (int64 id, int64? max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_followers_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting an account's followers asynchronously
    public async List<Account> get_followers_async (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_followers_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_followers_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Getting an account's following
    public List<Account> get_following (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_following_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting an account's following asynchronously
    public async List<Account> get_following_async (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_following_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_following_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Getting an account's statuses
    public List<Status> get_statuses (int64 id, bool only_media = false, bool exclude_replies = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_statuses_proxy_call (ref proxy_call, id, only_media, exclude_replies, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var data = proxy_call.get_payload();

        var json_array = parse_json_array (data);
        var list = new List<Status> ();
                
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting an account's statuses asynchronously
    public async List<Status> get_statuses_async (int64 id, bool only_media = false, bool exclude_replies = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_statuses_proxy_call (ref proxy_call, id, only_media, exclude_replies, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_statuses_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    
    // Getting an account's relationships
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
    
    // Getting an account's relationships asynchronously
    public async List<Relationship> get_relationships_async (int64[] ids) throws Error {
      
      Error error = null;
      var list = new List<Relationship> ();
      
      var session = new Soup.Session ();
      var message = relationships_message_new (ids);
      
      SourceFunc callback = get_relationships_async.callback;
      
      ThreadFunc<void*> run = () => {
        var loop = new MainLoop ();
        session.queue_message (message, (sess, mess) => {
              
          if (!handle_error_from_message (mess, out error)) {
            loop.quit();
          }
          
          var data = message.response_body.data;
          var data_str = ((string) data).substring (0, data.length);

          try {
            var json_array = parse_json_array (data_str);
                    
            json_array.foreach_element ((array, index, node) => {
              list.append (new Relationship (node.get_object ()));
            });
          } catch (Error e) {
            error = e;
          }
          
          loop.quit ();
        });
        loop.run ();
        Idle.add ((owned) callback);
        
        return null;
      };
      
      new Thread<void*> (null, run);
      
      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Searching for accounts
    public List<Account> search_accounts (string q, int limit = -1) throws Error{
      
      var proxy_call = proxy.new_call ();
      setup_search_accounts_proxy_call (ref proxy_call, q, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }      
    }

    // Searching for accounts asynchronously
    public async List<Account> search_accounts_async (string q, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_search_accounts_proxy_call(ref proxy_call, q, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        search_accounts_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Fetching a user's blocks
    public List<Account> get_blocks (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_blocks_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Fetching a user's blocks asynchronously
    public async List<Account> get_blocks_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_blocks_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_blocks_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Fetching a user's favourites
    public List<Status> get_favourites (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_favoutrites_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Fetching a user's favourites asynchronously
    public async List<Status> get_favourites_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_favoutrites_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_favourites_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Fetching  a list of follow requests
    public List<Account> get_follow_requests (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_follow_requests_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Fetching  a list of follow requests asynchronously
    public async List<Account> get_follow_requests_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_follow_requests_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_follow_requests_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Getting instance information
    public Instance get_instance () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_instance_proxy_call (ref proxy_call);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Instance (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting instance information asynchronously
    public async Instance get_instance_async () throws Error {
      
      Error error = null;      
      Instance instance = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_instance_proxy_call (ref proxy_call);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          instance = new Instance (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_instance_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return instance;
    }

    // Fetching a user's mutes
    public List<Account> get_mutes (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_mutes_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Fetching a user's mutes asynchronously
    public async List<Account> get_mutes_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_mutes_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_mutes_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Fetching a user's notifications
    public List<Gomphotherium.Notification> get_notifications (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_notifications_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Gomphotherium.Notification> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Gomphotherium.Notification (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Fetching a user's notifications asynchronously
    public async List<Gomphotherium.Notification> get_notifications_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Gomphotherium.Notification> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_notifications_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Gomphotherium.Notification (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_notifications_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Getting a single notification
    public Gomphotherium.Notification get_notification (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_notification_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();

        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Gomphotherium.Notification (json_obj);
        
      }catch(Error error){
        throw error;
      }
    }
    
    // Getting a single notification
    public async Gomphotherium.Notification get_notification_async (int64 id) throws Error {
      
      Error error = null;
      Gomphotherium.Notification notification = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_notification_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          notification = new Gomphotherium.Notification (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_notification_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return notification;
    }

    // Fetching a user's reports
    public List<Report> get_reports () throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_reports_proxy_call (ref proxy_call);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Report> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Report (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Fetching a user's reports asynchronously
    public async List<Report> get_reports_async () throws Error {
      
      Error error = null;
      var list = new List<Report> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_reports_proxy_call (ref proxy_call);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Report (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_reports_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Searching for content
    public Results search (string q, bool resolve) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_search_proxy_call (ref proxy_call, q, resolve);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Results (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Searching for content asynchronously
    public async Results search_async (string q, bool resolve) throws Error {
      
      Error error = null;      
      Results results = null;
      
      var proxy_call = proxy.new_call ();
      setup_search_proxy_call (ref proxy_call, q, resolve);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          results = new Results (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        search_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return results;
    }
    
    // Fetching a status
    public Status get_status (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_status_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Status (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Fetching a status asynchronously
    public async Status get_status_async (int64 id) throws Error {
      
      Error error = null;      
      Status status = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_status_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          status = new Status (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_status_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return status;
    }
    
    // Getting status context
    public Context get_context (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_context_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Context (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting status context asynchronously
    public async Context get_context_async (int64 id) throws Error {
      
      Error error = null;      
      Context context = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_context_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          context = new Context (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_context_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return context;
    }

    // Getting a card associated with a status
    public Card get_card (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_card_proxy_call (ref proxy_call, id);
      
      try{
        
        proxy_call.run();
        
        var json_obj = parse_json_object (proxy_call.get_payload());
        return new Card (json_obj);
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting a card associated with a status asynchronously
    public async Card get_card_async (int64 id) throws Error {
      
      Error error = null;      
      Card card = null;
      
      var proxy_call = proxy.new_call ();
      setup_get_card_proxy_call (ref proxy_call, id);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_obj = parse_json_object (proxy_call.get_payload());
          card = new Card (json_obj);
          
        } catch (Error e) {
          error = e;
        }
        
        get_card_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return card;
    }
    
    // Getting who reblogged a status
    public List<Account> get_reblogged_by (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_reblogged_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting who reblogged a status asynchronously
    public async List<Account> get_reblogged_by_async (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_reblogged_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_reblogged_by_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Getting who favourited a status
    public List<Account> get_favourited_by (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_favourited_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Account> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Account (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting who favourited a status asynchronously
    public async List<Account> get_favourited_by_async (int64 id, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_favourited_by_proxy_call (ref proxy_call, id, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Account (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_favourited_by_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Retrieving home timeline
    public List<Status> get_home_timeline (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_home_timeline_proxy_call (ref proxy_call, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Retrieving home timeline asynchronously
    public async List<Status> get_home_timeline_async (int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_home_timeline_proxy_call (ref proxy_call, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_home_timeline_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Retrieving public timeline
    public List<Status> get_public_timeline (bool local = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_public_timeline_proxy_call (ref proxy_call, local, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Retrieving public timeline asynchronously
    public async List<Status> get_public_timeline_async (bool local = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_public_timeline_proxy_call (ref proxy_call, local, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_public_timeline_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }
    
    // Retrieving htag timeline
    public List<Status> get_tag_timeline (string hashtag, bool local = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_tag_timeline_proxy_call (ref proxy_call, hashtag, local, max_id, since_id, limit);
      
      try{
        
        proxy_call.run();
        
        var json_array = parse_json_array (proxy_call.get_payload());
        var list = new List<Status> ();
        
        json_array.foreach_element ((array, index, node) => {
          list.append (new Status (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Retrieving hashtag timeline asynchronously
    public async List<Status> get_tag_timeline_async (string hashtag, bool local = false, int64 max_id = -1, int64 since_id = -1, int limit = -1) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_tag_timeline_proxy_call (ref proxy_call, hashtag, local, max_id, since_id, limit);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Status (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_tag_timeline_async.callback ();
        
      });

      yield;
      
      if (error != null) {
        throw error;
      }
      
      return (owned) list;
    }

    // Set proxy params to oauth
    private void setup_oauth_proxy_call (ref ProxyCall proxy_call, string email, string password, string scope) {
      
      proxy_call.add_params (PARAM_CLIENT_ID, _client_id, PARAM_CLIENT_SECRET, _client_secret, PARAM_GRANT_TYPE, "password", PARAM_USERNAME, email, PARAM_PASSWORD, password, PARAM_SCOPE, scope);
      proxy_call.set_function (ENDPOINT_OAUTH_TOKEN);
      proxy_call.set_method ("POST");
    }
    
    // Set proxy params to get an account
    private void setup_get_account_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_ACCOUNTS.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get followers
    private void setup_get_followers_proxy_call (ref ProxyCall proxy_call, int64 id, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_FOLLOWERS.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get following
    private void setup_get_following_proxy_call (ref ProxyCall proxy_call, int64 id, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_FOLLOWING.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get statuses
    private void setup_get_statuses_proxy_call (ref ProxyCall proxy_call, int64 id, bool only_media, bool exclude_replies, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      
      if (only_media) {
        proxy_call.add_param (PARAM_ONLY_MEDIA, only_media.to_string ());
      }
      if (exclude_replies) {
        proxy_call.add_param (PARAM_EXCLUDE_REPLIES, exclude_replies.to_string ());
      }
      
      proxy_call.set_function(ENDPOINT_ACCOUNTS_STATUSES.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to search accounts
    private void setup_search_accounts_proxy_call (ref ProxyCall proxy_call, string q, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.add_param (PARAM_Q, q);
      
      if (limit >= 0) {
        proxy_call.add_param (PARAM_LIMIT, limit.to_string ());
      }
      
      proxy_call.set_function(ENDPOINT_ACCOUNTS_SEARCH);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch blocks
    private void setup_get_blocks_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_BLOCKS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch favoutites
    private void setup_get_favoutrites_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_FAVOURITES);
      proxy_call.set_method("GET");
    
    }

    // Set proxy params to fetch follow requests
    private void setup_get_follow_requests_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_FOLLOW_REQUESTS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to verify credentials
    private void setup_verify_credentials_proxy_call (ref ProxyCall proxy_call) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_VERIFY_CREDENTIALS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get instance information
    private void setup_get_instance_proxy_call (ref ProxyCall proxy_call) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_INSTANCE);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch mutes
    private void setup_get_mutes_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_MUTES);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch notifications
    private void setup_get_notifications_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_NOTIFICATIONS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get a single notification
    private void setup_get_notification_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_NOTIFICATION.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch reports
    private void setup_get_reports_proxy_call (ref ProxyCall proxy_call) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_REPORTS);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to search for content
    private void setup_search_proxy_call (ref ProxyCall proxy_call, string q, bool resolve) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_SEARCH);
      proxy_call.add_param (PARAM_Q, q);
      proxy_call.add_param (PARAM_RESOLVE, resolve.to_string ());
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to fetch a status
    private void setup_get_status_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_STATUSES.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get status context
    private void setup_get_context_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_STATUSES_CONTEXT.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get a card associated with status
    private void setup_get_card_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_STATUSES_CARD.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get who reblogged a status
    private void setup_get_reblogged_by_proxy_call (ref ProxyCall proxy_call, int64 id, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_STATUSES_REBLOGGED_BY.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get who favourited a status
    private void setup_get_favourited_by_proxy_call (ref ProxyCall proxy_call, int64 id, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_STATUSES_FAVOURITED_BY.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get home timeline
    private void setup_get_home_timeline_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.set_function(ENDPOINT_TIMELINES_HOME);
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get public timeline
    private void setup_get_public_timeline_proxy_call (ref ProxyCall proxy_call, bool local, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.add_param (PARAM_LOCAL, local.to_string ());
      proxy_call.set_function(ENDPOINT_TIMELINES_PUBLIC);

      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get tag timeline
    private void setup_get_tag_timeline_proxy_call (ref ProxyCall proxy_call,string hashtag, bool local, int64 max_id, int64 since_id, int limit) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      set_ids_and_limit_to_proxy_call (ref proxy_call, max_id, since_id, limit);
      proxy_call.add_param (PARAM_LOCAL, local.to_string ());
      proxy_call.set_function(ENDPOINT_TIMELINES_TAG.printf (hashtag));
      proxy_call.set_method("GET");
    
    }
    
    // Generate a soup message to get relatiopnships
    private Soup.Message relationships_message_new (int64[] ids) {
      
      var message = new Soup.Message ("GET", _website + ENDPOINT_ACCOUNTS_RELATIONSHIPS);
      var sb = new StringBuilder ();
      
      int i = 0;
      foreach (int64 id in ids) {
        sb.append (PARAM_ID);
        sb.append ("[]=");
        sb.append (id.to_string ());
        if (++i < ids.length) {
          sb.append ("&");
        }
      }
      
      message.request_headers.append ("Authorization"," Bearer " + _access_token);
      message.set_request ("application/x-www-form-urlencoded", Soup.MemoryUse.COPY, sb.str.data);
      
      return message;
    
    }
    
    private void set_ids_and_limit_to_proxy_call (ref ProxyCall proxy_call, int64 max_id, int64 since_id, int limit) {
      
      if (max_id >= 0) {
        proxy_call.add_param (PARAM_MAX_ID, max_id.to_string ());
      }
      if (since_id >= 0) {
        proxy_call.add_param (PARAM_SINCE_ID, since_id.to_string ());
      }
      if (limit >= 0) {
        proxy_call.add_param (PARAM_LIMIT, limit.to_string ());
      }
      
    }
  }
}
