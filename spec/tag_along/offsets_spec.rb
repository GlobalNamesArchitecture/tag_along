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
  end

  it 'should process object' do
    o = TagAlong::Offsets.new(OFFSETS_OBJ, 
                              offset_start: :start,
                              offset_end: :end)
    o.is_a?(TagAlong::Offsets).should be_true
    o.first.offset_start.should == 61
    o.first.offset_end.should == 68
  end

  it 'should process arrays with dynamic start tag' do
    o = TagAlong::Offsets.new(OFFSETS_ARY)
    o.is_a?(TagAlong::Offsets).should be_true
    o.first.offset_start.should == 61
    o.first.offset_end.should == 68
    o.first.data_start.should == ["Pundulus"]
    o.first.data_end.should be_nil
  end

  it 'should process dynamic hash' do
    o = TagAlong::Offsets.new(OFFSETS_HASH, 
                              offset_start: :offsetStart,
                              offset_end: :offsetEnd,
                              data_start: :verbatim,
                              data_end: :verbatim)
    o.is_a?(TagAlong::Offsets).should be_true
    o.first.offset_start.should == 61
    o.first.offset_end.should == 68
    o.first.data_start.should == ["Pundulus"]
    o.first.data_end.should == ["Pundulus"]
    o = TagAlong::Offsets.new(OFFSETS_HASH, 
                              offset_start: :offsetStart,
                              offset_end: :offsetEnd,
                              data_end: :verbatim)
    o.first.data_start.should be_nil
    o.first.data_end.should == ["Pundulus"]
  end

  it 'should process dynamic object' do
    o = TagAlong::Offsets.new(OFFSETS_OBJ, 
                              offset_start: :start,
                              offset_end: :end,
                              data_start: :name,
                              data_end: :name)
    o.is_a?(TagAlong::Offsets).should be_true
    o.first.offset_start.should == 61
    o.first.offset_end.should == 68
    o.first.data_start.should == ["Pundulus"]
    o.first.data_end.should == ["Pundulus"]
    o = TagAlong::Offsets.new(OFFSETS_OBJ, 
                              offset_start: :start,
                              offset_end: :end,
                              data_end: :name)
    o.first.data_start.should be_nil
    o.first.data_end.should == ["Pundulus"]
  end

end
