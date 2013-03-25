# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  VIDEOS = {web: 'mp4', open: 'webm' }
  include Rails.application.routes.url_helpers
  Rails.application.routes.default_url_options = ActionMailer::Base.default_url_options
 

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
   include Sprockets::Helpers::RailsHelper
   include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:

  # storage :file
  storage :fog

  after :store, :zencode

  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:


  def store_dir
    "failboard/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
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

  # uploads a an exact copy (different extention) of originial to S3 for Zencoder to encode
  version :mp4, :if => :is_video? do
    def full_filename(for_file)
      "#{File.basename(for_file, File.extname(for_file))}.mp4"
    end
  end
  # uploads a an exact copy (different extention) of originial to S3 for Zencoder to encode
  version :webm, :if => :is_video? do
    def full_filename(for_file)
      "#{File.basename(for_file, File.extname(for_file))}.webm"
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     %w(mov avi mp4 mkv wmv mpg jpg gif png)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def is_image?(fail)
    if fail.content_type.match(/image\/jpeg|image\/gif|image\/png|image\/pjpeg|image\/jpg/i)
      return true
    else
      return false
    end
  end
 
  def is_video?(fail)
    if fail.content_type.match(/video/i)
      return true
    else
      return false
    end
  end


  private 
 
  def zencode(args)
    if self.version_name.nil?
      bucket = ImageUploader.fog_directory
      input = "s3://#{bucket}/#{self.path}"
      base_url = "s3://#{bucket}/#{store_dir}"
     
      filename = File.basename(self.path)
      ext = File.extname(self.path)
      outputs = []
      VIDEOS.each do |key, value|
        outputs << {
          :base_url => base_url,
          :filename => filename.gsub(ext, '.' + value),
          :label => key,
          :format => value,
          :aspect_mode => "preserve",
          :width => 854,
          :height => 480,
          :public => 1
        }
      end

    end
 
      zencoder_response = Zencoder::Job.create({
        :input => input,
        # callback on the JOB completion!
        :notifications => [zencoder_callback_url(:protocol => 'http')],
        :output => outputs
      })
 
      @model.job_id = zencoder_response.body["id"].to_s
      @model.item_processing = true
      @model.save(:validate => false)
  end

end
