require 'torch'
require 'optim'
local json = require 'cjson'

local TrainPlotter = torch.class('TrainPlotter')

function TrainPlotter:__init(path)
  self.path = path
  self.figures = {}
end

function TrainPlotter:add(fig_id, plot_id, iter, data)
  if not fig_id then
    fig_id = plot_id
  end

  if not self.figures[fig_id] then
    -- create figure
    self.figures[fig_id] = {}
    self.figures[fig_id]['data'] = {}
    self.figures[fig_id]['layout'] = {['title']=fig_id}
  end

  local fig_data = self.figures[fig_id]['data']
  local plot
  for k, v in pairs(fig_data) do
    if v['name'] == plot_id then plot = v end
  end
  if not plot then
    plot = {['name'] = plot_id, ['x'] = {}, ['y'] = {}}
    table.insert(fig_data, plot)
  end
  table.insert(plot['x'], iter)
  table.insert(plot['y'], data)

  local file = io.open(self.path, 'w')
  file:write(json.encode(self.figures))
  file:close()
end

--return TrainPlotter
