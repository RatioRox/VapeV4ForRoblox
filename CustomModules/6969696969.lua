repeat task.wait() until gameIsLoaded() local Players = gameGetService(Players)
local ReplicatedStorage = gameGetService(ReplicatedStorage)
local yes = Players.LocalPlayer.Name
local ChatTag = {}
ChatTag[yes] =
            {
    TagText = Ratio V10 Private,
    TagColor = Color3.new(0.058823, 0.623529, 1)
}
local oldchanneltab
local oldchannelfunc
local oldchanneltabs = {}
for i, v in pairs(getconnections(ReplicatedStorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
    if
                v.Function
                and #debug.getupvalues(v.Function)  0
                and type(debug.getupvalues(v.Function)[1]) == table
                and getmetatable(debug.getupvalues(v.Function)[1])
                and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
            then
        oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
        oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
        getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
            local tab = oldchannelfunc(Self, Name)
            if tab and tab.AddMessageToChannel then
                local addmessage = tab.AddMessageToChannel
                if oldchanneltabs[tab] == nil then
                    oldchanneltabs[tab] = tab.AddMessageToChannel
                end
                tab.AddMessageToChannel = function(Self2, MessageData)
                    if MessageData.FromSpeaker and Players[MessageData.FromSpeaker] then
                        if ChatTag[Players[MessageData.FromSpeaker].Name] then
                            MessageData.ExtraData = {
                                NameColor = Players[MessageData.FromSpeaker].Team == nil and Color3.new(1, 1, 1)
                                            or Players[MessageData.FromSpeaker].TeamColor.Color,
                                Tags = {
                                    table.unpack(MessageData.ExtraData.Tags),
                                    {
                                        TagColor = ChatTag[Players[MessageData.FromSpeaker].Name].TagColor,
                                        TagText = ChatTag[Players[MessageData.FromSpeaker].Name].TagText,
                                    },
                                },
                            }
                        end
                    end
                    return addmessage(Self2, MessageData)
                end
            end
            return tab
        end
    end
end