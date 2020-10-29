-- Encodes a lua table as a string
local function stringify(table)
  if not table then
    TraceAI('table is nil')
    return ''
  end
  local res = '{'
  for k, v in pairs(table) do
    local key, value
    if type(k) == 'string' then
      key = k
    elseif type(k) == 'number' then
      key = '[' .. tostring(k) .. ']'
    else
      error('LTN Stringify: Unsupported key type')
    end
    if type(v) == 'string' then
      value = '"' .. v .. '"'
    elseif type(v) == 'number' then
      value = tostring(v)
    elseif type(v) == 'table' then
      value = stringify(v)
    else
      error('LTN Stringify: Unsupported value type')
    end
    res = res .. ('%s=%s,'):format(key, value)
    TraceAI(res)
  end
  return res .. '}'
end

local function writeToFile(table, filepath)
  local file = io.open(filepath, 'w')
  file:write('return ' .. stringify(table))
  file:close()
end

return {stringify = stringify, writeToFile = writeToFile}
