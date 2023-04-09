doctype html
html
  head
    title Org-moon
    meta charset="utf-8"
    meta http-equiv="X-UA-Compatible" content="IE=edge"
    meta name="viewport" content="width=device-width, initial-scale=1"
    link rel="stylesheet" href="/dist/main.bundle.css"
    link rel="apple-touch-icon" href="/favicon.png"
    link rel="icon" href="/favicon.png"
    link rel="icon" type="image/x-icon" href="/favicon.ico"

  body
    ninja-keys
    .alert-popup
      - flash.each do |key, value|
        div id="hideMe" class="alert alert-#{key}" role="alert"
          = flash[key]

    .main
      - if (current_user = context.current_user)
        .main__sidebar
          == render(partial: "layouts/_sidebar.slang")
      .container-fluid.main__content
        == content

    script src="/dist/main.bundle.js"

    - if Amber.settings.auto_reload?
      script src="/js/client_reload.js"

ul#help.hidden
  li
    span f
    span find
  li
    span a
    span add new note
  li
    span d
    span delete note
  li
    span s
    span save note
  li
    span c
    span open calendar

