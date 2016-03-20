var lastChatTS=0;

function check_chat()
{
	var xHttp = new XMLHttpRequest();
	xHttp.onreadystatechange=checkchat_rsc;
	xHttp.open("GET", "ajax/check_chat.php?game=-1&last=" + lastChatTS,
		true);
	xHttp.send();
}
function checkchat_rsc()
{
	if (this.readyState == 4 && this.status == 200)
	{
		aCommand=this.responseText.split("\n");
		iCommand=aCommand.length
		mainwin=document.getElementById('mainwindow');
		if (aCommand[0] == "200 OK")
		{
			for (i=1; i < iCommand; i++)
			{
				sCommand=aCommand[i];
				if (sCommand.substr(0,4) == '202 ')
				{
					sCommand=sCommand.substr(4,
						sCommand.length);
					aValues=sCommand.split(",");
					lastChatTS=aValues[0];
					msgtype=aValues[1];
					sender=aValues[2];
					recipient=aValues[3];
					msgloc=(lastChatTS + msgtype + sender +
						recipient).length + 4
					message=sCommand.substr(msgloc, 
						sCommand.length);

					if (msgtype == 'me')
						insertmsg='* '+sender
					else
						insertmsg='&lt;'+sender+'&gt;';

					if (recipient != "")
						insertmsg='[PRIV] '+insertmsg;

					mainwin.innerHTML += '<div>'+insertmsg
						+' '+message+'</div>';
				}
				if (sCommand.substr(0,4) == '203 ')
					lastChatTS=sCommand.substr(4,20);
			}
			setTimeout(check_chat, "1000");
		}
		else
		{
			mainwin.innerHTML+="<div>*** Server said: "
				+this.responseText, "</div>";
			setTimeout(check_chat, "10000");
		}
	}
}
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
