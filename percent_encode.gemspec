# coding: utf-8

require 'yaml'
require 'percent_encode/version'

Gem::Specification.new do |g|
  gemspec = YAML.load_file('gemspec.yml')

  g.name    = gemspec.fetch('name')
  g.version = gemspec.fetch('version') do
    lib_dir = File.join(File.dirname(__FILE__), 'lib')
    $LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

    PercentEncode::VERSION
  end

  g.summary, g.descriptions     = gemspec['summary'], gemspec['description']
  g.licenses, g.authors    = Array(gemspec['license']), Array(gemspec['authors'])
  g.email, g.homepage       = gemspec['email'], gemspec['homepage']

  glob = lambda { |p| g.files & Dir[*p] }

  g.files = `git ls-files`.split($/)
  g.files = glob[gemspec['files']] if gemspec['files']

  g.executables = gemspec.fetch('executables') do
    glob['bin/*'].map { |p| File.basename(p) }
  end

  g.default_executable = g.executables.first if Gem::VERSION < '1.7.'

  g.extensions       = glob[gemspec['extensions'] || 'ext/**/extconf.rb']
  g.test_files       = glob[gemspec['test_files'] || '{test/{**/}*_test.rb']
  g.extra_rdoc_files = glob[gemspec['extra_doc_files'] || '*.{txt,md}']

  g.require_paths = Array(gemspec.fetch('require_paths') {
    %w[ext lib].select { |d| File.directory?(d) }
  })

  g.requirements              = gemspec['requirements']
  g.required_ruby_version     = gemspec['required_ruby_version']
  g.required_rubygems_version = gemspec['required_rubygems_version']
  g.post_install_message      = gemspec['post_install_message']

  split = lambda { |str| str.split(/,\s*/) }

  if gemspec['dependencies']
    gemspec['dependencies'].each do |n, v|
      g.add_dependency(name, split[versions])
    end end

  if gemspec['development_dependencies']
    gemspec['development_dependencies'].each do |n, v|
      g.add_development_dependency(name, split[versions])
    end
  end
end
