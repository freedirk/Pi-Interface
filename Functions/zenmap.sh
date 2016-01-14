#!/bin/bash

export DISPLAY=:10
sudo zenmap >/dev/null 2>&1 &

echo -e "Content-type: text/html\r\n\r\n"
#echo -e "HTTP/1.1 307 Temporary Redirect\r\nLocation: /Pi Interface/main.html\r\nContent-type: text/html\r\n\r\n"

#echo "Please follow <a href="/Pi Interface/main.html">this link</a>."

cat <<EOF
<html>
	<head>
	<script type="text/javascript">
	function load()
	{
	window.location.href = "/Pi Interface/main.html";

	}
	</script>
	</head>

	<body onload="load()">
	<h1>Please follow <a href="/Pi Interface/main.html">this link</a></h1>
	</body>
</html>

EOF
