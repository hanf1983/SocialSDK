require(["sbt/dom","sbt/connections/ConnectionsConstants","sbt/Endpoint","sbt/xml","sbt/xpath"], function(dom,conn,Endpoint,xml,xpath) {
	var endpoint = Endpoint.find("connections");
    
    var url = "/dogear/atom";
    
    var options = { 
        method : "GET", 
        handleAs : "text"
    };
    
    endpoint.request(url, options).then(
    	function(response) {
      		var doc = xml.parse(response);
			var link = xpath.selectText(doc,"/a:feed//a:link/@href",conn.Namespaces);
			console.log(link);
			var a = document.createElement("a");
			a.setAttribute("href", link);
			a.appendChild(dom.createTextNode(link));
      		dom.byId("content").appendChild(dom.createTextNode("Link: "));
      		dom.byId("content").appendChild(a);
        },
        function(error){
            dom.setText("content", error);
        }
    );
});