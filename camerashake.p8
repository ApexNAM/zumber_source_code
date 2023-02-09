pico-8 cartridge // http://www.pico-8.com
version 38
__lua__

offset = 0.0

function set_offset(val)
    offset = val
end

function shakescreen()

    local fade = 0.95
    
    local offset_x = 16 - rnd(32)
    local offset_y = 16 - rnd(32)

    offset_x *= offset
    offset_y *= offset

    camera(offset_x, offset_y)

    offset *= fade

    if offset < 0.05 then
        offset = 0
    end
end