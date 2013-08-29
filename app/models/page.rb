class Page < ActiveRecord::Base
	has_many :revisions
	belongs_to :revision
	belongs_to :namespace
	#has_and_belongs_to_many :tags
end
