class PagesController < ApplicationController
  def default
    redirect_to page_path('Main Page')
  end

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
    @page.title = params[:title]
    if !current_user 
      flash[:error] = "Anonymous users cannot create pages"
      return redirect_to new_user_session_path
    end
    @namespaces = current_user.namespaces
    if @namespaces.length == 0
      flash[:error] = "You don't have access to any namespaces."
      redirect_to namespaces_path
    end
  end

  def create
    @page = Page.new page_params
    if @page.save
      @revision = Revision.new
      @revision.ldap_editor = current_user.login
      @revision.page = @page
      @revision.changelog = "New page"
      @revision.text = ""
      @revision.save
      @page.revision = @revision;
      @page.alias = @page.title.to_slug.normalize.to_s
      @page.save
      redirect_to page_path(@page)
    else
      @namespaces = Namespace.all
      render :action => 'new'
    end
  end

  def edit
    @page = Page.find params[:id]
  end

  def update
    @page = Page.find params[:id]
    if @page.update_attributes page_params
      redirect_to page_path(@page)
    else
      render :action => :edit
    end
  end

  def destroy
    @page = Page.find params[:id]
    @page.destroy
    redirect_to pages_path
  end

  def show
    # if params[:id].is_a? Fixnum
    if params[:id].to_i > 0
      @page = Page.find params[:id]
      redirect_to page_path(@page.alias)
    else
      @page = Page.find_by alias: params[:id].to_slug.normalize.to_s
      if (@page)
        if params[:id] != @page.alias
          redirect_to page_path(@page.alias)
        end
      end
    end
    if @page
      @wiki = WikiCloth::Parser.new({
        :data => @page.revision.text,
        :params => {} })
    else
      # redirect_to new_page_path
      @page = Page.new
      @page.title = params[:id]
      @wiki = WikiCloth::Parser.new({
        :data => "This page does not exist. You could [[new?title=" + params[:id] + "|create it]]" })
    end
  end

  def search
    @pages = Page.where("LOWER(title) LIKE '%" + params[:q] + "%'")
    @term = params[:q]
    render "index"
  end

  def page_params
    params.require(:page).permit(:title, :namespace_id, :revision_id)
  end
end
