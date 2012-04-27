require 'spec_helper'

include DayParser

describe DayParser do
  describe "#normalize_day" do

    context "for proper given day" do

      it "returns parsed day for short day name" do
        @day="tue"
        normalize_day(@day).should == "Tue"

      end

      it "returns parsed day for long day name" do
        @day="wednesday"
        normalize_day(@day).should == "Wed"
      end

      it "returns todays day for today" do
        @day="today"
        time = Time.new
        Time.stub!(:now).and_return(time)

        normalize_day(@day).should == time.strftime("%a")
      end

      it "returns tomorows day for tomorrow" do
        @day="tomorrow"
        time = Time.new
        Time.stub!(:tomorow).and_return(time)

        normalize_day(@day).should == time.strftime("%a")
      end

    end

    context "for wrong given day" do

      it "returns nil" do
        @day="err"
        normalize_day(@day).should be nil
      end

    end


  end

end