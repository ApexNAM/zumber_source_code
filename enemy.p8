pico-8 cartridge // http://www.pico-8.com
version 38
__lua__

enemyclone = {}
enemy_position = { {15,25}, {55,65},{95,105} }

function init_enemy(min,max,shp)

    for i=1,3 do
        local x_1 = 0
        local x_2 = 0

        for j in all(enemy_position) do
            x_1 = enemy_position[i][1]
            x_2 = enemy_position[i][2]
        end

        spawn_enemy(x_1, x_2,40,rnd(max) + min,shp)
    end
end

function spawn_enemy(x1, x2, sy, spd, shp)
    add(enemyclone, 
    {
        number_spr_1 = {14,33,34,35,36,37,38,39,40,41},
        number_spr_2 = {14,33,34,35,36,37,38,39,40,41},

        number_index_1 = flr(rnd(10)) + 1,
        number_index_2 = flr(rnd(10)) + 1,

        x_1 = x1,
        x_2 = x2,

        y = sy,

        speed = spd,
        hp = shp,
        isdead = false,

        distance_current = 10,
        distance_set = 10,

        nextmovetime = 0.0,
        attack_effect_power = -1.0,
        set_hp = shp,
    })
end

function enemy_update_current(e, getter_x_1, getter_x_2, player_home)

    if time() >= e.nextmovetime then

        e.distance_current-=1
        e.nextmovetime = time() + 1.0 / e.speed
    end 

    if e.distance_current < 0 then

        comming_home(e,getter_x_1, getter_x_2, player_home)
        e.distance_current = e.distance_set

        player_home.takedamage()
    end

    if e.hp <= 0 then
        sfx(4)
        del(enemyclone,e)
    end
end

function enemy_draw_current(e)
    spr(60,e.x_1-10,e.y)
    spr(e.number_spr_1[e.number_index_1],e.x_1,e.y)
    spr(e.number_spr_1[e.number_index_2],e.x_2,e.y)
    
    print(e.hp.."/"..e.set_hp,e.x_1+4,e.y - 10,7)
    spr(61,e.x_2+10,e.y)
    print("time:"..e.distance_current,e.x_1-2,e.y + 10,8)

    circ(e.x_1 + 8, e.y + 4,e.attack_effect_power,10)

    if e.attack_effect_power > -1 then
        e.attack_effect_power -= 1/stat(8)*32
    end
end

function comming_home(e,getter_x_1,getter_x_2, player_home)
    if getter_x_1 < e.number_index_1 then
        e.number_index_1-=1
    elseif getter_x_1 > e.number_index_1 then
        e.number_index_1+=1
    end

    if getter_x_2 < e.number_index_2 then
        e.number_index_2-=1
    elseif getter_x_2 > e.number_index_2 then
        e.number_index_2+=1
    end

    if getter_x_1 == e.number_index_1 and
       getter_x_2 == e.number_index_2 then
        player_home.change_number()
    end
end

function enemy_attack_all(px1,px2)
    if btnp(❎) then  
        for e in all(enemyclone) do    
            if px1 == e.number_index_1 and 
               px2 == e.number_index_2 then
                sfx(3)
                current_screen = 12
                set_offset(0.25)
                e.attack_effect_power = 10
                e.hp -= 1
            end
        end
    end 
end

function enemy_update_all(getter_x_1, getter_x_2, player_home)
    for e in all(enemyclone) do 
        enemy_update_current(e,getter_x_1, getter_x_2, player_home)
    end 
end

function enemy_draw_all()
    foreach(enemyclone,enemy_draw_current)
end
