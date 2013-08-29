class RevisionsController < ApplicationController
	def index
		if params[:page]
			@revisions = Revision.where(:page_id => params[:page]).order("created_at DESC")
			@page = Page.find(params[:page])
		else
			@revisions = Revision.all.order("created_at DESC")
			@page = Page.new
			@page.title = "All Edits"
		end
	end

	def show
		@revision = Revision.find(params[:id])
        @wiki = WikiCloth::Parser.new({
        	:data => @revision.text,
        	:params => {} })
	end

	def new
		@revision = Revision.new
		@revision.parent_revision = Revision.find(params[:revision])
		@revision.text = @revision.parent_revision.text
		@revision.page_id = @revision.parent_revision.page_id
	end

	def create
		@revision = Revision.new revisions_params
		if @revision.save
			@revision.ldap_editor = current_user.login
			@revision.save
			@page = Page.find @revision.page_id
			@page.revision = @revision
			@page.save
			redirect_to page_path(@revision.page_id)
		else
			@revision.parent_revision = Revision.find(@revision.parent_revision_id)
			render :action => "new"
		end

	end

	def revisions_params
	    params.require(:revision).permit(:text, :parent_revision_id, :page_id, :changelog)
	end
end
