# This migration comes from condo_active_record (originally 20111106022500)
class Filepath < ActiveRecord::Migration
	def up
		add_column		:condo_uploads, :file_path, :text
	end
	
	def down
		remove_column	:condo_uploads, :file_path
	end
end
