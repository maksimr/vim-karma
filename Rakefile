#!/usr/bin/env rake

task :ci => [:dump, :test]

task :dump do
    sh 'vim --version'
end

task :test do
    sh 'vim-flavor test'
end

task :watch do
    sh 'guard'
end
