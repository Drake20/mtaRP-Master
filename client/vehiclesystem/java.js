function closeWindow(){
	mta.triggerEvent("closevehinteractwebwindow", "vehInteract");
}

function loadVehicleBrief(){
	mta.triggerEvent("loadVehicleBriefURL");
}

function addIntoComboBox(arg) {
	newOption = document.createElement("option");
	comboBox = document.getElementById("playerSelect");
    newOption.text = (arg);
    comboBox.add(newOption);
}