class NamespacesController < ApplicationController
  def index
    @namespaces = Namespace.all
  end

  def new
    @namespace = Namespace.new
  end

  def create
    @namespace = Namespace.new namespace_params
    if @namespace.save
      @permission = Permission.new
      @permission.ldap_user = current_user.login
      @permission.model = 'Namespace'
      @permission.fk = @namespace.id
      @permission.ability = 'CRUD'
      if @permission.save
        redirect_to namespaces_path
      else
        flash[:error] = "Unable to save"
        render :action => 'new'
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @namespace = Namespace.find params[:id]
  end

  def update
    @namespace = Namespace.find params[:id]
    if @namespace.update_attributes namespace_params
      redirect_to namespaces_path
    else
      render :action => :edit
    end
  end

  def destroy
    @namespace = Namespace.find params[:id]
    @namespace.destroy
    redirect_to namespaces_path
  end

  def show
    @namespace = Namespace.find params[:id]
  end

  def namespace_params
    params.require(:namespace).permit(:name, :support)
  end
end

