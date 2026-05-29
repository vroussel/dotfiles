local M = {}

local _deps = {}

local _loaded = {}

function M.use(deps)
    for _, d in ipairs(deps) do
        if not _loaded[d] then
            assert(_deps[d], "Unknown dep: " .. d)
            _deps[d]()
            _loaded[d] = true
        end
    end
end

function M.register(name, setup_fn)
    assert(_deps[name] == nil, "Dep already registered: " .. name)
    _deps[name] = setup_fn
end

return M
