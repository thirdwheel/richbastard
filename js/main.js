var xHttp = new XMLHttpRequest();

function beginGame()
{
	xHttp.onreadystatechange = beginGame_rsc;
	xHttp.open("GET", "ajax/login.php?nickname=" 
		+ document.getElementById('loginForm').nickname.value, true);
	xHttp.send();
	return false;
}
function beginGame_rsc ()
{
	if (xHttp.readyState == 4 && xHttp.status == 200)
	{
		if (xHttp.responseText == "200 OK")
		{
			document.getElementById('loginForm').nickname.readonly="readonly";
			document.getElementById('login').style.display="none";
			document.getElementById('gamelist').style.display="block";
		}
		else
		{
			errorDiv=document.getElementById('loginError');
			errorDiv.style.display="block";
			errorDiv.innerHTML="Server said: " + xHttp.responseText;
			setTimeout("document.getElementById('loginError').style.display='none';", 3000);
		}
	}
}
