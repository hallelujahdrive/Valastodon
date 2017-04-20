using Json;
using Rest;

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
    public List<Account> get_followers (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_followers_proxy_call (ref proxy_call, id);
      
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
    public async List<Account> get_followers_async (int64 id) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_followers_proxy_call (ref proxy_call, id);
      

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
    public List<Account> get_following (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_following_proxy_call (ref proxy_call, id);
      
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
    public async List<Account> get_following_async (int64 id) throws Error {
      
      Error error = null;
      var list = new List<Account> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_following_proxy_call (ref proxy_call, id);
      

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
    public List<Status> get_statuses (int64 id) throws Error {
      
      var proxy_call = proxy.new_call ();
      setup_get_statuses_proxy_call (ref proxy_call, id);
      
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
    public async List<Status> get_statuses_async (int64 id) throws Error {
      
      Error error = null;
      var list = new List<Status> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_statuses_proxy_call (ref proxy_call, id);
      

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
      
      var proxy_call = proxy.new_call ();
      setup_get_relationships_proxy_call (ref proxy_call, ids);
      
      try{
        
        proxy_call.run();
        
        var data = proxy_call.get_payload();

        var json_array = parse_json_array (data);
        var list = new List<Relationship> ();
                
        json_array.foreach_element ((array, index, node) => {
          list.append (new Relationship (node.get_object ()));
        });
        
        return (owned) list;
        
      }catch(Error e){
        throw e;
      }
    }
    
    // Getting an account's relationships asynchronously
    public async List<Relationship> get_relationships_async (int64[] ids) throws Error {
      
      Error error = null;
      var list = new List<Relationship> ();
      
      var proxy_call = proxy.new_call ();
      setup_get_relationships_proxy_call (ref proxy_call, ids);
      

      proxy_call.invoke_async.begin (null, (obj, res) => {
        try {
        
          proxy_call.invoke_async.end (res);
          
          var json_array = parse_json_array (proxy_call.get_payload());
          
          json_array.foreach_element ((array, index, node) => {
            list.append (new Relationship (node.get_object ()));
          });
          
        } catch (Error e) {
          error = e;
        }
        
        get_relationships_async.callback ();
        
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
    private void setup_get_followers_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_FOLLOWERS.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get following
    private void setup_get_following_proxy_call (ref ProxyCall proxy_call, int64 id) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_FOLLOWING.printf (id));
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to get statuses
    private void setup_get_statuses_proxy_call (ref ProxyCall proxy_call, int64 id, bool? only_media = false, bool? exclude_replies = false) {
      
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
    
    // Set proxy params to get relatiopnships
    private void setup_get_relationships_proxy_call (ref ProxyCall proxy_call, int64[] ids) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_RELATIONSHIPS);
      
      if (ids != null) {
        // 配列を渡せないので保留
        proxy_call.add_param (PARAM_ID + "");
      }
      
      proxy_call.set_method("GET");
    
    }
    
    // Set proxy params to verify credentials
    private void setup_verify_credentials_proxy_call (ref ProxyCall proxy_call) {
      
      proxy_call.add_header ("Authorization"," Bearer " + _access_token);
      proxy_call.set_function(ENDPOINT_ACCOUNTS_VERIFY_CREDENTIALS);
      proxy_call.set_method("GET");
    
    }
  }
}
