require 'rake/testtask'

task :default => [:test]

task :test do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.warning = true
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
  end
end