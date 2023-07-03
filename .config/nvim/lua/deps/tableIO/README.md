# tableIO
tableIO aims to be a simple lib to help saving application data from table files, being able to:
* Write table with io in a given path or file, just needing to `require` it to load later (if it's a `.lua`).
* Serialize table to string, so it can be saved on .txt file and be read later.
* Deserialize a string created with tableIO.

Serialization is essentially useful if you want to save data with another save mechanism instead of Lua's I/O, like [love.filesystem](https://love2d.org/wiki/love.filesystem) from [LÖVE](https://love2d.org/) game engine. (in this case is still possible to directly save and require the `.lua`, if instead of `require`, you use [love.filesystem.load](https://love2d.org/wiki/love.filesystem.load)).

tableIO writes or serializes all (key,value) pairs where value is of any of these types:
* `number`
* `string`
* `boolean`
* `table`

Values of type `function` or `nil` will naturally get skipped (not written). It's not able to save `metadata` and `userdata` and will not work with tables with cycles.

* Tables saved as .lua can be read using `require`.
* Tables saved with a serialized string in a .txt can be extracted with a read('*all') call with a file opened with the .txt path. For detailed implementation see `main.lua`.

## Usage
tableIO contains 4 functions that can be called:
### `save`
Saves table with io in a given path. Specially useful to save the table and `require` it when needed.

Parameters:
* t: a reference to the table to be written
* path: a string represeting where the file should be saved, needs the extension (.lua,.txt,etc)
* (OPTIONAL) name: a string with the name the table will have on the file, default is 'table'

Returns:
* `boolean`: whether or not the save operation was successfull
* `string`: when not successfull, the error message, otherwise, nil

### `saveOnFile`
Save a table to a opened file.

Parameters:
* file: the opened file
* t: the table
* (optional)name: the name the table will have on the file, default is 'table'

Returns:
* `boolean`: whether or not the save operation was successfull
* `string`: when not successfull, the error message, otherwise, nil

### `tableToString`
Gets the tableIO serialization string of a given table. Can be written to a file to be read later.

Parameters:
* t: the table to be serialized with tableIO
* (optional)name: the name the table will have on the file, default is 'table'

Returns:
* `string`: the tableIO serialization of the table

### `stringToTable`
Converts a tableIO serialization string to a table.

Parameters:
* string: a tableIO serialization string to be converted to table.

Returns:
* `table`: the conversion of the string

### Saving
Simply require the script and call the save function:
```Lua
  local tableIO = require 'tableIO'
  tableIO.save({key1 = 20, key2 = 'hello_world'},'myPath.lua')
```
### Reading
Require the file, using the path where it was saved
```Lua
  local myTable = require 'myPath'
```

## Example
A more complete example, including serialization and deserialization is available in `main.lua`
