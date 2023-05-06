h1 New Note

- if note.errors
  ul.errors
    - note.errors.each do |error|
      li = error.to_s
- books = current_books
- if books.empty?
  p You have no books. Create one first.
- else
  == form(action: "/notes/#{note.id.to_s}", method: note.id ? :patch : :post) do
    == csrf_tag
    .form-group
      == label(:book)
      == select_field(name: "book_id", collection: books.map{|book| [book.id, book.title]}, selected: params[:book_id]?, class: "form-control")
    .form-group
      == text_area(name: "title", content: note.title, placeholder: "Title", class: "form-control")
    .form-group
      == text_area(name: "tags", content: "" , placeholder: "Tags separated with commas", class: "form-control")
    == submit("Submit", class: "btn btn-success btn-sm")

