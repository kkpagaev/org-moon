- if notes.errors.any?
  ul.errors
    - notes.errors.each do |error|
      li = error.to_s

== form(action: "/notes/#{notes.id.to_s}", method: notes.id ? :patch : :post) do
  == csrf_tag
  .editor
    .pane
      == text_area(name: "body", content: notes.body, id: "markdown" )
    .pane 
      .preview id="preview"
  == submit("Submit", class: "btn btn-success btn-sm")
  == link_to("Back", "/notes", class: "btn btn-light btn-sm")

