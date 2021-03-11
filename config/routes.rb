Rails.application.routes.draw do



  # Routes for the Study block resource:

  # CREATE
  post("/insert_study_block", { :controller => "study_blocks", :action => "create" })
          
  # READ
  get("/study_blocks", { :controller => "study_blocks", :action => "index" })
  
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
  get("/followers", { :controller => "followers", :action => "index" })
  
  get("/followers/:path_id", { :controller => "followers", :action => "show" })
  
  # UPDATE
  
  post("/modify_follower/:path_id", { :controller => "followers", :action => "update" })
  
  # DELETE
  get("/delete_follower/:path_id", { :controller => "followers", :action => "destroy" })

  #------------------------------

end
