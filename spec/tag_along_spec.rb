require 'spec_helper'

describe TagAlong do
  it 'should have version' do
    TagAlong.version.should =~ /^[\d]+\.[\d]+.[\d]+$/
  end
end
