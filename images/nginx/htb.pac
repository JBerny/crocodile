function FindProxyForURL(url, host) {
    if (host.endsWith(".htb")){
	alert("custom direct");
        return 'PROXY localhost:3120';
    }
    // All other domains should connect directly without a proxy
    return "DIRECT";
}
