-- Cloud Ecosystem Installer
local files = {
    { url = "https://raw.githubusercontent.com/Frez7373/CCapps/refs/heads/main/CloudClient", path = "CloudClient" },
    { url = "https://raw.githubusercontent.com/Frez7373/CCapps/refs/heads/main/CloudServer", path = "CloudServer" },
    { url = "https://raw.githubusercontent.com/Frez7373/CCapps/refs/heads/main/Cloudnet", path = "Cloudnet" },
    { url = "https://raw.githubusercontent.com/Frez7373/CCapps/refs/heads/main/PrintHub", path = "PrintHub" }
}

local function drawProgressBar(current, total)
    local width = 20
    local progress = math.floor((current / total) * width)
    local bar = "[" .. string.rep("#", progress) .. string.rep("-", width - progress) .. "]"
    term.setCursorPos(1, 3)
    write("Progress: " .. bar .. " " .. math.floor((current / total) * 100) .. "%")
end

term.clear()
term.setCursorPos(1, 1)
print("--- Cloud Ecosystem Installer ---")
print("")

for i, file in ipairs(files) do
    term.setCursorPos(1, 2)
    term.clearLine()
    write("Downloading: " .. file.path)
    drawProgressBar(i - 1, #files)

    local response = http.get(file.url)
    
    if response then
        local content = response.readAll()
        response.close()
        
        local f = fs.open(file.path, "w")
        f.write(content)
        f.close()
    else
        term.setCursorPos(1, 4)
        error("Failed to download: " .. file.path)
    end
    
    drawProgressBar(i, #files)
end

term.setCursorPos(1, 4)
print("\nInstallation completed successfully!")
print("Press any key to exit.")
os.pullEvent("key")
term.clear()
term.setCursorPos(1, 1)
