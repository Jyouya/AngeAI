return function(...)
  for i, v in ipairs {...} do dofile('./AI/USER_AI/Components/' .. v .. '.lua') end
end
