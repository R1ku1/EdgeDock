-- Generic 0-100 tween. Each icon gets its own instance of this
-- (Rainmeter gives every Script measure its own isolated Lua state,
-- even when they share the same file), so all icons animate independently.

current = 0
target = 0

function Update()
    local speed = 0.58  -- recalculated for 30fps tick rate to match original 60fps feel; still snappier than the dock fade
    current = current + (target - current) * speed
    if math.abs(target - current) < 1 then
        current = target
    end
    return current
end

function Show()
    target = 100
end

function Hide()
    target = 0
end