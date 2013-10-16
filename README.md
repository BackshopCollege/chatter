# Chatter
###### #irresponsibleruby

Just to practice Ruby IO Sockets.  

My intention is experiemnt (SELECT) Asynchronous blocking I/O in Ruby ( Non-Blocking I/O with Blocking Notification).

Instead of Thread/Process per Connection I used the SELECT model that delegates my intention to kernel and it notify me when my intentions is ready :D

To experiment, open at least 3 terminals sessions.

````
 TERMINAL 1
 
 git clone https://github.com/tdantas/chattter.git
 cd chatter
 ruby chat.rb
 
```` 

````
  TERLMINAL 2
  telnet localhost 1234 
 
```` 


````
  TERLMINAL 3
  telnet localhost 1234 
 
```` 


After setup the terminals, type whatever you want ! 

###### Have Fun !

