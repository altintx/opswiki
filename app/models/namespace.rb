class Namespace < ActiveRecord::Base
	has_many :pages
	has_many :permissions, :conditions => [
		"model = 'Namespace'"],
		:foreign_key => 'fk'
	# has_many :permissions, -> { where model: "Namespace" }, foreign_key: "fk", class_name: "Permission"

	def allowed (user, ability) 
		if user
			if !self.permissions
				true
			else
				self.permissions.to_a.find_all{ |permission| permission.ldap_user == user.login }.find_all{ |perm| perm.ability.include? ability }.length > 0
			end
		else
			if !self.permissions
				false
			else
				self.permissions.to_a.find_all{ |permission| permission.ldap_user == '*' }.find_all{ |perm| perm.ability.include? ability }.length > 0
			end
		end
	end
end
