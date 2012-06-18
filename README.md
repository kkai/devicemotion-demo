devicemotion-demo
=================

The main reason I upload this on git hub is to 
embarrass me in front of my distributed systems students (showing them really bad code) 
and get them programming/using github.

This is a small demo I put together 
in a couple of hours for an EU project exhibition. 
Very preliminary, quick. It shows how to 
use and stream the device motion of a mobile in javascript.

I combined the following sample code together,

for the nodejs server:

[simple chat server tutorial](http://martinsikora.com/nodejs-and-websocket-simple-chat-tutorial)

[3d css cube](http://www.paulrhayes.com/2009-07/animated-css3-cube-interface-using-3d-transforms/)

for the processing client:

[3d cube world](http://openprocessing.org/sketch/19216)


If you want to run it:
you need node.js and processing.


Edit the client.js and server.js replacing "futurict.local" with the
.local name or ip address of your machine.

start the processing application first.
then start the node server with

    node server.js

The processing application opens a socket server on port 10002.
The node server connects to the processing application.
The node server runs on port 8080.
Connect to the node server with a browser on a smart phone.
http://futurict.local:8080  (replace futurict.local again with your machine name)

A red cube should show up in the visualization. The faster you shake your phone the larger the
transparent cube gets.

Thanks to Paul Hayes http://www.paulrhayes.com
and Martin Sikora http://martinsikora.com
for their demos/posts.


