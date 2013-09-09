require_relative '../spec_helper'

describe TagAlong::Offsets do

  it 'should initialize' do
    o = TagAlong::Offsets.new(OFFSETS_ARY)
    o.is_a?(TagAlong::Offsets).should be_true
  end

  it 'should process arrays' do
    o = TagAlong::Offsets.new(OFFSETS_ARY)
    o.is_a?(TagAlong::Offsets).should be_true
    o.first.offset_start.should == 61
    o.first.offset_end.should == 68
    o.first.item_string.should be_nil
    -> { TagAlong::Offsets.new([['a','b']]) }.should 
      raise_error(TypeError, 'Offsets must be integers') 
  end

  it 'should process hash' do
    o = TagAlong::Offsets.new(OFFSETS_HASH, 
                              offset_start: :offsetStart,
                              offset_end: :offsetEnd)
    o.is_a?(TagAlong::Offsets).should be_true
    o.first.offset_start.should == 61
    o.first.offset_end.should == 68
    o.first.item_string.should be_nil
  end

  it 'should process object' do
    o = TagAlong::Offsets.new(OFFSETS_OBJ, 
                              offset_start: :start,
                              offset_end: :end)
    o.is_a?(TagAlong::Offsets).should be_true
    o.first.offset_start.should == 61
    o.first.offset_end.should == 68
    o.first.item_string.should be_nil
  end
end
