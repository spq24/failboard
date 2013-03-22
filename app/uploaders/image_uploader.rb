# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:

  # storage :file
  storage :fog

  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  after :store, :zencode

  def store_dir
    "failboard/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "video.mp4" if original_filename
  end



  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
   # version :medium do
    # process :resize_to_limit => [320, 240]
  # end 

  # version :thumb do
   #  process :scale => [240, 350]
   #end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     %w(jpg jpeg gif png mp4 mov avi mkv wmv mpg)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end


   private 
 
  def zencode(args)
    if self.version_name.nil?
      bucket = ImageUploader.fog_directory
      input = "https://failboard.s3.amazonaws.com/failboard/fail/image/#{@model.id}/video.mp4"
      base_url = "https://failboard.s3.amazonaws.com/failboard/fail/image/#{@model.id}"
     
    zencoder_response = Zencoder::Job.create({
      :input => input,
      :output => [{
        :base_url => base_url,
        :filename => "video.mp4",
        :label => "web",
        :video_codec => "h264",
        :audio_codec => "aac",
        :quality => 3,
        :width => 854,
        :height => 480,
        :format => "mp4",
        :aspect_mode => "preserve",
        :public => 1
      }]
    })

    end
 
    zencoder_response.body["outputs"].each do |output|
      if output["label"] == "web"
        @model.zencoder_output_id = output["id"]
        @model.processed = false
        @model.save(:validate => false)
      end
    end
  end

end
