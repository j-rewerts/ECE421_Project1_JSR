require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['src/*test.rb']
  t.verbose = true
end

task :default => :test
