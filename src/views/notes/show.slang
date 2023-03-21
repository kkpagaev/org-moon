.editor
  .pane.hidden
    == text_area(name: "body", content: notes.body, id: "markdown" )
  .pane 
    .buttons
      == link_to("Edit", "/notes/#{notes.id}/edit", class: "btn btn-success btn-sm")
      == link_to("Delete", "/notes/#{notes.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
    .preview id="preview"
