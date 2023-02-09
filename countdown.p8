pico-8 cartridge // http://www.pico-8.com
version 38
__lua__

countdown_number = 
{
    number_idx = {19,18,17,13}
}
countdown_idx = 0
nexttime = 0.0
deltatime = 0

function countdown_func()
    if time() >= nexttime and countdown_idx < 4 then
        
        if countdown_idx < 3 then
            sfx(0)
        end
        
        countdown_idx+=1
        nexttime = time() + 1.0 / 1.0
    end

    if countdown_idx >= 4 then
        sfx(1)
        deltatime+=1/stat(8)*8

        if deltatime > 20 then 
            game_state = "ingame"
        end
    end
end

function countdown_draw()
    spr(countdown_number.number_idx[countdown_idx],58,50)

    if countdown_idx == 4 then
        print("ready to wave !",35,65,rnd(8))
    end
end