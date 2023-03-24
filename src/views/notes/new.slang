- if note.errors
  ul.errors
    - note.errors.each do |error|
      li = error.to_s

== form(action: "/notes/#{note.id.to_s}", method: note.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:book)
    == select_field(name: "book_id", collection: Book.where(user_id: current_user.try &.id, is_system: false).map{|book| [book.id, book.title]}, selected: params[:book_id]?, class: "form-control")
  .form-group
    == text_area(name: "title", content: note.title, placeholder: "Title", class: "form-control")
  .form-group
    == text_area(name: "tags", content: "" , placeholder: "Tags", class: "form-control")
  .form-group
    == text_area(name: "body", content: note.body, placeholder: "Body", class: "form-control", size: "30x10")
  == submit("Submit", class: "btn btn-success btn-sm")
  == link_to("Back", "/notes", class: "btn btn-light btn-sm")

