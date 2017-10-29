class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  # GET /notes/1
  # GET /notes/1.json
  def view
    @note = Note.find_by slug: params[:id];
    if @note!=nil
      @note.destroy
      @msg=@note.msg;
    else
      @msg="No such note!"
    end  
    render "note_info"
  end

  # GET /notes/new
  def new
    @urlsafe=SecureRandom.urlsafe_base64(32)
    @note = Note.new({msg: params[:content], slug: @urlsafe})
    @note.save
    render "link_info" 
  end
end
