require "readline"
class Shelltoad
  class Command

    class << self

      #
      # API
      #
      
      def run(command, *args)
        case command.to_s
        when "-h", "--help", "help", "h"
          display_help
        when "errors", "ers", nil, ""
          Error.all.each do |error|
            output error.to_s
          end
        when "error", "er", "show", "sh"
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
            open error.url
          end
        else
          raise BaseException, "Command not found"
        end
        return 0
      rescue BaseException => e
        output e.message
        return 1
      end

      #
      # Implementation
      #
      
      protected
      def magic_find(*args, &block)
        Error.magic_find(*args, &block)
      end

      def output(*args)
        Shelltoad.output(*args)
      end

      def commit(id)
        unless self.changes_staged?
          raise Shelltoad::BaseException, "No changes staged with git."
        end
        magic_find(id) do |error|
          output error.commit!
        end
      end # commit(id, args)

      def open(url)
        [Configuration.browser, "firefox", "chromium-browser", "start" ].find do |browser|
          fork {
            system browser, url.to_s
          }
        end
      end

      def changes_staged?
        !`git diff --staged`.empty?
      end

      def display_help
        output <<-EOI
Usage: shelltoad command [<args>]

Available commands:

    errors   list all unresolved errors, this is the default
    error    display information about given error. Shortcut: shelltoad <number>
    resolve  mark error as resolved in Hoptoad
    commit   do commit to vcs with the information on the specified error and mark error resolved in Hoptoad
    open     open error page in browser
EOI

      end
    end
  end
end
