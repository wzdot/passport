require 'rails_helper'

RSpec.describe System, :type => :model do
  subject { build( :system ) }
  let( :forever ) { build( :sys_is_forever ) }
  let( :locked ) { build( :sys_is_locked ) }
  let( :timeout ) { build( :sys_is_timeout ) }

  it { should validate_presence_of( :schema ) }
  it { should validate_uniqueness_of( :schema ) }
  it { should ensure_length_of( :schema ).is_at_least( 3 ).is_at_most( 50 ) }
  it { should validate_presence_of( :name ) }
  it { should ensure_length_of( :name ).is_at_most( 50 ) }
  it { should validate_presence_of( :uid ) }
  it { should ensure_length_of( :uid ).is_equal_to( 64 ) }
  it { should validate_presence_of( :secret ) }
  it { should ensure_length_of( :secret ).is_equal_to( 64 ) }
  it { should_not allow_value( 1, 10, 999, 'A', 'B2', 'CD', 'm-s' ).for( :schema ) }
  it { should allow_value( 'ms1', 'm2s' ).for( :schema ) }
  # it { should validate_inclusion_of( :locked ).in_array( [ true, false ] ) }

  it 'should forever when timeout is nil' do
    expect( forever ).to be_forever
  end

  it 'should locked when locked is set to true' do
    expect( locked ).to be_locked
  end

  it 'should timeout when timeout field is less than today' do
    expect( timeout ).to be_timeout
  end
end
