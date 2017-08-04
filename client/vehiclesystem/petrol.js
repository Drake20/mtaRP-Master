function fuellCarList(arg, arg2) {
	newOption = document.createElement("option");
	comboBox = document.getElementById("fuellSelect");
    newOption.text = (arg+" ID|"+arg2);
    comboBox.add(newOption);
}

function getPetrolPrice(price)
{	
	document.getElementById('petrolPrice').innerHTML = "Preis pro Liter: "+price+" $";
	
}

function closeWindow()
{
	mta.triggerEvent("closePetrolWebWindow");
}

function sendPetrolToMTA()
{
	var ele = document.getElementById("fuellSelect");
	var text = ele.options[ele.selectedIndex].text;
	mta.triggerEvent("fillVehicle", text)
	
}