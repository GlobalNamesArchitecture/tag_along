require 'spec_helper'

describe TagAlong do
  it 'should have version' do
    TagAlong.version.should =~ /^[\d]+\.[\d]+.[\d]+$/
  end

  it 'should initialize' do
    tg = TagAlong.new(TEXT, OFFSETS_ARY)
    tg.is_a?(TagAlong).should be_true
    tg.text.should == TEXT
    tg.tagged_text.should be_nil
  end

  it 'should tag' do
    tg = TagAlong.new(TEXT, OFFSETS_ARY)
    tagged_text = tg.tag('<my_tag>', '</my_tag>')
    tg.tagged_text.should == tagged_text
    tg.tagged_text.should include('<my_tag>Lebistes reticulatus</my_tag>')
    tagged_text = tg.tag('<another_tag>', '</another_tag>')
    tg.tagged_text.should == tagged_text
    tg.tagged_text.should 
      include('<another_tag>Lebistes reticulatus</another_tag>')
  end
end
