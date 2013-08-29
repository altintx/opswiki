class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable
  def namespaces
  	Namespace.where(id: Permission.where(model: 'Namespace', ldap_user: self.login).to_a.find_all{|perm| perm.ability.include? 'C' }.map{|perm| perm.fk })
  end
end
