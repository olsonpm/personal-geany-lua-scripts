ext = geany.fileinfo()["ext"]

TMP_DIR = "/home/phil/.custom-scripts/geany"
SAVE_FILE = TMP_DIR .. "/on-save.tmp"
BACKUP_FILE = TMP_DIR .. "/backup_file.tmp"
BACKUP_BUFFER = TMP_DIR .. "/backup_buffer.tmp"


-- BELOW LOGIC
--
-- SAVE_FILE is the formatted output.  The big assumption is that if it has no length (zero file size), then the file has not ran through this code 
--   and thus needs to be formatted.  If the format fails and results in a zero file size for some reason, it gets reset to BACKUP_FILE
--
-- BACKUP_FILE is the file before getting formatted
--
-- BACKUP_BUFFER is the current buffer text before getting formatted (not sure why this would differ from BACKUP_FILE, but creating it just in case

function formatJson(file) 
	local pos = geany.caret()
	
	-- Write backups in case save goes all infinite loop on us
	os.execute("cp " .. geany.filename() .. " " .. BACKUP_FILE)
	local buffer = geany.text()
	local bufferOut = assert(io.open(BACKUP_BUFFER, "w+"))
	io.output(bufferOut)
	io.write(buffer)
	io.close(bufferOut)
	
	local tmp = "jsonlint -p " .. geany.filename() .. " > " .. SAVE_FILE
	os.execute(tmp)
	geany.status("formatting json file: " .. geany.filename()) 
	local formatted = file:read("*all")
	
	-- prevent format from killing process due to fileSize == 0 infinite loop
	if (formatted == "") then
		geany.message("Error", "Formatted file was empty.  Resetting back to previous buffer.")
		os.execute("cp " .. BACKUP_FILE .. " " .. SAVE_FILE)
		formatted = buffer
	end
	
	geany.text(formatted)
	geany.save()
	
	-- The following is necessary in order to put the cursor closer to the middle of the page
	--   (below implementation is 20 rows from the bottom).  It would be cool to calculate the
	--   number of rows the current page displays then get half of that, but I'm not going
	--   to spend the time to implement that.
	local line, col = geany.rowcol(pos)
	line = line + 20
	local tmpPos = geany.rowcol(line, col)
	geany.caret(tmpPos)
	geany.caret(pos)
end

function formatJavascript(file) 
	local pos = geany.caret()
	
	-- Write backups in case save goes all infinite loop on us
	os.execute("cp " .. geany.filename() .. " " .. BACKUP_FILE)
	local buffer = geany.text()
	local bufferOut = assert(io.open(BACKUP_BUFFER, "w+"))
	io.output(bufferOut)
	io.write(buffer)
	io.close(bufferOut)
	
	local tmp = "js-beautify -f " .. geany.filename() .. " -o " .. SAVE_FILE
	os.execute(tmp)
	geany.status("formatting js file: " .. geany.filename()) 
	local formatted = file:read("*all")
	
	-- prevent format from killing process due to fileSize == 0 infinite loop
	if (formatted == "") then
		geany.message("Error", "Formatted file was empty.  Resetting back to previous buffer.")
		os.execute("cp " .. BACKUP_FILE .. " " .. SAVE_FILE)
		formatted = buffer
	end
	
	geany.text(formatted)
	geany.save()
	
	-- The following is necessary in order to put the cursor closer to the middle of the page
	--   (below implementation is 20 rows from the bottom).  It would be cool to calculate the
	--   number of rows the current page displays then get half of that, but I'm not going
	--   to spend the time to implement that.
	local line, col = geany.rowcol(pos)
	line = line + 20
	local tmpPos = geany.rowcol(line, col)
	geany.caret(tmpPos)
	geany.caret(pos)
end

function formatHtml(file) 
	local pos = geany.caret()
	
	-- Write backups in case save goes all infinite loop on us
	os.execute("cp " .. geany.filename() .. " " .. BACKUP_FILE)
	local buffer = geany.text()
	local bufferOut = assert(io.open(BACKUP_BUFFER, "w+"))
	io.output(bufferOut)
	io.write(buffer)
	io.close(bufferOut)
	
	local tmp = "htmlbeautifier < " .. geany.filename() .. " > " .. SAVE_FILE
	os.execute(tmp)
	geany.status("formatting html file: " .. geany.filename()) 
	local formatted = file:read("*all")
	
	-- prevent format from killing process due to fileSize == 0 infinite loop
	if (formatted == "") then
		geany.message("Error", "Formatted file was empty.  Resetting back to previous buffer.")
		os.execute("cp " .. BACKUP_FILE .. " " .. SAVE_FILE)
		formatted = buffer
	end
	
	geany.text(formatted)
	geany.save()
	
	-- The following is necessary in order to put the cursor closer to the middle of the page
	--   (below implementation is 20 rows from the bottom).  It would be cool to calculate the
	--   number of rows the current page displays then get half of that, but I'm not going
	--   to spend the time to implement that.
	local line, col = geany.rowcol(pos)
	line = line + 20
	local tmpPos = geany.rowcol(line, col)
	geany.caret(tmpPos)
	geany.caret(pos)
end

function formatCSharp(file) 
	local pos = geany.caret()
	
	-- Write backups in case save goes all infinite loop on us
	os.execute("cp " .. geany.filename() .. " " .. BACKUP_FILE)
	local buffer = geany.text()
	local bufferOut = assert(io.open(BACKUP_BUFFER, "w+"))
	io.output(bufferOut)
	io.write(buffer)
	io.close(bufferOut)
	
	local tmp = "astyle --style=allman < " .. geany.filename() .. " > " .. SAVE_FILE
	os.execute(tmp)
	geany.status("formatting c# file: " .. geany.filename()) 
	local formatted = file:read("*all")
	
	-- prevent format from killing process due to fileSize == 0 infinite loop
	if (formatted == "") then
		geany.message("Error", "Formatted file was empty.  Resetting back to previous buffer.")
		os.execute("cp " .. BACKUP_FILE .. " " .. SAVE_FILE)
		formatted = buffer
	end
	
	geany.text(formatted)
	geany.save()
	
	-- The following is necessary in order to put the cursor closer to the middle of the page
	--   (below implementation is 20 rows from the bottom).  It would be cool to calculate the
	--   number of rows the current page displays then get half of that, but I'm not going
	--   to spend the time to implement that.
	local line, col = geany.rowcol(pos)
	line = line + 20
	local tmpPos = geany.rowcol(line, col)
	geany.caret(tmpPos)
	geany.caret(pos)
end

onSaveExts = {
	[".js"] = formatJavascript,
	[".json"] = formatJson,
	[".html"] = formatHtml,
	[".erb"] = formatHtml,
        [".cs"] = formatCSharp
}

local file = assert(io.open(SAVE_FILE, "r"))
local fileSize = file:seek("end")

if (onSaveExts[ext] ~= nil and fileSize == 0) then
	onSaveExts[ext](file)
else
	os.execute("> " .. SAVE_FILE)
end

file:close()
