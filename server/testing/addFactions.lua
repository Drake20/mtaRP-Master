Factionen = {}
Factionen.__index = Factionen


function Factionen:Constructor()
	local init = {}
	setmetatable(init, self)
	init.__index = self
	
	init.fraktionen = {}
	return init
end


function Factionen:add(name)
	table.insert(self.fraktionen, name)
end


function Factionen:Count()
	return #self.fraktionen
end
