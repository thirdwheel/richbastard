function shoutbox_focus()
{
	zeShoutbox=document.getElementById('shoutbox');
	if (zeShoutbox.value == zeShoutbox.defaultValue)
	{
		zeShoutbox.value="";
		zeShoutbox.style.color="black";
	}
}
function shoutbox_blur()
{
	zeShoutbox=document.getElementById('shoutbox');
	if (zeShoutbox.value == "")
	{
		zeShoutbox.value=zeShoutbox.defaultValue;
		zeShoutbox.style.color="grey";
	}
}
function shoutbox_submit()
{
	zeShoutbox=document.getElementById('shoutbox');
	message="";
	for (i=0; i < zeShoutbox.value.length; i++)
	{
		chrCode=zeShoutbox.value.charCodeAt(i);
		message+='%'+(chrCode).toString(16);
	}
	var xHttp = new XMLHttpRequest();
	xHttp.onreadystatechange=shoutbox_rsc;
	xHttp.open("POST", "ajax/shoutbox.php", true);
	xHttp.setRequestHeader("Content-type",
		"application/x-www-form-urlencoded");
	xHttp.send("game=-1&type=msg&reci=-1&mesg="+message);
	return false;
}

function shoutbox_rsc ()
{
	if (this.readyState == 4 && this.status == 200)
	{
		if (this.responseText != "200 OK")
		{
			alert("Send message fail: " + this.responseText);
		}
		zeShoutBox=document.getElementById('shoutbox');
		zeShoutBox.value=zeShoutBox.defaultValue;
		zeShoutBox.style.color="grey";
		zeShoutBox.blur();
	}
}
