.editor
  .pane.hidden
    == text_area(name: "body", content: note.body, id: "markdown" )
  .pane 
    .buttons
      == link_to("Edit", "/notes/#{note.id}/edit", class: "btn btn-success btn-sm")
      == link_to("Delete", "/notes/#{note.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
    .preview id="preview"
