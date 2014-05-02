guard 'shell' do
    watch %r{(plugin|t)/.+\.vim$} do |file|
        puts "-------- #{file.join} --------"
        system('rake test'); ''
    end
end
