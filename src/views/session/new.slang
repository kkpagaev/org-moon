h1 Sign In

- if user.errors
  ul.errors
  - user.errors.each do |error|
    li = error.to_s

form action="/session" method="post"
  == csrf_tag
  .form-group
    input.form-control type="email" name="email" placeholder="Email"
  .form-group
    input.form-control type="password" name="password" placeholder="Password"
  button.btn.btn-success.btn-sm type="submit" Sign In
<hr/>
== link_to("Don't have an account yet?", "/signup")
br
a href="#{Google.url}"
  | Sign in with Google
