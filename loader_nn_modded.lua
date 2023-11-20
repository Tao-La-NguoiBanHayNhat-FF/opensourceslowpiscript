-- Loading Read
getgenv().LoaderExecCount = 0
getgenv().key=script_key;
if getgenv().key == nil then
    getgenv().key = "none"
    
elseif getgenv().key == "Put-Your-Key-Inside-Here" then
    getgenv().key = "none"
end
script_key = nil
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tao-La-NguoiBanHayNhat-FF/opensourceslowpiscript/main/loader_header.lua"))()
