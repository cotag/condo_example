

require 'condo'
require 'condo_active_record'
require 'condo/strata/amazon_s3'

#
# Define the various storage providers you would like to upload to here.
#	15 Oct 2012 - Amazon S3 is the only fully featured provider
#
# NOTE:: The first definition is treated as the default.
# 	It is possible to dynamically set the provider from the controller without configuring anything here
# => http://www.elastician.com/2009/12/comprehensive-list-of-aws-endpoints.html
#
Condo::Configuration.add_residence(:AmazonS3, {
	:access_id => ENV['S3_KEY'],
	:secret_key => ENV['S3_SECRET']#,
	#:location => 'ap-southeast-1'
})


#
# Enable if you would like to use this provider
# => Google does not yet support resumables with CORS so only useful for smallish uploads
#
#Condo::Configuration.add_residence(:GoogleCloudStorage, {
#	:access_id => ENV['GOOGLE_KEY'],
#	:secret_key => ENV['GOOGLE_SECRET']
#})


#
# Enable this if you would like to use v2 of Google's storage API (https://developers.google.com/storage/docs/accesscontrol#Signed-URLs)
# => Convert cert to PEM: openssl pkcs12 -in file/name.p12 - nodes -nocerts > out/put.pem
# => NOTE:: The password is: notasecret
#
#Condo::Configuration.add_residence(:GoogleCloudStorage, {
#	:access_id => ENV['GOOGLE_KEY'],			# Service account email
#	:secret_key => File.read('google.pem'),		# Private key in pem format (don't use this location ;)
#	:api => 2
#})


#
# Enable this if you would like to use Rackspace Cloud Files.
# => Enable CORS http://docs.rackspace.com/files/api/v1/cf-devguide/content/CORS_Container_Header-d1e1300.html
#
#Condo::Configuration.add_residence(:RackspaceCloudFiles, {
#	:username => ENV['RACKS_KEY'],
#	:secret_key => ENV['RACKS_SECRET']  # This is the API key
#})
