.sidebar
  ul.sidebar__menu
    - active = context.request.path == "/" ? "sidebar__menu__item--active" : ""
    li.sidebar__menu__item class=active
      span.sidebar__menu__item__tooltip
        | Whiteboard
      a.gg-calendar-two(href="/")
    - active = context.request.path == "/books" ? "sidebar__menu__item--active" : ""
    li.sidebar__menu__item class=active
      span.sidebar__menu__item__tooltip
        | Yout books
      a.gg-album(href="/books")
    - active = context.request.path == "/calendar" ? "sidebar__menu__item--active" : ""
    li.sidebar__menu__item class=active
      span.sidebar__menu__item__tooltip
        | Calendar
      a.gg-calendar-today(href="/calendar")


    - current_books.each do |b|
      - active = context.request.path == "/notes" ? "sidebar__menu__item--active" : ""
      li.sidebar__menu__item class=active
        span.sidebar__menu__item__tooltip
          | #{b.title}
        - icon = b.icon
        a(href="/books/#{b.id}" class=icon)
  ul.sidebar__menu
    - active = context.request.path == "/profile" ? "sidebar__menu__item--active" : ""
    li.sidebar__menu__item class=active
      span.sidebar__menu__item__tooltip
        | Add a book
      a.gg-user(href="/profile")
