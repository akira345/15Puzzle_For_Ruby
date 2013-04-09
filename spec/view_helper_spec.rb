# -*- coding: utf-8 -*-
$LOAD_PATH << File.join(File.dirname(__FILE__), '..')
require 'view_helper'
puts $LOAD_PATH[-1]

class Helper
  include ViewHelper
end

describe ViewHelper do
  before :each do
    @helper = Helper.new
  end

  describe '#show_diffcult' do
    context 'Easy の時' do
      it { @helper.show_difficult(:Easy).should eq("やさしい") }
    end

    context 'Nomal の時' do
      it { @helper.show_difficult(:Normal).should eq("普通") }
    end

    context 'Hard の時' do
      it { @helper.show_difficult(:Hard).should eq("難しい") }
    end
  end

  describe '#number_image' do
    it { @helper.number_image(1).should eq('<img src="/gif/1.gif">') }
  end
end
