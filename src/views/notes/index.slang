.row
  .col-sm-6
    - title = book.try &.title || "All notes"
    h2
      a href="/notes?book_id=#{book.try &.id}" Notes
        = title
  - if b = book
    .col-sm-6
      a.btn.btn-success.btn-sm href="/notes/new?book_id=#{book.try &.id}" New
      - if b.is_system
        == link_to("Edit", "/books/#{b.id}/edit", class: "btn btn-success btn-sm")
.container-fluid
  .note-table
    .row
      - notes.each do |note|
        - if !note.is_hidden
          .col-sm-4
            .note-card
              .note-card__note.preview-note
                .preview-note.pane
                  .buttons
                    == link_to("Edit", "/notes/#{note.id}/edit", class: "btn btn-success btn-sm")
                    == form(action: "/notes/#{note.id}", method: :delete) do
                      == csrf_tag
                      button.btn.btn-danger.btn-sm(type="submit") Delete
                  .preview-note__content.preview
                    h2.preview-note__title
                      == note.title
                    .preview-note__tags
                      - note.tags.each do |tag|
                        == link_to(tag.name, "/notes?book_id=#{book.try &.id}&tag_id=#{tag.id}", class: "tag", style: "background-color: #{tag.color}; color: #{tag.text_color}")

