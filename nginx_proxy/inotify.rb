#!/bin/ruby

loop do
  change = `inotifywait -e close_write,moved_to,create $DYNAMICS`
  file_name = change.strip.split.last
  if file_name.match('\w*\.conf')
    `nginx -s reload`
  end
end
