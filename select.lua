
local header = {
	type = 5,
	name = "Private select skin sorry",
	w = 2560,
	h = 1440,
	input = 500,
	fadeout = 200,
	property = {
        {name = "gowno", def = "ON", item = {
			{name = "ON", op = 910},
			{name = "OFF", op = 911},
		}},
    },
	filepath = {
        {name = "Background", path = "BG/*.jpg", def = "default.jpg"},
    },
	offset = {}
}
local main_state = require("main_state")

local function main()
	-- ヘッダ情報のコピー
	local skin = {}
	for k, v in pairs(header) do
		skin[k] = v
    end

    skin.source = {
        {id = "test", path = "img/test.png"},
        {id = "src-lampbar", path = "img/lamp.png"},
        {id = "src-barcolors", path = "img/barcolors.png"},
        {id = "src-bg", path = "BG/*.jpg"}
    }

    skin.font = {
        {id = 0, path = "Fonts/barfont.fnt"},
        {id = 1, path = "Fonts/mgenplus-1c-black.ttf"},
        {id = 2, path = "Fonts/mgenplus-1c-medium.ttf"}
    }

    skin.text = {
        {id = "bartext", font = 0, size = 36, overflow = 1, align = 1},
        {id = "directory", font = 1, size = 150, align = 1, overflow = 1, value = function()
            folder = main_state.text(1000):match("> (.*)> "):match'^(.*%S)%s*$'
            
            if folder == nil then
                folder = ""
            end
            return folder
            end
        },
        {id = "root_directory", font = 2, size = 36, value = function() return main_state.text(1000):match("^[^>]*") end},
        {id = "root_text", font = 2, size = 36, constantText = "FOLDER:", align = 2},
        {id = "artist_text", font = 2, size = 36, constantText = "ARTIST:", align = 2},
        {id = "artist", font = 2, size = 36, ref = 16, overflow = 1},
        {id = "genre_text", font = 2, size = 36, constantText = "GENRE:", align = 2},
        {id = "genre", font = 2, size = 36, ref = 13, overflow = 1},
        {id = "bpm_text", font = 2, size = 36, constantText = "BPM:", align = 2},
        {id = "bpm", font = 2, size = 36, value = function()
            bpm = main_state.number(92)
            if bpm < 0 then bpm = "" end
            if main_state.number(90) ~= main_state.number(91) then
                bpm = main_state.number(91) .. " - " .. main_state.number(90)
            end
            return bpm
            end
        },
    }

    skin.image = {
        {id = "bg", src = "src-bg", w = -1, h = -1},
        {id = "dupa", src = "test", x = 0, y = 0, w = 600, h = 335},
        {id = "bar-folder", src = "src-barcolors", x = 1, w = 1, h = 1},
        {id = "bar-song",   src = "src-barcolors", w = 1, h = 1},
        {id = "bar-nosong", src = "src-barcolors", x = 2, w = 1, h = 1},
        
        {id = "lamp-noplay", src = "src-lampbar", x = 0, y = 920, w = 118, h = 1, divx = 2},
        {id = "lamp-failed", src = "src-lampbar", x = 0, y = 46, w = 118, h = 1, divx = 2, cycle = 33},
        {id = "lamp-assist", src = "src-lampbar", x = 0, y = 92 + 46, w = 118, h = 1, divx = 2},
        {id = "lamp-lassist", src = "src-lampbar", x = 0, y = 184 + 46, w = 118, h = 1, divx = 2},
        {id = "lamp-easy", src = "src-lampbar", x = 0, y = 276 + 46, w = 118, h = 1, divx = 2},
        {id = "lamp-normal", src = "src-lampbar", x = 0, y = 368 + 46, w = 118, h = 1, divx = 2},
        {id = "lamp-hard", src = "src-lampbar", x = 0, y = 460 + 46, w = 118, h = 1, divx = 2},
        {id = "lamp-exhard", src = "src-lampbar", x = 0, y = 552 + 46, w = 118, h = 1, divx = 2, cycle = 133},
        {id = "lamp-fc", src = "src-lampbar", x = 0, y = 644 + 46, w = 118, h = 1, divx = 2, cycle = 133},
        {id = "lamp-perfect", src = "src-lampbar", x = 0, y = 736 + 46, w = 118, h = 1, divx = 2, cycle = 133},
        {id = "lamp-max", src = "src-lampbar", x = 0, y = 828 + 46, w = 118, h = 1, divx = 2, cycle = 133},

    }



    skin.imageset = {
        {id = "bars", images = {
            "bar-song", "bar-folder", "bar-folder", "bar-folder", "bar-folder", "bar-folder", "bar-folder", "bar-nosong"
        }},
    }

    --songwheel start

    local t_listoff = {}
	local t_liston = {}
	local t_lamp = {}
	local t_playerlamp = {}
	local t_rivallamp = {}
	
	do		
		local bar_num		= 14
		
		local list_x_off	= 855
		local list_x_on		= list_x_off
		local list_w		= 850
		local list_h		= 1050 / bar_num
		
		local lamp_w		= 20
		local lamp_h		= list_h - 8
		local lamp_x		= 0
		local lamp_y		= 4
		
		local bar_roop		 = 30
		
		do
			local list_y = 1086
			for i = 1, bar_num + 4, 1 do
				table.insert(t_listoff, {id = "bars", loop = (bar_roop * i), dst = {{time = 0, x = list_x_off, y = list_y - 2000, w = list_w, h = list_h, acc = 2},{time = (bar_roop * i), y = list_y, a = 63}}})
				table.insert(t_liston,  {id = "bars", dst = {{x = list_x_on, y = list_y, w = list_w, h = list_h}}})
				list_y = list_y - list_h
			end
			
			local lamp_category = {
                "lamp-noplay", "lamp-failed", "lamp-assist", "lamp-lassist", "lamp-easy", "lamp-normal", "lamp-hard", "lamp-exhard", "lamp-fc", "lamp-perfect", "lamp-max"
			}
			for i, v in ipairs(lamp_category) do
				table.insert(t_lamp,		{id = v, blend = 2, dst = {{x = lamp_x, y = lamp_y, w = lamp_w, h = lamp_h}}})
				table.insert(t_playerlamp,	{id = v .. "_p", dst = {{x = lamp_x, y = lamp_y, w = lamp_w, h = lamp_h}}})
				table.insert(t_rivallamp,	{id = v .. "_r", dst = {{x = lamp_x, y = lamp_y, w = lamp_w, h = lamp_h}}})
			end
		end
	end

	skin.songlist = {
		id = "songlist",
		center = 7,
		clickable = {3,4,5,6,7,8,9,10,11,12,13},
		listoff = t_listoff,
		liston  = t_liston,
		text = {
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36}}},						-- 通常
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36, b = 153}}},				-- 新規
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36}}},						-- SongBar通常
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36, b = 153}}},				-- SongBar新規
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36, b = 245}}},				-- FolderBar通常
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36, b = 153}}},				-- FolderBar新規
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36, r = 245, g = 245}}},	-- TableBar or HashBar
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36, r = 245, b = 245}}},	-- GradeBar
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36, g = 153, b = 153}}},	-- SongBar or GradeBar（曲未所持）
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36, g = 245}}},				-- CommandBar or ContainerBar
			{id = "bartext", offset = ID_LIST_TITLE, filter = 1, dst = {{x = 425, y = 16, w = 800, h = 36, r = 245}}},				-- SearchWordBar
		},
		level = {
			{id = "default_songlist2_playlevel_bar", dst = {{x = 28, y = 8, w = 32, h = 38}}},								-- 難易度未定義
			{id = "default_songlist2_playlevel_bar", dst = {{x = 28, y = 8, w = 32, h = 38, r = 51, b = 102}}},				-- BEGINNER
			{id = "default_songlist2_playlevel_bar", dst = {{x = 28, y = 8, w = 32, h = 38, r = 0, g = 153}}},				-- NORMAL
			{id = "default_songlist2_playlevel_bar", dst = {{x = 28, y = 8, w = 32, h = 38, g = 102, b = 51}}},				-- HYPER
			{id = "default_songlist2_playlevel_bar", dst = {{x = 28, y = 8, w = 32, h = 38, r = 204, g = 51, b = 0}}},		-- ANOTHER
			{id = "default_songlist2_playlevel_bar", dst = {{x = 28, y = 8, w = 32, h = 38, r = 204, g = 51, b = 204}}},		-- INSANE
			{id = "default_songlist2_playlevel_bar", dst = {{x = 28, y = 8, w = 32, h = 38, r = 128, g = 128, b = 128}}},	-- IR RANKING
		},
		lamp = t_lamp,
		trophy = {
			{id = "default_songlist2_trophy_bronze", blend = 2,	dst = {{x = 32, y = 5, w = 60, h = 44}}},
			{id = "default_songlist2_trophy_silver", blend = 2,	dst = {{x = 32, y = 5, w = 60, h = 44}}},
			{id = "default_songlist2_trophy_gold", blend = 2,	dst = {{x = 32, y = 5, w = 60, h = 44}}},
		},
		label = {
			{id = "default_songlist2_label_ln",		dst = {{x = -42, y = 12, w = 40, h = 30}}},
			{id = "default_songlist2_label_random",	dst = {{x = -84, y = 12, w = 40, h = 30}}},
			{id = "default_songlist2_label_mine",	dst = {{x = 670, y = 12, w = 30, h = 30}}},
			{id = "default_songlist2_label_cn",		dst = {{x = -42, y = 12, w = 40, h = 30}}},
			{id = "default_songlist2_label_hcn",	dst = {{x = -42, y = 12, w = 40, h = 30}}},
		},
		graph = {id = "graph-lamp", dst = {{x = 50, y = 2, w = 600, h = 6}}}
	}

    skin.destination = {
        {id = "bg", dst = {{w = 2560, h = 1440}}},
        {id = -110, dst = {{x = 855, w = 850, h = 1440, a = 191}}},
  --[[       {id = "dupa", dst = {
            {x = 0, y = 0, w = 600, h = 335}
        }}, ]]
        {id = "songlist"},
        --top bar 
        {id = -100, filter = 2, dst = {
            {time = 0, x = 855, y = 1011, w = 850, h = 637, a = 255, acc = 1},
            {time = 2499, y = 1112},
            {time = 2500, a = 0},
            {time = 4999, y = 1213},
            {time = 5000, a = 255},
            {time = 7499, y = 1112},
            {time = 7500, a = 0},
            {time = 10000, y = 1011}
        }},
        {id = -100, filter = 2, dst = {
            {time = 0, x = 855, y = 1011, w = 850, h = 637, a = 0, acc = 2},
            {time = 2499, y = 1112},
            {time = 2500, a = 255},
            {time = 4999, y = 1213},
            {time = 5000, a = 0},
            {time = 7499, y = 1112},
            {time = 7500, a = 255},
            {time = 10000, y = 1011}
        }},
        {id = -111, dst = {{x = 855, y = 1011, w = 850, h = 202, r = 31, b = 31, g = 31}}},
        {id = -102, filter = 2, dst = {{x = 855, y = 1213, w = 850, h = 227, a = 255}}},
        {id = -110, dst = {{x = 855, y = 1213, w = 850, h = 227, a = 127}}},
        {id = "directory", dst = {{x = 1283, y = 1225, w = 850, h = 150, r = 0, g = 0, b = 0, a = 127}}},
        {id = "directory", dst = {{x = 1280, y = 1228, w = 850, h = 150}}},

        -- song metadata
        {id = "root_directory", dst = {{w = 680, h = 36, x = 1020, y = 1165}}},
        {id = "root_text", dst = {{w = 850, h = 36, x = 1015, y = 1165, r = 127, g = 127, b = 127}}},

        {id = "genre", dst = {{w = 680, h = 36, x = 1020, y = 1115}}},
        {id = "genre_text", dst = {{w = 850, h = 36, x = 1015, y = 1115, r = 127, g = 127, b = 127}}},

        {id = "artist", dst = {{w = 680, h = 36, x = 1020, y = 1065}}},
        {id = "artist_text", dst = {{w = 850, h = 36, x = 1015, y = 1065, r = 127, g = 127, b = 127}}},

        {id = "bpm", dst = {{w = 680, h = 36, x = 1020, y = 1015}}},
        {id = "bpm_text", dst = {{w = 850, h = 36, x = 1015, y = 1015, r = 127, g = 127, b = 127}}},
    }

  
    return skin
end

return {
    header = header,
    main = main
}