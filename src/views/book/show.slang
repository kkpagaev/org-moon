h1 Show Book
p = book.user.id
p = book.title
p
  == link_to("Back", "/books", class: "btn btn-light btn-sm")
  == link_to("Edit", "/books/#{book.id}/edit", class: "btn btn-success btn-sm")
  == link_to("Delete", "/books/#{book.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
