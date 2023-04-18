module JWT
  @@secret = ""

  def self.secret=(secret)
    @@secret = secret
  end

  def encode(payload) : String
    self.encode(payload, @@secret, JWT::Algorithm::HS256)
  end

  def decode(token) : Hash
    self.decode(token, key: @@secret, verify: true, validate: false)
  end

  def config
    yield self
  end
end
