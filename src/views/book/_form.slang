- if book.errors
  ul.errors
    - book.errors.each do |error|
      li = error.to_s

== form(action: "/books/#{book.id.to_s}", method: book.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "title", content: book.title, placeholder: "Title", class: "form-control", errors: "cannot be blank", size: "30x10")
  .form-check
    == check_box(:is_hidden, checked: book.is_hidden, class: "form-check-input")
    == label(:is_hidden, "Hidden", class: "form-check-label")
  .form-group
    == hidden_field(name: "icon", value: book.icon)
  .form-group.form-check-inline.row
    - icons.each do |icon|
      .form-check
        input class="form-check-input icon-input" type="radio" name="icon" id="icon-#{icon}" value="#{icon}"
        label class="form-check-label icon-input-lable #{icon}" for="icon-#{icon}"


  .form-group
    == submit("Submit", class: "btn btn-success btn-sm")
