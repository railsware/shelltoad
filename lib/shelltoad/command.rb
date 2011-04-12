require "readline"
class Shelltoad
  class Command

    class << self
      def run(command, *args)
        case command.to_s
        when "errors", "ers", nil, ""
          Error.all.each do |error|
            output error.to_s
          end
        when "error", "er"
          magic_find(args.shift) do |error|
            output error.view
          end
        when "commit", "ci"
          commit(args.shift)
        when "resolve", "rv"
          magic_find(args.shift) do |error|
            error.resolve!
            output "Error #{error.id} marked as resolved"
          end
        when "open", "op"
          magic_find(args.shift) do |error|
            open error.url
          end
        when /^[\d]/
          magic_find(command) do |error|
          output error.view
          end
        else
          raise BaseException, "Command not found"
        end
        return 0
      rescue BaseException => e
        output e.message
        return 1
      end

      protected
      def magic_find(*args, &block)
        Error.magic_find(*args, &block)
      end

      def output(*args)
        Shelltoad.output(*args)
      end

      def commit(id)
        magic_find(id) do |error|
          output error.commit!
        end
      end # commit(id, args)

      def open(url)
        [Configuration.browser, "firefox", "chromium-browser", "start" ].find do |browser|
          system browser, url.to_s
        end
      end
    end
  end
end
