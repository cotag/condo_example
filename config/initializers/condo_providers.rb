

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
# NOTE:: Whilst this provider could technically work,
#		Rackspace currently ignores preflight requests so this doesn't work at all
#
#Condo::Configuration.add_residence(:RackspaceCloudFiles, {
#	:username => ENV['RACKS_KEY'],
#	:secret_key => ENV['RACKS_SECRET']
#})


