atom_feed do |feed|
  title = request.path[1..-1] == '404'? ' Not Found' : ' Internal Server Error'
  feed.title(request.path[1..-1],title)
  feed.content(@exception.message)
end
