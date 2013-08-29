class PermissionsController < ApplicationController
  def index
  	if params[:namespace]
  		@permissions = Permission.where(:fk => params[:namespace], :model => "Namespace").order("ldap_user ASC")
  	else
  		@permissions = Permission.all
  	end
  end

  def new
    @permission = Permission.new
    @namespaces = Namespace.all
  end

  def create
    @permission = Permission.new permission_params
    @permission.model = 'Namespace'
    @permission.fk = params[:namespace_id]
    if @permission.save
      redirect_to permissions_path
    else
      flash[:error] = "Unable to create permission"
      @namespaces = Namespace.all
      render :action => 'new'
    end
  end

  def edit
    @permission = Permission.find params[:id]
  end

  def update
    @permission = Permission.find params[:id]
    if @permission.update_attributes permission_params
      redirect_to permissions_path(:namespace => @permission.fk)
    else
      render :action => :edit
    end
  end

  def destroy
    @permission = Permission.find params[:id]
    @permission.destroy
    redirect_to permissions_path
  end

  def show
    @permission = Permission.find params[:id]
  end

  def permission_params
    params.require(:permission).permit(:ldap_user, :model, :fk, :ability)
  end
end
