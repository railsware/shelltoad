class Shelltoad
  class BaseException < StandardError
  end

  class NoApiKey < BaseException
  end

  class NoProject < BaseException
  end

  class NoConfigfile < BaseException
  end

  class ErrorNotFound < BaseException
  end

  class ServiceNotAvailable < BaseException
  end

end
