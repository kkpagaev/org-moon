h1 Profile
p
  == user.email
  == link_to("Change password", "/profile/edit", class: "btn btn-success btn-sm")
  == link_to("Signout", "/signout", class: "btn btn-danger btn-sm")
