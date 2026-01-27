-- lua/utils.lua
local M = {}

--- Applies a function to each element in a collection
--- @param collection table The collection to iterate over
--- @param func function The function to apply to each element
--- @return nil
function M.for_each(collection, func)
  if not collection then
    return
  end
  
  for _, item in ipairs(collection) do
    func(item)
  end
end

--- Map each element in a collection using a function
--- @param collection table The collection to map
--- @param func function The map function
--- @return table A new table with mapped elements
function M.map(collection, func)
  local result = {}
  if not collection then
    return result
  end
  
  for _, item in ipairs(collection) do
    table.insert(result, func(item))
  end
  return result
end

--- Filters a collection based on a predicate
--- @param collection table The collection to filter
--- @param predicate function The predicate function (returns boolean)
--- @return table A new table with filtered elements
function M.filter(collection, predicate)
  local result = {}
  if not collection then
    return result
  end
  
  for _, item in ipairs(collection) do
    if predicate(item) then
      table.insert(result, item)
    end
  end
  return result
end

--- Checks if any element satisfies a predicate
--- @param collection table The collection to check
--- @param predicate function The predicate function
--- @return boolean
function M.any_of(collection, predicate)
  if not collection then
    return false
  end
  
  for _, item in ipairs(collection) do
    if predicate(item) then
      return true
    end
  end
  return false
end

--- Checks if all elements satisfy a predicate
--- @param collection table The collection to check
--- @param predicate function The predicate function
--- @return boolean
function M.all_of(collection, predicate)
  if not collection then
    return true
  end
  
  for _, item in ipairs(collection) do
    if not predicate(item) then
      return false
    end
  end
  return true
end

--- Finds the first element that satisfies a predicate
--- @param collection table The collection to search
--- @param predicate function The predicate function
--- @return any|nil The first matching element or nil
function M.find_if(collection, predicate)
  if not collection then
    return nil
  end
  
  for _, item in ipairs(collection) do
    if predicate(item) then
      return item
    end
  end
  return nil
end

--- Accumulates values in a collection using a binary operation
--- @param collection table The collection to accumulate
--- @param init any Initial value
--- @param func function Binary operation function(accumulator, current)
--- @return any The accumulated result
function M.accumulate(collection, init, func)
  local result = init
  if not collection then
    return result
  end
  
  for _, item in ipairs(collection) do
    result = func(result, item)
  end
  return result
end

return M

