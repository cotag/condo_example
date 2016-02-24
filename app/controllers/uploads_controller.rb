class UploadsController < ApplicationController
	include Condo
	
	
	
	#
	# These are not defined by Condo
	# => Standard observers and filters can be used for auth, logging etc
	#
	def index
		
	end
	
	def show
		
	end
	
	
	
	
	#
	# START required call-backs:-------------------
	# Note:: All call-backs are executed in the context of the current request
	#
	
	
	
	#
	# This is a request for the current user_id
	# => Return nil if there is no valid session or logged in user etc
	#
	condo_callback :resident_id, proc {
		session[:user] || :anonymous
	}	# session[:user] # for instance
	
	#
	# Note:: This should store a reference to the file in the applications database
	# => Should return true (via coercion) if the reference was stored
	# => Return nil or false if something failed
	#
	# It is up to you to destroy the upload reference
	#
	condo_callback :upload_complete do |upload|
		upload.destroy
		true
	end
	
	#
	# Note:: This should actually be scheduled as a background task (to be executed at a time greater then the signed request - i.e. 5min from now)
	#			Very important that this task is retried until it succeeds, otherwise left with a dangling upload
	#
	# => Should return true (via coercion, if the task was scheduled or file destroyed successfully) and the upload reference will be destroyed
	# => Return nil or false if something failed and the upload reference will be maintained
	#
	condo_callback :destroy_upload, lambda { |upload|
		#
		# Delete file from cloud files using Fog (SHOULD NOT DO THIS IN PRODUCTION - USE A BACKGROUND TASK)
		#
		current_residence.destroy(upload)
		return true
	}
	
	
	
	
	#
	# END required call-backs:-------------------
	#
	
	
	#
	# START Recommended Call-backs:-------------------
	#
	
	
	
	#
	# Used to check if an upload should be allowed before a signature is generated
	# => Note:: At this point the user has already been validated and the filename has been normalised
	# => Of course this doesn't guarantee the user is uploading valid data.
	#
	condo_callback :pre_validation, lambda { |*args|
		#
		# Check the file type is valid: params[:upload][:file_name]
		# Check the file size is valid: params[:upload][:file_size]
		# etc
		#
		
		#
		# Note: We used lambda as we want to be able to return errors via: return false, {:errors => {:param_name => 'wtf are you doing?'}}
		#
		return true	# Here we are just allowing all file sizes and types etc (this is the default)
		#return false, {:errors => {:param_name => 'wtf are you doing?'}}
	}
	
	#
	# Should return the bucket name for the current user (or the bucket you are using for the application)
	# => You probably want to create the bucket as a background task on user sign-up etc
	#
	condo_callback :bucket_name, proc {
		'acasignage'	# "#{Rails.application.class.parent_name}#{current_resident}"	# this is the default
	}
	
	#
	# The name of the file when saved on the cloud storage system
	# => Note:: The default is params[:upload][:file_name] after being normalised
	#
	condo_callback :object_key, proc {
		"#{Time.now.to_f.to_s.sub('.', '')}#{rand(1000)}#{File.extname(params[:file_name])}"
	}
	
	
	
	
	
	#
	# END Recommended Call-backs:-------------------
	#
	
	
	#
	# START Optional Call-backs: (These are the defaults)
	#
	
	
	
	
	#
	# Set object options - you can set provider specific options here too
	#
	condo_callback :object_options, proc {
		{:permissions => :private}	# Objects are private by default, maybe you would like them to be public?
	}
	
	
	#
	# Maybe you want to do this differently?
	#
	condo_callback :sanitize_filename do |filename|
		filename = filename.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
		filename.gsub!(/^.*(\\|\/)/, '')	# get only the filename (just in case)
		filename.gsub!(/[^\w\.\-]/, '_')	# replace all non alphanumeric or periods with underscore
		filename
	end
	
	
	#
	# END Optional Call-backs:-------------------
	#
	
end
