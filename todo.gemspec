spec = Gem::Specification.new do |s|
  s.name = 'todo_console'
  s.version = '0.0.1'
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files = `git ls-files`.split("
")
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','todo.rdoc']
  s.rdoc_options << '--title' << 'todo' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'todo'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('minitest')
  s.add_development_dependency('rspec-mocks')
  s.add_development_dependency('pry')
  s.add_development_dependency('pry-doc')
  s.add_runtime_dependency('gli','2.16.0')
end
