pico-8 cartridge // http://www.pico-8.com
version 38
__lua__

intro_dt=0

intro_logo = 
{
    ispr = 10,
    x = -10,
    y = 40,
    nextscene = 5
}

intro_text = 
{
    itext = "skagogames",
    x = 150,
    y = 60
}

function update_intro()
    intro_dt=1/stat(8)

    intro_logo.x += intro_dt * 60

    if intro_logo.x >= 55 then
        intro_logo.x = 55 

        intro_text.x -= intro_dt * 60

        if intro_text.x <= 43 then
            intro_logo.nextscene-=intro_dt *  3
            intro_text.x = 43
        end
    end

end

function draw_intro()
    spr(intro_logo.ispr, intro_logo.x, intro_logo.y, 2,2)
    print(intro_text.itext, intro_text.x, intro_text.y, 7)

    if intro_text.x <= 43 then
        print("made in skago.", 35, 110, 7)
    end
end

function iswaitended()
    if intro_logo.nextscene <= 0 then

        return true
    end

    return false
end