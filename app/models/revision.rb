class Revision < ActiveRecord::Base
	belongs_to :page
	belongs_to :parent_revision, class_name: "Revision"
end
