- if notes.errors
  ul.errors
    - notes.errors.each do |error|
      li = error.to_s

== form(action: "/notes/#{notes.id.to_s}", method: notes.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:user)
    == select_field(name: "user_id", collection: User.all.map{|user| [user.id, user.id]}, selected: notes.user_id, class: "form-control")
  .form-group
    == label(:book)
    == select_field(name: "book_id", collection: Book.all.map{|book| [book.id, book.id]}, selected: notes.book_id, class: "form-control")
  .form-group
    == text_area(name: "title", content: notes.title, placeholder: "Title", class: "form-control", size: "30x10")
  .form-group
    == text_area(name: "body", content: notes.body, placeholder: "Body", class: "form-control", size: "30x10")
  == submit("Submit", class: "btn btn-success btn-sm")
  == link_to("Back", "/notes", class: "btn btn-light btn-sm")
