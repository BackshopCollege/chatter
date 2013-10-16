$: << "lib"

require 'socket'
require 'emitter'
require 'stream'
require 'server'
require 'chatter'
require 'watcher'

chat_server  =  Chatter.new(IOWatcher.new)
chat_server.start