pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
-- zumber
-- player script

local playercontroller = {}
local player_house = {}

nextmovetime = 0

playercontroller.new = function()

    local self =
    {
        current_number_1 = flr(rnd(10)) + 1,
        current_number_2 = flr(rnd(10)) + 1,

        number_spr_1 = {12,1,2,3,4,5,6,7,8,9},
        number_spr_2 = {12,1,2,3,4,5,6,7,8,9},

        x_1 = 55,
        x_2 = 65,

        current_number_position = 0,

        y = 110,
        is_second = true
    }   

    self.start = function ()
        if self.is_second then
            current_number_position = self.x_1
        else
            current_number_position = self.x_2
        end 
    end

    self.update = function ()
        if btn(⬆️) and time() > nextmovetime then

            if self.is_second then
                if self.current_number_1 < 10 then
                    self.current_number_1+=1
                elseif self.current_number_1 > 9 then
                    self.current_number_1 = 1
                end
            else
                if self.current_number_2 < 10 then
                    self.current_number_2+=1
                elseif self.current_number_2 > 9 then
                    self.current_number_2 = 1
                end
            end

            nextmovetime = time() + 1.0 / 8
        
        elseif btn(⬇️) and time() > nextmovetime then
            if self.is_second then
                if self.current_number_1 > 1 then
                    self.current_number_1-=1
                else
                    self.current_number_1 = 10
                end
            else
                if self.current_number_2 > 1 then
                    self.current_number_2-=1
                else
                    self.current_number_2 = 10
                end
            end

            nextmovetime = time() + 1.0 / 8
        end

        if btnp(➡️) and self.is_second then
            self.is_second = false
        elseif btnp(⬅️) and not self.is_second then
            self.is_second = true
        end
    end 

    self.draw = function()
        print("player",52,102,7)
        spr(16,self.x_1-10,self.y)

        spr(self.number_spr_1[self.current_number_1],self.x_1,self.y)
        spr(self.number_spr_2[self.current_number_2],self.x_2,self.y)

        spr(28,current_number_position,self.y + 10)
        
        if self.is_second then
            current_number_position = self.x_1
        else
            current_number_position = self.x_2
        end 

        spr(32,self.x_2+10,self.y)
    end

    return self
end 

player_house.new = function ()
    
    local self = 
    {
        current_number_1 = flr(rnd(10)) + 1,
        current_number_2 = flr(rnd(10)) + 1,

        number_spr_1 = {13,17,18,19,20,21,22,23,24,25},
        number_spr_2 = {13,17,18,19,20,21,22,23,24,25},

        x_1 = 55,
        x_2 = 65,

        y = 8,

        hp = 10,
        isdead = false,
        wave = 0
    }

    self.update = function ()
        if self.wave > 6 then
            game_state = "game_ended"
        end

        if self.isdead then
            game_state = "game_over"
        end
    end

    self.draw = function ()
        print("house",54,18,10)
        spr(58,self.x_1-10,self.y)

        spr(self.number_spr_1[self.current_number_1],self.x_1,self.y)
        spr(self.number_spr_2[self.current_number_2],self.x_2,self.y)

        spr(59,self.x_2+10,self.y)

        print("wave:"..self.wave.."/"..6,10,10,15)
        print("hp:"..self.hp.."/"..10,90,10,15)
    end

    self.takedamage = function ()
        sfx(2)
        set_offset(0.25)
        current_screen = 8
        self.hp -= 1

        if self.hp <= 0 and not self.isdead then
            self.hp = 0
            self.isdead = true
        end
    end

    self.change_number = function ()
        if self.hp > 0 and not self.isdead then
            self.current_number_1 = flr(rnd(10)) + 1
            self.current_number_2 = flr(rnd(10)) + 1
        end
    end

    self.get_num_1 = function ()
        return self.current_number_1
    end

    self.get_num_2 = function ()
        return self.current_number_2
    end

    return self
end