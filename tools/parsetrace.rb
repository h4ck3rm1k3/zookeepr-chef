re = /\(\"([^\"]+)\"\, [\w\|]+\) = (\d)$/
seen = {}
fileObj = File.new("trace.txt", "r")

while (line = fileObj.gets)
  m = re.match(line)
  if (m)
    file = m[1]
    if not seen[file]
      #puts("File #{file}")
      seen[file]=1
    end
    #puts(m.string)
    #puts(line)
  else
    #puts "skip line", line
  end
end
fileObj.close

seen.sort.each do |file|
  puts("File #{file}")
end
