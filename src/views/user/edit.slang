h1 Change Password

- if user.errors
  ul.errors
  - user.errors.each do |error|
    li = error.to_s

== form(action: "/profile", method: :patch) do
  == csrf_tag
  .form-group
    input.form-control type="password" name="password" placeholder="Password"
  .form-group
    input.form-control type="password" name="password_confirmation" placeholder="Password Confirmation"
  == submit("Update", class: "btn btn-success btn-sm")
  == link_to("Profile", "/profile", class: "btn btn-light btn-sm")
