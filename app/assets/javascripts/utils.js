function hex2rgb( color ) {
var r,g,b;
var rgb = [];
if ( color.charAt(0) == '#' ) {
color = color.substr(1);
}

r = color.charAt(0)  + color.charAt(1);
g = color.charAt(2)  + color.charAt(3);
b = color.charAt(4)  + color.charAt(5);

rgb.push(parseInt( r,16 ));
rgb.push(parseInt( g,16 ));
rgb.push(parseInt( b ,16));
return rgb;
}

function setCookieNoLimit(name,value) {
	var date = new Date();
	date.setTime(date.getTime()+(3600*24*60*60*1000));
	var expires = "; expires="+date.toGMTString();
	document.cookie = name+"="+value+";"+expires+"; path=/";
}