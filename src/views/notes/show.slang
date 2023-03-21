h1 Show Notes
p = notes.user.id
p = notes.book.id
p = notes.title
p = notes.body
p
  == link_to("Back", "/notes", class: "btn btn-light btn-sm")
  == link_to("Edit", "/notes/#{notes.id}/edit", class: "btn btn-success btn-sm")
  == link_to("Delete", "/notes/#{notes.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
