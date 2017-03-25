all = task :default

directory 'build'
Dir.glob("source/configs/*").each do |config|
  desc "compile #{config}"
  t = file "build/#{File.basename(config).gsub(".config", ".pb")}" => [config, 'build'] do |t|
    command = "cat #{config} | protoc --encode tutorial.AddressBook source/model/Addressbook.proto 2>&1 > #{t.name}"
    puts "Command: #{command}"
    output = `#{command}`
    puts "output: #{output}"
    res = $?.success?
    if !res
      sh "rm -rf #{t.name}"
      puts "error: #{output.gsub('input:', config + ":")}"
      # uncomment the next for fail on first error
      #raise 'error'
    end
  end
  all.enhance([t])
end
