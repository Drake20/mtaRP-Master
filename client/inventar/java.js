

function fuellTheGridList(var1, var2, var3) {
	var row = "<tr>";
	row += "<td>"+var1+"</td>";
	row += "<td>"+var2+"</td>";
	row += "<td>"+var3+"</td>";
	row += "</tr>";
	document.getElementById("invTable").getElementsByTagName("tbody")[0].innerHTML += row;
}

function writeKare(kate1, kate2, kate3)
{
	var row2 = "<th>"+kate1+"</th>";
	row2 += "<th>"+kate2+"</th>";
	row2 += "<th>"+kate3+"</th>";
	document.getElementById("invTable").getElementsByTagName("tbody")[0].innerHTML += row2;
}

function fuellkategorieWithObjekts(var1, var2, var3) {
	var row = "<tr>";
	row += "<td>"+var1+"</td>";
	row += "<td>"+var2+"</td>";
	row += "<td>"+var3+"</td>";
	row += "</tr>";
	document.getElementById("invTable").getElementsByTagName("tbody")[0].innerHTML += row;
	var rows = document.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
   for (i = 1; i < rows.length; i++) {
        rows[i].addEventListener('click', function(event) {
			nextNode = document.getElementById("invTable");
			var rows = nextNode.getElementsByTagName("tr");
			var inhalt= this.cells[0].innerHTML;
          mta.triggerEvent("sendMessageTO", inhalt);
        });
	}
}

function callBackFunc()
{
	mta.triggerEvent("callBackResult");
	
}

function sendToMTA(event)
{
	var ele = document.event.cells[0].value;
	mta.triggerEvent("sendMessageTO", ele);
}


function closeInventar()
{
	mta.triggerEvent("closeInventarWebWindow");
}

function showObjects()
{
tbl = document.getElementById('invTable');
 
	while(tbl.rows.length > 0)
	  {
		tbl.deleteRow(0);
	  }
	mta.triggerEvent("showServerObjects");
}

function showScheine()
{
tbl = document.getElementById('invTable');
 
	while(tbl.rows.length>0)
	  {
		tbl.deleteRow(0);
	  }
	mta.triggerEvent("showServerLicences");
}

function showFahrzeugSchluessel()
{
tbl = document.getElementById('invTable');
 
	while(tbl.rows.length>0)
	  {
		tbl.deleteRow(0);
	  }
	mta.triggerEvent("showTheVehicleKeys");
}
