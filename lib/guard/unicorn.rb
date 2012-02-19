require "guard"
require "guard/guard"
require 'timeout'

module Guard
  class Unicorn < Guard

    attr_reader :pid

    def initialize(watchers=[], options={})
      super
      @options = {
        :host         => '0.0.0.0',
        :port         => 8080,
        :environment  => nil,
        :config_file  => nil
      }.update(options)
    end

    def start
      UI.info "Starting unicorn"
      if running?
        UI.error "Unicorn already running at #{@options[:host]}:#{@options[:port]}"
        false
      else
        @process = IO.popen(command)
        UI.info "Started unicorn"
        wait_for_port
        @pid = @process.pid
      end
    end

    def stop
      Process.kill("TERM", @pid)
      Process.wait(@pid)
      @pid = nil
      true
    end

    def run_on_change(paths = {})
      restart
    end

    private
    
    def restart
      UI.info "Restarting WEBrick..."
      stop
      start
    end

    def command
      com = "unicorn -l #{@options[:host]}:#{@options[:port]}"
      com += " --env #{@options[:environment]}" if @options[:environment]
      com
    end

    def running?
      !!Process.getpgid(@pid)
    rescue Errno::ESRCH, TypeError
      false
    end

    def wait_for_port
      while true do
        sleep 0.2
        port_open? and return
      end
    end

    def port_open?
      begin
        begin
          Timeout::timeout(1) do
            TCPSocket.new(@options[:host], @options[:port]).close
            return true
          end
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          return false
        end
      rescue Timeout::Error
      end
      false
    end

  end
end
