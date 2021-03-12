local neorocks = require("plenary.neorocks")

if(neorocks._is_setup)
then
  neorocks.ensure_installed('rapidjson', 'rapidjson')
else
  neorocks.setup {}
end

