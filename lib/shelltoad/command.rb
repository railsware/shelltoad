class Shelltoad::Command

  def self.run(command, *args)
    case command
    when "errors", "ers", nil
      Shelltoad::Error.all.each do |error|
        output error.to_s
      end
    when "error", "er"
      magic_find(args.shift) do |error|
        output error.view
      end
    when "commit", "ci"
      magic_find(args.shift) do |error|
        output error.commit!
      end
    when "resolve", "rv" 
      magic_find(args.shift) do |error|
        error.resolve!
        output "Error #{error.id} marked as resolved"
      end
    when /^[\d]/
      magic_find(command) do |error|
        output error.view
      end
    end
    return 0
  rescue Shelltoad::BaseException => e
    output e.message
    return 1
  end

  def self.magic_find(*args)
    Shelltoad::Error.magic_find(*args)
  end

  def self.output(*args)
    Shelltoad.output(*args)
  end
end
