- if note.errors.any?
  ul.errors
    - note.errors.each do |error|
      li = error.to_s

== form(action: "/notes/#{note.id.to_s}", method: note.id ? :patch : :post) do
  == csrf_tag
  .editor
    .pane
      == text_area name: "body", content: note.body, id: "markdown", class: "markdown"
    .pane  
      .buttons
        == submit("Save", class: "btn btn-success btn-sm disabled", id: "save-button")
      .preview id="preview"

