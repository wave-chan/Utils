--## SERVICES ##--
local HttpService = game:GetService("HttpService")

--## SCRIPT ##--
local Configs = {
  Cache = {}
}

function Configs:Init(OptionFolderPath, Options)
  local InitDone = false
  for OptionId, OptionTable in Options do
      if not isfile or not writefile or not readfile then continue end
      if typeof(OptionTable) ~= "table" or not OptionTable.SetValue or not OptionTable.OnChanged then continue end

      Cache[OptionId] = {
        Changed = OptionTable.Changed,
      }

      local FilePath = `{OptionsFolderPath}\\{OptionId}.txt`
      if isfile(FilePath) then
          local DecodedValue = HttpService:JSONDecode(readfile(FilePath))

          if OptionTable.Type == "Dropdown" and typeof(OptionTable.Values) == "table" then
              local ValuesSize = 0
              for _, _ in OptionTable.Values do
                  ValuesSize += 1
              end

              if ValuesSize < 1 then
                  local Values = {}

                  if typeof(DecodedValue) == "table" then
                      for Index, _ in DecodedValue do
                          table.insert(Values, Index)
                      end
                  else
                      table.insert(Values, DecodedValue)
                  end

                  OptionTable:SetValues(Values)
                  task.wait(0)
              end
          end

          OptionTable:SetValue(DecodedValue)
      end

      OptionTable:OnChanged(function(...)
          if not InitDone then return end

          local AllVals = {...}

          local OldChanged = Cache[OptionId] and Cache[OptionId].Changed
          if OldChanged then
              task.spawn(function()
                  OldChanged(unpack(AllVals))
              end)
          end

          local NewValue = Options[OptionId].Value
          local EncodedValue = HttpService:JSONEncode(NewValue)
          writefile(FilePath, EncodedValue)
      end)

      task.wait(0)
  end
  InitDone = true
  return InitDone
end

return Configs
