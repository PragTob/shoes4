require 'shoes/spec_helper'

describe Shoes::Download do
  let(:app) { Shoes::App.new }
  let(:block) { proc{} }
  let(:name) { "http://www.google.com/logos/nasa50th.gif" }
  let(:args) { {:save => "nasa50th.gif"} }
  subject{ Shoes::Download.new app, name, args, &block }

  after do
    #subject.join_thread
    #File.delete args[:save]
  end

  it "should eventually finish" do
    pending 'UGH VCR'
    extend AsyncHelper
    VCR.use_cassette 'download' do
      eventually(timeout: 10, interval: 1) {subject.should be_finished}
    end
  end

  it 'should eventually start' do
    pending 'UGH VCR'
    extend AsyncHelper
    VCR.use_cassette 'download' do
      eventually(timeout: 10, interval: 1) {subject.should be_started}
    end
  end

  it 'creates the file specified by save' do
    pending 'UGH VCR'
    extend AsyncHelper
    VCR.use_cassette 'download' do
      subject
      eventually(timeout: 10, interval: 1) do
        File.exist?(args[:save]).should be_true
      end
    end
  end

  describe 'with a called block' do
    let(:block) {proc {@called = true}}

    it 'calls the block with a result when the download is finished' do
      pending 'UGH VCR'
      extend AsyncHelper
      VCR.use_cassette 'download' do
        subject
        eventually(timeout: 10, interval: 1) do
          @called.should be_true
        end
      end
    end
  end

end
