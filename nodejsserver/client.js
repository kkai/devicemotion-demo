var socket = io.connect('http://futurict.local:8080/');
var ax, ay, az = 0;
var max = 0;
window.addEventListener('devicemotion', function (e) {
	ax = e.accelerationIncludingGravity.x;
	ay = e.accelerationIncludingGravity.y;
	az = e.accelerationIncludingGravity.z;
  max = Math.sqrt( ax*ax + ay*ay + az*az);
}, false);

setInterval(function() {
  socket.emit('my other event', max);
}, 200);

  socket.on('news', function (data) {
    //console.log(data);
    //socket.emit('my other event', max);
    });
