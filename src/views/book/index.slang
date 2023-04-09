.row
  .col-sm-11
    h2 Books
  .col-sm-1
    a.btn.btn-success.btn-sm href="/books/new" New
- if books.select {|b| !b.is_system } .empty?
  p No books found
- else
  .table-responsive
    table.table.table-striped
      thead
        tr
          th Title
          th Actions
      tbody
        - books.each do |book|
          - if !book.is_system
            tr
              td = book.title
              td
                span
                  == link_to("Show", "/notes?book_id=#{book.id}", class: "btn btn-info btn-sm")
                  == link_to("Edit", "/books/#{book.id}/edit", class: "btn btn-warning btn-sm")
