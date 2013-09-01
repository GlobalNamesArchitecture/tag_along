require_relative '../spec_helper'

describe TagAlong::Offsets do

  it 'should initialize' do
    o = TagAlong::Offsets.new(OFFSETS_ARY)
    o.is_a?(TagAlong::Offsets).should be_true
    o.first.offset_start.should == 61
    o.first.offset_end.should == 68
    o.first.item_string.should be_nil
  end

end
