require 'spec_helper'

describe Guard::Unicorn do
  describe 'options' do
    describe 'host' do
      it 'should be 0.0.0.0 by default' do
        expect(subject.options[:host]).to eq('0.0.0.0')
      end

      it 'should be settable' do
        u = described_class.new(host: '1.2.3.4')
        expect(u.options[:host]).to eq('1.2.3.4')
      end
    end

    describe 'environment' do
      it 'should default to nil' do
        expect(subject.options[:environment]).to be_nil
      end

      it 'should be settable' do
        u = described_class.new(environment: 'test')
        expect(u.options[:environment]).to eq('test')
      end
    end

    describe 'port' do
      it 'should be 8080 by default' do
        expect(subject.options[:port]).to eq(8080)
      end

      it 'should be settable' do
        u = described_class.new(port: 5000)
        expect(u.options[:port]).to eq(5000)
      end
    end

    describe 'config_file' do
      it 'should default to nil' do
        expect(subject.options[:config_file]).to be_nil
      end

      it 'should be settable' do
        u = described_class.new(config_file: '/path/to/config')
        expect(u.options[:config_file]).to eq('/path/to/config')
      end
    end
  end

  describe 'start' do
    include_context 'processes'

    context 'when not already running' do
      before do
        subject.stub(:port_open?).and_return(true)
      end

      it 'should set the pid' do
        subject.start
        expect(subject.pid).to eq(pid)
      end

      it 'should wait_for_port' do
        expect(subject).to receive(:wait_for_port)
        subject.start
      end
    end

    context 'when running' do
      before do
        subject.stub(:running?).and_return(true)
      end

      it 'should return false' do
        expect(subject.start).to be_falsy
      end
    end
  end

  describe 'stop' do
    include_context 'processes'

    before do
      subject.instance_variable_set(:@pid, pid)
    end

    it 'should kill the process' do
      Process.should_receive(:kill).with('TERM', pid)
      Process.should_receive(:wait).with(pid)
      expect(subject.stop).to be_truthy
      expect(subject.pid).to be_nil
    end
  end
end
