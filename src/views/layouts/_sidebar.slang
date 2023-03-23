.sidebar
  ul.sidebar__menu
    - active = context.request.path == "/" ? "sidebar__menu__item--active" : ""
    li class=active
      a.gg-calendar-two(href="/")
    - active = context.request.path == "/notes" ? "sidebar__menu__item--active" : ""
    li class=active
      a.gg-file(href="/notes")
    - active = context.request.path == "/books" ? "sidebar__menu__item--active" : ""
    li class=active
      a.gg-album(href="/books")
    - active = context.request.path == "/calendar" ? "sidebar__menu__item--active" : ""
    li class=active
      a.gg-calendar-today(href="/calendar")
  ul.sidebar__menu
    - active = context.request.path == "/profile" ? "sidebar__menu__item--active" : ""
    li class=active
      a.gg-user(href="/profile")
