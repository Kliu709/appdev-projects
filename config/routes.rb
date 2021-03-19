Rails.application.routes.draw do


  get("/", {:controller => "study_blocks", :action => "index"})
  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  # Routes for the Study block resource:

  # CREATE
  post("/insert_study_block", { :controller => "study_blocks", :action => "create" })
          
  # READ
 #get("/study_blocks", { :controller => "study_blocks", :action => "index" })
  
  get("/study_blocks/:path_id", { :controller => "study_blocks", :action => "show" })
  
  # UPDATE
  
  post("/modify_study_block/:path_id", { :controller => "study_blocks", :action => "update" })
  
  # DELETE
  get("/delete_study_block/:path_id", { :controller => "study_blocks", :action => "destroy" })

  #------------------------------

  # Routes for the Follower resource:

  # CREATE
  post("/insert_follower", { :controller => "followers", :action => "create" })
          
  # READ
  #get("/followers", { :controller => "followers", :action => "index" })
  
  get("/followers/:path_id", { :controller => "followers", :action => "show" })
  
  # UPDATE
  
  post("/modify_follower/:path_id", { :controller => "followers", :action => "update" })
  
  # DELETE
  get("/delete_follower/:path_id", { :controller => "followers", :action => "destroy" })

  #------------------------------

end
