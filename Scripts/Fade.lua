current = 0
target = 0

function Update()
    local speed = 0.36  -- recalculated for the 30fps tick rate to match the original 60fps feel
    current = current + (target - current) * speed
    if math.abs(target - current) < 1 then
        current = target
    end
    return current
end

function Show()
    target = 255
end

function Hide()
    target = 0
end