function closeWindow(){
	mta.triggerEvent("closeSupportGUI");
}

function callBackFuncSupp(){
	mta.triggerEvent("callBackSupportResult");
}

function loadWrite(){
	mta.triggerEvent("loadBrowserSupportWrite");
}

function loadRead(){
	mta.triggerEvent("loadBrowserSupportRead");
}

function writeTextForAdmins(){
	var select = document.getElementById("kategorieText");
	var kategorie = select.options[select.selectedIndex].text;
	
	var betreff = document.getElementById("topic").value;
	var text = document.getElementById("nachricht").value;
	mta.triggerEvent("writeServerSupportTicket", kategorie, betreff, text);
}

function makeResultInSupportTable(var1, var2, var3, var4)
{
	var row = "<tr>";
	row += "<td>"+var1+"</td>";
	row += "<td>"+var2+"</td>";
	row += "<td>"+var3+"</td>";
	row += "<td>"+var4+"</td>";
	row += "</tr>";
	document.getElementById("supportUserTable").getElementsByTagName("tbody")[0].innerHTML += row;
	var rows = document.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
   for (i = 1; i < rows.length; i++) {
        rows[i].addEventListener('click', function(event) {
			nextNode = document.getElementById("supportUserTable");
			var rows = nextNode.getElementsByTagName("tr");
			var inhalt= this.cells[0].innerHTML;
			mta.triggerEvent("triggerToServerRead", inhalt);
        });
	}
}

function inputSetAnswer(variable1, variable2, variable3)
{
	document.getElementById("topic").value = variable1;
	document.getElementById("answer").value = variable2;
	document.getElementById("adminAnswer").value = variable3;
}


/*Adminside */

function makeResultTable(var1, var2, var3, var4, var5)
{
	var row = "<tr>";
	row += "<td>"+var1+"</td>";
	row += "<td>"+var2+"</td>";
	row += "<td>"+var3+"</td>";
	row += "<td>"+var4+"</td>";
	row += "<td>"+var5+"</td>";
	row += "</tr>";
	document.getElementById("supportAdminTable").getElementsByTagName("tbody")[0].innerHTML += row;
	var rows = document.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
   for (i = 1; i < rows.length; i++) {
        rows[i].addEventListener('click', function(event) {
			nextNode = document.getElementById("supportAdminTable");
			var rows = nextNode.getElementsByTagName("tr");
			var inhalt= this.cells[0].innerHTML;
			mta.triggerEvent("giveAdminTheTicket", inhalt);
        });
	}
}

function inputSetUserQuestion(variable11, variable22)
{
	document.getElementById("adminTopic").value = variable11;
	document.getElementById("userQuestion").value = variable22;
}

function ticketLeave()
{
	mta.triggerEvent("takeTicketFromSupp");
	document.getElementById("adminTopic").value = "";
	document.getElementById("userQuestion").value = "";
	document.getElementById("adminAnswers").value = "";
}


function refreshList()
{
tbl = document.getElementById('supportAdminTable');
 
	while(tbl.rows.length>0)
	  {
		tbl.deleteRow(0);
	  }
	var row2 = "<th>ID</th>";
	row2 += "<th>Betreff</th>";
	row2 += "<th>Author</th>";
	row2 += "<th>Bearbeiter</th>";
	row2 += "<th>Status</th>";
	document.getElementById("supportAdminTable").getElementsByTagName("tbody")[0].innerHTML += row2;
	mta.triggerEvent("refreshTicketsForSupp");
}

function sendTicketBack()
{	
	var aTopic = document.getElementById("adminTopic").value;
	var answerFAdmin = document.getElementById("adminAnswers").value;
	mta.triggerEvent("sendSuppQuestionBack", aTopic, answerFAdmin);
	
	document.getElementById("adminTopic").value = "";
	document.getElementById("userQuestion").value = "";
	document.getElementById("adminAnswers").value = "";
}
