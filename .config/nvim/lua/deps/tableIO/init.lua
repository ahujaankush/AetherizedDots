--  The MIT License (MIT)
--  Copyright © 2016 Pietro Ribeiro Pepe.

--  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-- Script to write table to file
-- Version 1.2 - 2017/04/10

local tableIO = {}

local writeTable,getString,prints,strings,write

------------------------------------------
-- Public functions
------------------------------------------

--[[ tableIO.tableToString
Gets the tableIO serialization string of a given table
-
Params:
	t: the table to be serialized with tableIO
	(optional)name: the name the table will have on the file, default is 'table'
-
Returns:
	-string: the tableIO serialization of the table
]]
function tableIO.tableToString(t)
	return getString(t)
end

--[[ tableIO.stringToTable
Converts a tableIO serialization string to a table
-
Params:
	string: a tableIO serialization string to be converted to table
-
Returns:
	-table: the conversion of the string
]]
function tableIO.stringToTable(string)
	local lines = {}
	for i in string.gmatch(string, '[^\n\t,]+') do
		--print(i)
  		table.insert(lines,i)
	end
	return getTable(lines)
end

--[[ tableIO.saveOnFile
Save a table to a opened file. It saves field by field
-
Params:
	file: the opened file
	t: the table
	(optional)name: the name the table will have on the file, default is 'table'
-
Returns:
	-boolean: whether or not the save operation was successfull
	-string: when not successfull, the error message, otherwise, nil
]]
function tableIO.saveOnFile(file,t,name)
	name = name or 'table'
	file:write('local '..name..' = ')
	writeTable(t,file)
	file:write('\n\nreturn '..name)
end

--[[ tableIO.save
Save a table to a path, using io. It saves field by field
-
Params:
	t: the table
	path: a string represeting where the file should be saved
	(optional)name: the name the table will have on the file, default is 'table'
-
Returns:
	-boolean: whether or not the save operation was successfull
	-string: when not successfull, the error message, otherwise, nil
]]
function tableIO.save(t,path,name)
	if type(t)~='table' then
		return false,'The input must be a table'
	end
	local file = io.open(path,'w')
	if file==nil then
		return false,'The file could not be opened'
	end
	tableIO.saveOnFile(file,t,name)
	io.close(file)
	return true
end

------------------------------------------
-- Private functions and data
------------------------------------------

write = function(v,file)
	file:write(v)
end

local prints = {
	number = write,
	boolean = function(bool,file) write(tostring(bool),file) end,
	string = function(string,file) write("'"..string .."'",file) end,
	table = function(t,file,offset) writeTable(t,file,offset) end
}

local strings = {
	number = tostring,
	boolean = tostring,
	string = function(string) return "'"..string .."'" end,
	table = function(t,offset) return getString(t,offset) end
}

function writeTable(t,file,offset)
	offset = offset or ''
	file:write('{')
	local off = offset..'\t'
	local first = true
	for i,v in pairs(t) do
		local f = prints[type(v)]
		if f then
			if first then first = false
			else file:write(',') end
			file:write('\n')
			if type(i)~='number' or i==0 then
				file:write(off..i..' = ')
			else
				file:write(off)
			end
			 f(v,file,off)
		end
	end
	file:write('\n'..offset..'}')
end

function getString(t,offset)
	offset = offset or ''
	local off = offset..'\t'
	local str = '{'..off
	local first = true
	for i,v in pairs(t) do
		local f = strings[type(v)]
		if f then
			if first then first=false
			else str=str ..',' end
			str = str ..'\n'..off ..strings[type(i)](i)..' = '..f(v,off)
		end
	end
	return str ..'\n'..offset ..'}'
end

function getTable(lines,idx)
	if idx then idx=idx+1 else idx=2 end
	local t = {}
	local line=lines[idx]
	local strs,key,value,c
	while line~='}' do
		strs = {}
		for i in string.gmatch(line,'[^=]+') do table.insert(strs,i) end
		strs[1] = strs[1]:sub(1,strs[1]:len()-1)
		strs[2] = strs[2]:sub(2)
		if string.sub(strs[1],1,1)=="'" then key = string.sub(strs[1],2,string.len(strs[1])-1)
		else key = tonumber(strs[1]) end
		c = string.sub(strs[2],1,1)
		if c=="'" then t[key] = string.sub(strs[2],2,string.len(strs[2])-1)
		elseif c=='{' then t[key],idx = getTable(lines,idx)
		elseif c=='t' then t[key]=true
		elseif c=='f' then t[key]=false
		else t[key] = tonumber(strs[2]) end
		idx = idx+1
		line = lines[idx]
	end
	return t,idx
end

return tableIO