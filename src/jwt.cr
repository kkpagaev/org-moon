module JWT
  @@secret = ""

  def self.secret=(secret)
    @@secret = secret
  end

  def encode(payload) : String
    payload.merge!({"exp" => Time.utc.to_unix + 4.weeks.to_i})
    self.encode(payload, @@secret, JWT::Algorithm::HS256)
  end

  def decode(token)
    self.decode(token, key: @@secret, verify: true, validate: true, algorithm: JWT::Algorithm::HS256)
  end

  def config
    yield self
  end
end
