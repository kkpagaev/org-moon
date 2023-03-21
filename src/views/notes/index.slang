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
      - notes.each do |notes|
        tr
          td = notes.user.id
          td = notes.book.id
          td = notes.title
          td = notes.body
          td
            span
              == link_to("Show", "/notes/#{notes.id}", class: "btn btn-info btn-sm")
              == link_to("Edit", "/notes/#{notes.id}/edit", class: "btn btn-success btn-sm")
              == link_to("Delete", "/notes/#{ notes.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
