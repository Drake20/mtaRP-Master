function meldung()
	{
		var spielern;
		var password;
		spielern = document.formular1.spieler.value;
		password = document.formular1.pass.value;
		mta.triggerEvent("javaS", spielern, password);
		return false;
	}
function registerW()
	{
		var spielerns;
		var passwords;
		var passwords2;
		var email;
		spielerns = document.formularReg.Rspieler.value;
		passwords = document.formularReg.Rpass.value;
		passwords2 = document.formularReg.Rpass2.value;
		email = document.formularReg.Remail.value;
		mta.triggerEvent("javaReg", spielerns, passwords, passwords2, email);
		return false;
	}
function IntroFinished()
	{
		mta.triggerEvent("finishedIntro");
		return false;
	} 
function IntroTicketStop()
	{
		mta.triggerEvent("stopTicketScreen");
		return false;
	}
	
function setName(name)
	{
		document.formular1.spieler.value += name;
		mta.triggerEvent("returnBackVariable");
	}
	

function setNameRegister(name)
	{
		document.formularReg.Rspieler.value += name;
		mta.triggerEvent("returnBackVariable");
	}	
	
	
	/* Messages */
function printMessage(value) 
	{
		document.getElementById("message1").innerHTML = value;
		return false;
	}	
	
function Variant1()
	{
		mta.triggerEvent("chooseVariant1");
		return false;
	}
function Variant2()
	{
		mta.triggerEvent("chooseVariant2");
		return false;
	}
function Variant3()
	{
		mta.triggerEvent("chooseVariant3");
		return false;
	}
	
function variant1Script()
	{
		var kennzeichen;
		var vehicle;
		kennzeichen = document.var1script.kennz.value;
		vehicle = document.var1script.vehid.value;
		mta.triggerEvent("VehicleOfficeAn", kennzeichen, vehicle);
		
		return false;
	}
	
function variant2Script()
	{
		var vehicle;
		vehicle = document.var2script.vehid.value;
		mta.triggerEvent("VehicleOfficeExit", vehicle);
		
		return false;
	}
function variant3Script()
	{
		var vehicle;
		vehicle = document.var3script.vehid.value;
		mta.triggerEvent("VehicleOfficeSaveTy", vehicle);
		
		return false;
	}
	
function CloseOfficeWindow()
	{
		mta.triggerEvent("closeOfficeWebWindow");
		return false;
	}

// Repair System

function varRepairWb()
	{
		mta.triggerEvent("VehicleRepairWebRep");	
		return false;
	}

function disableRepair()
{
	document.tuneForm.button1.disabled =true;
	document.lackForm.button1.disabled =true;
}
	
function VehicleLack1Web()
	{
		var r = document.Lack1Form.farb1.value;
		var g = document.Lack1Form.farb2.value;
		var b = document.Lack1Form.farb3.value;
		
		var r2 = document.Lack1Form.farb4.value;
		var g2 = document.Lack1Form.farb5.value;
		var b2 = document.Lack1Form.farb6.value;
		
		mta.triggerEvent("ClientLack1Veh", r, g, b, r2, g2, b2);	
		return false;
	}
	
function vehiclePaintBuy()	
	{	
		var r = document.Lack1Form.farb1.value;
		var g = document.Lack1Form.farb2.value;
		var b = document.Lack1Form.farb3.value;
		
		var r2 = document.Lack1Form.farb4.value;
		var g2 = document.Lack1Form.farb5.value;
		var b2 = document.Lack1Form.farb6.value;
		
		mta.triggerEvent("clientPaintBuy", r, g, b, r2, g2, b2);
	}
	
function varCommingS()
	{
		mta.triggerEvent("VehicleRepairComming");	
		return false;
	}

function VehicleCamera()
	{
		mta.triggerEvent("VehicleSetCamera");
		return false;
	}	
	
	
function RepairWindowObenLack()
	{
		mta.triggerEvent("VehicleChangeLackWinBrow");
		return false;
	}
function CloseRepairWindow()
	{
		mta.triggerEvent("closeRepairWebWindow");
		return false;
	}
function goToHomeMenue()
	{
		mta.triggerEvent("loadChoosePage");
		return false;
	}
	
	
// Drivingschool

function School1()
	{
		mta.triggerEvent("School_ClassA");
	}
		
function School2()
	{
		mta.triggerEvent("School_ClassB");
	}
	
function School3()
	{
		mta.triggerEvent("School_ClassC");
	}
	
function School4()
	{
		mta.triggerEvent("School_ClassD");
	}
	
function School5()
	{
		mta.triggerEvent("School_ClassT");
	}
	
function School6()
	{
		mta.triggerEvent("School_ClassHeli");
	}

function School7()
	{
		mta.triggerEvent("School_ClassF1");
	}
	
function School8()
	{
		mta.triggerEvent("School_ClassF2");
	}

function School9()
	{
		mta.triggerEvent("School_ClassBoat");
	}

function CloseSchoolWindow()
	{
		mta.triggerEvent("closeSchoolWebWindow");
	}
	
function SchoolInformation()
{
	mta.triggerEvent("schoolLoadInformation");
}

function SchoolBackToMain()
{
	mta.triggerEvent("SchoolBackToMain");
}