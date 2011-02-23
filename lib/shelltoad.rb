class Shelltoad; end
require "shelltoad/exceptions"
require "shelltoad/configuration"
require "shelltoad/error"
require "shelltoad/exceptions"
require "shelltoad/command"


class Shelltoad

  STDOUT = ::STDOUT

  def self.run(*args)
    Command.run(*args)
  end

  def self.output(string)
    ::Shelltoad::STDOUT << "#{string}\n"
  end

  def output(string)
    self.class.output(string)
  end # output(string)
  
end

