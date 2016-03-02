# encoding: utf-8

require 'condo'
require 'condo_active_record'

#
# Define the various storage providers you would like to upload to here.
#
# NOTE:: The first definition is treated as the default.
#     It is possible to dynamically set the provider from the controller without configuring anything here
# => http://www.elastician.com/2009/12/comprehensive-list-of-aws-endpoints.html
#
Condo::Configuration.add_residence(:AmazonS3, {
    :access_id => ENV['S3_KEY'],
    :secret_key => ENV['S3_SECRET']#,
    #:location => 'ap-southeast-1'
})


#
# Enable if you would like to use this provider
# => Google does not yet support parallel uploads. (only resumable)
#
=begin
Condo::Configuration.add_residence(:GoogleCloudStorage, {
    :access_id => ENV['GOOGLE_KEY'],
    :secret_key => ENV['GOOGLE_SECRET']
})
=end

#
# Enable this if you would like to use v2 of Google's storage API (https://developers.google.com/storage/docs/accesscontrol#Signed-URLs)
# => Convert cert to PEM: openssl pkcs12 -in file/name.p12 - nodes -nocerts > out/put.pem
# => NOTE:: The password is: notasecret
#
=begin
Condo::Configuration.add_residence(:GoogleCloudStorage, {
    :access_id => ENV['GOOGLE_KEY'],            # Service account email
    :secret_key => File.read('google.pem'),        # Private key in pem format (don't use this location ;)
    :api => 2
})
=end


#
# Enable this if you would like to use Rackspace Cloud Files or OpenStack Swift.
# => Enable CORS http://docs.rackspace.com/files/api/v1/cf-devguide/content/CORS_Container_Header-d1e1300.html
#
=begin
Condo::Configuration.add_residence(:OpenStackSwift, {
    :username => ENV['RACKS_KEY'],

    # This is the API key
    :secret_key => ENV['RACKS_SECRET'],

    # Something like (MossoCloudFS_abf330f5-5f4e-48be-9993-b5dxxxxxx)
    # Basically your account identifier
    :storage_url => ENV['RACKS_STORAGE_URL'],
    :temp_url_key => ENV['RACKS_TEMP_URL_KEY']
})
=end

=begin
Condo::Configuration.add_residence(:MicrosoftAzure, {
    :account_name => ENV['AZURE_STORAGE_ACCOUNT'],
    :access_key => ENV['AZURE_STORAGE_ACCESS_KEY'] #,
    #:blob_host => 'http://127.0.0.1:10000/' # For dev
})
=end
