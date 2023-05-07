Amber::Server.configure do
  pipeline :web, :auth do
    # Plug is the method to use connect a pipe (middleware)
    # A plug accepts an instance of HTTP::Handler
    # plug Amber::Pipe::PoweredByAmber.new
    # plug Amber::Pipe::ClientIp.new(["X-Forwarded-For"])
    plug Citrine::I18n::Handler.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::Flash.new
    plug Amber::Pipe::CSRF.new

    plug CurrentUser.new
  end

  pipeline :auth do
    plug Authenticate.new
  end

  pipeline :api do
    # plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::CORS.new
  end

  # All static content will run these transformations
  pipeline :static do
    # plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Static.new("./public")
  end

  routes :web do
    get "/signin", SessionController, :new
    post "/session", SessionController, :create
    get "/signup", UserController, :new
    post "/registration", UserController, :create
    get "/oauth2/callback", GoogleController, :callback
    get "/test/:date", GoogleController, :test
  end

  routes :auth do
    get "/profile", UserController, :show
    get "/profile/edit", UserController, :edit
    patch "/profile", UserController, :update
    get "/signout", SessionController, :delete
    resources "books", BookController
    resources "notes", NoteController, except: [:whiteboard]

    get "/calendar/:month", CalendarController, :index
    get "/calendar", CalendarController, :index
    get "/day/:date", DayController, :editor
    post "/day/:date", DayController, :save

    get "/", NoteController, :whiteboard
    get "/api/user/me", UserController, :me
    get "/api/calendar", CalendarController, :export
  end

  routes :api do
    post "/api/signin", SessionController, :create_api
  end

  routes :static do
    # Each route is defined as follow
    # verb resource : String, controller : Symbol, action : Symbol
    get "/*", Amber::Controller::Static, :index
  end
end
