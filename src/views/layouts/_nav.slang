- active = context.request.path == "/" ? "active" : ""
li.nav-item class=active
  a.nav-link href="/" Home
- active = context.request.path == "/books" ? "active" : ""
li.nav-item class=active
  a class="nav-link" href="/books" Books
- active = context.request.path == "/notes" ? "active" : ""
li.nav-item class=active
  a class="nav-link" href="/notes" Notes
