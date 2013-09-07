// proxy.pac
// A hack to allow wildcard DNS aliasing since /etc/hosts can't do it
// This is a way to alias a whole domain to your localhost
// All vhosts get the name <whatever>.dev and the requests will be
// picked up by the local web server
function FindProxyForURL(url, host) {
	if (shExpMatch(host,"*.dev")) {
		//alert("proxy local")
		return "PROXY localhost";
	}
	//alert("proxy direct")
	return "DIRECT";
}
