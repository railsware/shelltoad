class Shelltoad::Command

  def self.run(command, *args)
    case command
    when "errors", "ers", nil
      Shelltoad::Error.find(:all).each do |error|
        Shelltoad.output 'ee'
        unless error.rails_env == "development"
          Shelltoad.output error.to_s
        end
      end
    when "error", "er"
      Shelltoad.output Shelltoad::Error.magic_find(args.shift).view || "Not found"
    when "commit", "ci"
      if error = Shelltoad::Error.magic_find(args.shift)
        error.commit
      else
        Shelltoad.output "Not Found"
      end
    when /^[\d]/
      Shelltoad.output Shelltoad::Error.magic_find(command).view || "Not found"
    end
    return true
  end
end
