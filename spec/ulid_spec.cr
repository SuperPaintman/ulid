require "./spec_helper"

describe ULID do
  describe ".generate : String" do
    it "should not raise an error" do
      begin
        ULID.generate
      rescue err
        err.should be_nil
      end
    end

    it "should return correct length" do
      ULID.generate.size.should eq 26
    end

    it "should contain only correct chars" do
      (ULID.generate =~ /[^0123456789ABCDEFGHJKMNPQRSTVWXYZ]/).should be_nil
    end

    it "should be in upcase" do
      res = ULID.generate

      res.should eq res.upcase
    end

    it "should be unique" do
      len = 1000
      arr = [] of String

      len.times do
        arr << ULID.generate
      end

      arr.uniq!

      arr.size.should eq len
    end

    it "should be sortable" do
      1000.times do
        ulid_1 = ULID.generate
        sleep 1.millisecond
        ulid_2 = ULID.generate

        (ulid_2 > ulid_1).should be_true
      end
    end

    it "should be seedable" do
      1000.times do
        ulid_1 = ULID.generate
        sleep 1.millisecond
        ulid_2 = ULID.generate(Time.utc - 1.second)

        (ulid_2 < ulid_1).should be_true
      end
    end
  end
end
