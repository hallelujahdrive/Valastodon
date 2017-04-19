void get_following () {
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 account_id = load_account_id ();
    
  var app = new Gomphoterium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  try {
    
    var list = app.get_following (account_id);
    
    list.foreach ((account) => {
      output_account (account);
    });
    
  } catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
}

void get_following_async () {
  
  var loop = new MainLoop ();
  
  string website = load_website ();
  string[] ci_cs = load_ci_cs ();
  string access_token = load_access_token ();
  int64 account_id = load_account_id ();
    
  var app = new Gomphoterium.GomphoApp (website, ci_cs[0], ci_cs[1], access_token);
  
  stdout.printf ("begin function\n");
  app.get_following_async.begin (account_id, (obj, res) => {
    stdout.printf ("\nbegin async method");
    try{
      var list = app.get_following_async.end (res);
      
      list.foreach ((account) => {
        output_account (account);
      });
      
      stdout.printf ("\nend async method\n");
    }catch (Error e) {
      stderr.printf ("%s\n", e.message);
    }
    loop.quit();
  });
  stdout.printf ("end function\n");
  loop.run ();
}


void output_account (Gomphoterium.Account account) {
  
  stdout.printf ("""
  id : %""" + int64.FORMAT + """
  username : %s
  acct : %s
  display_name : %s
  locked : %s
  created_at : %s
  followers_count : %""" + int64.FORMAT + """
  following_count : %""" + int64.FORMAT + """
  statuses_count : %""" + int64.FORMAT + """
  note : %s
  url : %s
  avatar : %s
  avatar_static : %s
  header : %s
  header_static %s
  """, account.id, account.username, account.acct, account.display_name,
  account.locked.to_string (), account.created_at, account.followers_count, account.following_count,
  account.statuses_count, account.note, account.url, account.avatar,
  account.avatar_static, account.header, account.header_static);
}

string load_website () {
  string read = "";
  try {
    string filename = "website.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return read.replace ("\n", "");
}

string[] load_ci_cs () {
  string[] ci_cs = new string[2];
  try {
    string filename = "ci_cs.txt";
    var file = File.new_for_path (filename);
    
    var dis = new DataInputStream (file.read ());
    
    int i = 0;
    string line;
    while ((line = dis.read_line (null)) != null && i < 2) {
      ci_cs[i++] = line.split (":")[1];
    }

} catch (Error e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return ci_cs;
}

string load_access_token () {
  string read = "";
  try {
    string filename = "access_token.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return read.split (":")[1].replace ("\n", "");
}

int64 load_account_id () {
  string read = "";
  try {
    string filename = "account_id.txt";

    FileUtils.get_contents (filename, out read);

} catch (FileError e) {
    stderr.printf ("%s\n", e.message);
  }
  
  return int64.parse (read.split (":")[1].replace ("\n", ""));
}

int main (string[] args) {
  GLib.Test.init (ref args);
  
  GLib.Test.add_func ("/getfollowing/get_following", get_following);
  GLib.Test.add_func ("/getfollowing/get_following_async", get_following_async);
  
  return GLib.Test.run ();
}


