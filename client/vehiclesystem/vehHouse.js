function fuellVehHouseList(arg) {
	newOption1 = document.createElement("option");
	comboBox1 = document.getElementById("fuellSelect1");
    newOption1.text = arg;
    comboBox1.add(newOption1);
}

function closeVehHouseSchWindow()
{
	mta.triggerEvent("closeSchutzHouseWebWindow");
}

function changeCar()
{
	var ele = document.getElementById("fuellSelect1");
	var text = ele.options[ele.selectedIndex].text;
	mta.triggerEvent("changeElementInHouse", text);
}

function buyCarForServer()
{
	var ele = document.getElementById("fuellSelect1");
	var text = ele.options[ele.selectedIndex].text;
	mta.triggerEvent("buyCarServerSide_1", text);
	mta.triggerEvent("closeSchutzHouseWebWindow");
}