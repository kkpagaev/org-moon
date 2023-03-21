.row
  .col-sm-11
    h2 Notes
  .col-sm-1
    a.btn.btn-success.btn-sm href="/notes/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th User
        th Book
        th Title
        th Body
        th Actions
    tbody
      - notes.each do |note|
        tr
          td = note.user.id
          td = note.book.id
          td = note.title
          td = note.body
          td
            span
              == link_to("Show", "/notes/#{note.id}", class: "btn btn-info btn-sm")
              == link_to("Edit", "/notes/#{note.id}/edit", class: "btn btn-success btn-sm")
              == link_to("Delete", "/notes/#{ note.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
