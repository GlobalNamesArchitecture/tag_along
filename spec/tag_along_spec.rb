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
  
  it 'should tag' do
    text = 'There\'s Sunday and there\'s Monday'
    offsets = [[8,13], [27,32]]
    tg = TagAlong.new(text, offsets)
    tg.tag('<em>', '</em>').should == 
      %q{There's <em>Sunday</em> and there's <em>Monday</em>}
  end

  it 'should tag dynamicly' do
    tg = TagAlong.new(TEXT, OFFSETS_ARY)
    tagged_text = tg.tag("<my_tag name=\"%s\">", '</my_tag>')
    tg.tagged_text.should == tagged_text
    tg.tagged_text.should include('<my_tag name="Lebistes reticulatus">' + 
                                  'Lebistes reticulatus</my_tag>')
  end

  it 'should tag dynamicly end tag' do
    offsets = OFFSETS_ARY.each {|i| i.insert(-2, nil)}
    tg = TagAlong.new(TEXT, OFFSETS_ARY)
    tagged_text = tg.tag('<my_tag>', "</my_tag name=\"%s\">")
    tg.tagged_text.should == tagged_text
    tg.tagged_text.should include("</my_tag name=\"Pundulus\">")
  end
  
  it 'should break dynamic taging if there is problem with data' do
    offsets = OFFSETS_ARY.each {|i| i.insert(-2, nil)}
    tg = TagAlong.new(TEXT, OFFSETS_ARY)
    -> { tg.tag('<my_tag>', "</my_tag val=\"%s\" name=\"%s\">") }.
      should raise_error
  end

  it 'should take offsets in any order' do
    text = 'There\'s Sunday and there\'s Monday'
    offsets = [[27,32], [8,13]]
    tg = TagAlong.new(text, offsets)
    tg.tag('<em>', '</em>').should == 
      %q{There's <em>Sunday</em> and there's <em>Monday</em>}
  end

  it 'should preserve the end of the text' do
    text = 'There\'s Sunday and there\'s Monday for sure'
    offsets = [[27,32], [8,13]]
    tg = TagAlong.new(text, offsets)
    tg.tag('<em>', '</em>').should == 
      %q{There's <em>Sunday</em> and there's <em>Monday</em> for sure}
  end

end
