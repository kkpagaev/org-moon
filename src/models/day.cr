class Day < Granite::Base
  connection pg
  table days

  column(note_id : Int64 | ::Nil)

  def note : Note | ::Nil
    if parent = Note.find_by(id: note_id)
      parent
    else
      Note.new title: date, body: "# #{date}  \n#Monday  \n"
    end
  end

  def note! : Note
    Note.find_by!(id: note_id)
  end

  def note=(parent : Note)
    @note_id = parent.id
  end

  # K to see macro result
  belongs_to :user

  column id : Int64, primary: true
  column date : String
  timestamps
end
