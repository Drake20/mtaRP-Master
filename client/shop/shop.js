function callBackFunc()
{
	mta.triggerEvent("callBackResult");
	
}

function fuellTheTable_Shop(var1, var2, var3) {
	var row = "<tr>";
	row += "<td>"+var1+"</td>";
	row += "<td>"+var2+"</td>";
	row += "<td>"+var3+"</td>";
	row += "</tr>";
	document.getElementById("shopTable").getElementsByTagName("tbody")[0].innerHTML += row;
	var rows = document.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
   for (i = 1; i < rows.length; i++) {
        rows[i].addEventListener('click', function(event) {
			nextNode = document.getElementById("shopTable");
			var rows = nextNode.getElementsByTagName("tr");
			var inhalt= this.cells[0].innerHTML;
          mta.triggerEvent("sendMessageTO", inhalt);
        });
	}
}

function writeKategorie(kate1, kate2, kate3)
{
	var row2 = "<th>"+kate1+"</th>";
	row2 += "<th>"+kate2+"</th>";
	row2 += "<th>"+kate3+"</th>";
	document.getElementById("shopTable").getElementsByTagName("tbody")[0].innerHTML += row2;
}


function closeGUI()
{
	 mta.triggerEvent("closenpc_1webwindow", "npc_1");
}