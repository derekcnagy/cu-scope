require 'test_helper'

class TestRunTest < ActiveSupport::TestCase
  setup do
    @test_run = TestRun.new
    @test_run.test_run_name = 'test_file.json'
    @test_run.time_ran = '2019-01-21 12:46:00'
    @test_run.team = teams :team_one
  end

  test 'A new Test Run can be created' do
    assert @test_run.save
  end
  test 'A new Test Run can have an associated Profile' do
    @test_run.profile = profiles :smoke
    assert @test_run.save
  end
  test 'A Test Run requires a Name' do
    @test_run.test_run_name = ''
    assert_not @test_run.save
  end
  test 'A Test Run requires a Time Run' do
    @test_run.time_ran = ''
    assert_not @test_run.save
  end
  test 'A Test Run requires an associated Team' do
    @test_run.team = nil
    assert_not @test_run.save
  end
end
