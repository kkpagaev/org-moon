.sidebar
  ul.sidebar__menu
    - active = context.request.path == "/" ? "sidebar__menu__item--active" : ""
    li.sidebar__menu__item class=active
      span.sidebar__menu__item__tooltip
        | Whiteboard
      a.gg-calendar-two(href="/")
    - active = (context.request.path.includes? "/books") ? "sidebar__menu__item--active" : ""
    li.sidebar__menu__item class=active
      span.sidebar__menu__item__tooltip
        | Yout books
      a.gg-album(href="/books")
    - active = (context.request.path.includes?("calendar")) || (context.request.path.includes?("day")) ? "sidebar__menu__item--active" : ""
    li.sidebar__menu__item class=active
      span.sidebar__menu__item__tooltip
        | Calendar
      a.gg-calendar-today(href="/calendar")


    - current_books.each do |b|
      - active = book.try &.id == b.id ? "sidebar__menu__item--active" : ""
      li.sidebar__menu__item class=active
        span.sidebar__menu__item__tooltip
          | #{b.title}
        - icon = b.icon
        a(href="/notes?book_id=#{b.id}&page=1" class=icon)
  ul.sidebar__menu
    - active = (context.request.path.includes? "/notes/new") ? "sidebar__menu__item--active" : ""
    li.sidebar__menu__item class=active
      span.sidebar__menu__item__tooltip
        | Add new note
      a.gg-add(href="/notes/new")
    - active = (context.request.path.includes?("profile")) ? "sidebar__menu__item--active" : ""
    li.sidebar__menu__item class=active
      span.sidebar__menu__item__tooltip
        | Profile
      a.gg-user(href="/profile")
