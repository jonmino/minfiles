local mytable = {} -- my "table" stdlib

--- Append all the given tables into the target one.
---@param target table
---@param ... table
function mytable.append_all(target, ...)
    for _, tbl in ipairs({ ... }) do
        for k, v in pairs(tbl) do
            target[k] = v
        end
    end
end

return {
    mytable = mytable,
}
