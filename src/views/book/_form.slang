- if book.errors
  ul.errors
    - book.errors.each do |error|
      li = error.to_s

== form(action: "/books/#{book.id.to_s}", method: book.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:user)
    == select_field(name: "user_id", collection: User.all.map{|user| [user.id, user.id]}, selected: book.user_id, class: "form-control")
  .form-group
    == text_area(name: "title", content: book.title, placeholder: "Title", class: "form-control", size: "30x10")
  == submit("Submit", class: "btn btn-success btn-sm")
  == link_to("Back", "/books", class: "btn btn-light btn-sm")
