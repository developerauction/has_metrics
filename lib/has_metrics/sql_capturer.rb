class SqlCapturer
  attr_accessor :query, :existing_logger

  def initialize(existing_logger)
    self.query = []
    self.existing_logger = existing_logger
    self
  end

  def error(string)
    raise string
  end

  def debug?
    true
  end

  def warn(message)
    existing_logger.try(:warn, message)
  end

  def capture(log)
    if select_statement = log.index("SELECT")
      self.query << log[select_statement..-1].gsub(/\e\[(\d+)m/, '')
    end
    existing_logger.debug(log) if existing_logger
  end
  alias_method :debug, :capture
end