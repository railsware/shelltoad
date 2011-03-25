class Shelltoad::Command

  def self.run(command, *args)
    case command
    when "errors", "ers", nil
      Shelltoad::Error.all.each do |error|
        output error.to_s
      end
    when "error", "er"
      Shelltoad::Error.magic_find(args.shift) do |error|
        output error.view
      end
    when "commit", "ci"
      Shelltoad::Error.magic_find(args.shift) do |error|
        output error.commit!
      end
    when "resolve", "rv" 
      Shelltoad::Error.magic_find(args.shift) do |error|
        error.resolve!
        output "Error #{error.id} marked as resolved"
      end
    when /^[\d]/
      Shelltoad::Error.magic_find(command) do |error|
        output error.view
      end
    end
    return true
  rescue Shelltoad::ErrorNotFound => e
    output e.message
  end

  def self.output(*args)
    Shelltoad.output(*args)
  end
end
