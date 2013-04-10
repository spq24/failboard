module FailsHelper

def youtube_embed(youtube_url)
  if youtube_url[/youtu\.be\/([^\?]*)/]
    youtube_id = $1
  else
    youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
    youtube_id = $5
  end

  %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
end

def parse_youtube url
   regex = /^(?:http:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
   url.match(regex)[1]
end

end
