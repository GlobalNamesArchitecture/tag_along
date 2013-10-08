require_relative '../spec_helper'

describe TagAlong::TaggedText do

  describe 'No space normalization' do

    let(:text) do
      "\n    \n      \n        Days of the week" +
      "\n      \n      \n        \n        There's" +
      " Sunday\n        and there's Monday" +
      "\n        \n      \n    \n    "
    end

    let(:text_offsets) { [[77,82],[104,109]] }

    subject { TagAlong::TaggedText.new(HTML_TEXT) }

    its(:tagged_text) { should == HTML_TEXT }
    its(:plain_text) { should == text }
    it 'should get offsets' do
      subject.offsets[1].should == { type: :tag , start: 5, end: 10 }
      subject.offsets[2].should == { type: :text , start: 11,
                                     end: 17, text_start: 5, text_end: 11 }
    end

    it 'should adjust offsets' do
      text_offsets.should == [[77,82],[104,109]]
      offsets = subject.adjust_offsets(text_offsets)
      offsets.should be_kind_of TagAlong::Offsets
      offsets.map { |o| [o.offset_start, o.offset_end] }.should ==
        [[128, 133], [172, 177]]
    end

  end

  describe 'space normalization' do
    let(:text) { "Days of the week There's Sunday and there's Monday" }

    subject { TagAlong::TaggedText.new(HTML_TEXT, normalize_spaces: true) }

    its(:tagged_text) { should == HTML_TEXT }
    # its(:plain_text) { should == text }
  end

end

