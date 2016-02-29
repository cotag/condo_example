# This migration comes from condo_active_record (originally 20111001022500)
class Init < ActiveRecord::Migration
    def change
        #
        # Create the table for storing the uploads currently being processed
        #
        create_table :condo_uploads do |t|
            t.string    :user_id,                :allow_null => false
            
            t.string    :file_name,              :allow_null => false
            t.integer   :file_size,              :allow_null => false
            t.string    :file_id
            t.text      :custom_params
            
            t.string    :provider_namespace
            t.string    :provider_name,          :allow_null => false
            t.string    :provider_location,      :allow_null => false
            
            t.string    :bucket_name,            :allow_null => false
            t.string    :object_key,             :allow_null => false
            t.text      :object_options
            
            t.string    :resumable_id
            t.boolean   :resumable,              :allow_null => false, :default => false
            
            t.timestamps    # date_created needs to be defined
        end
    end
end
