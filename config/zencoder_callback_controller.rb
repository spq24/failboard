class ZencoderCallbackController < ApplicationController
 
  skip_before_filter :verify_authenticity_token
 
  def create
    job_id = params["job"]["id"]
    job_state = params["job"]["state"]
 
    video = Fail.find_by_job_id(job_id.to_s)
    if job_state == "finished" && video
      video.item_processing = false
      video.save
    end
 
    render :nothing => true
  end
 
end