require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  setup do
    @feature = Feature.new
    @feature.feature_name = 'A Feature'
    @feature.feature_description = 'This is a Feature'
    @feature.json_feature_id = 'first-feature'
    @feature.team = teams :team_one
  end

  test 'A New Feature can be Created' do
    assert @feature.save
  end
  test 'A Feature does NOT need a Description' do
    @feature.feature_description = ''
    assert @feature.save
  end
  test 'A Feature does NOT need a Team' do
    @feature.feature_description = ''
    assert @feature.save
  end
  test 'A Feature Needs the Feature Name' do
    @feature.feature_name = ''
    assert_not @feature.save
  end
  test 'A Feature Needs the Json Feature ID' do
    @feature.json_feature_id = ''
    assert_not @feature.save
  end
end
