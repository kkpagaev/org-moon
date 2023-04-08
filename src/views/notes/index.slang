.row
  .col-sm-6
    - title = book.try &.title || "All notes"
    h2
      = title
  - if b = book
    .col-sm-6
      a.btn.btn-success.btn-sm href="/notes/new?book_id=#{book.try &.id}" New
      == link_to("Edit", "/books/#{b.id}/edit", class: "btn btn-success btn-sm")
.container-fluid
  .note-table
    .row
      - notes.each do |note|
        .col-sm-4
          .note-card
            .note-card__note.preview-note
              .preview-note.pane
                .buttons
                  == link_to("Edit", "/notes/#{note.id}/edit", class: "btn btn-success btn-sm")
                  == link_to("Delete", "/notes/#{ note.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
                .preview-note__content.preview
                  h2.preview-note__title
                    == note.title
                  .preview-note__tags
                    - note.tags.each do |tag|
                      == link_to(tag.name, "/notes?book_id=#{book.try &.id}&tag_id=#{tag.id}", class: "tag", style: "background-color: #{tag.color}; color: #{tag.text_color}")

