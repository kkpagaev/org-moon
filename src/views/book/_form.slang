- if book.errors
  ul.errors
    - book.errors.each do |error|
      li = error.to_s

== form(action: "/books/#{book.id.to_s}", method: book.id ? :patch : :post) do
  == csrf_tag
  .row
    .col-6
      .form-group
        == text_area(name: "title", content: book.title, placeholder: "Title", class: "form-control", errors: "cannot be blank", size: "30x10")
        == hidden_field(name: "icon", value: book.icon)
      .form-group.form-check-inline
          - icons.each do |icon|
            .form-check
              - selected = book.icon == icon ? "checked" : ""
              - if book.icon == icon
                input class="form-check-input icon-input" type="radio" name="icon" id="icon-#{icon}"
                label class="form-check-label icon-input-lable #{icon}" for="icon-#{icon}"
              - else
                input class="form-check-input icon-input" type="radio" name="icon" id="icon-#{icon}"
                label class="form-check-label icon-input-lable #{icon}" for="icon-#{icon}"


  == submit("Submit", class: "btn btn-success btn-sm")
  == link_to("Back", "/books", class: "btn btn-light btn-sm")
