
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
        {name = "Background", path = "BG/*", def = "default.jpg"},
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

    local function clampNumba(num, leadingZero)
		numba = 0
		if main_state.number(num) < 0 then
			numba = 0
		else numba = main_state.number(num)
        end
        if numba < 10 and leadingZero then
            numba = "0" .. "‎" .. numba
		end
		return numba
	end

    skin.source = {
        {id = "test", path = "img/test.png"},
        {id = "src-lampbar", path = "img/lamp.png"},
        {id = "src-barcolors", path = "img/barcolors.png"},
        {id = "src-bg", path = "BG/*"},
        {id = "src-lamps", path = "img/lamps.png"},
        {id = "src-lampgraph", path = "img/lampgraph.png"},
        {id = "src-lane-option", path = "img/option/lane.png"},
        {id = "src-gauge-option", path = "img/option/gauge.png"},
        {id = "src-hsfix-option", path = "img/option/hsfix.png"},
        {id = "src-generic-option", path = "img/option/generic.png"},
        {id = "src-bga-option", path = "img/option/bga.png"},
        {id = "src-gas-option", path = "img/option/gas.png"},
        {id = "src-assist-option", path = "img/option/assist.png"},
    }

    skin.font = {
        {id = 0, path = "Fonts/NotoSerif.fnt"},
        {id = 1, path = "Fonts/mgenplus-1c-black.ttf"},
        {id = 2, path = "Fonts/mgenplus-1c-medium.ttf"}
    }

    skin.text = {
        {id = "bartext", font = 0, size = 36, overflow = 1, align = 1},
        {id = "directory", font = 1, size = 150, align = 1, overflow = 1, value = function()
            -- had no real way of cleaning this up so I made beatoraja shut the fuck up instead
            if pcall(function() return main_state.text(1000):match("> (.*)> "):match'^(.*%S)%s*$' end) then
                folder = main_state.text(1000):match("> (.*)> "):match'^(.*%S)%s*$'
            else folder = ""
            end
            
            
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
        {id = "search", font = 1, size = 36, ref = 30},
        {id = "play_text", font = 2, size = 24, constantText = "PLAY", align = 2},
        {id = "prac_text", font = 2, size = 24, constantText = "PRACTICE", align = 2},
        {id = "auto_text", font = 2, size = 24, constantText = "AUTOPLAY", align = 2},

        -- {id = "score_ex_text", font = 2, size = 24, constantText = "EX"},
        {id = "score_rate", font = 2, size = 24, value = function() return clampNumba(102) .. "." .. clampNumba(103, true) .. "%" end, align = 1},
        {id = "score_bp_text", font = 2, size = 24, constantText = "BP"},
        {id = "score_bp", font = 2, size = 24, value = function() return main_state.number(76) end, align = 2},
        {id = "score_cb_text", font = 2, size = 24, constantText = "CB"},
        {id = "score_cb", font = 2, size = 24, value = function() return main_state.number(425) end, align = 2},
        {id = "score_gr", font = 2, size = 24, value = function()
        	local rank = {
                [0] = "AAA",
                [1] = "AA",
                [2] = "A",
                [3] = "B",
                [4] = "C",
                [5] = "D",
                [6] = "E",
                [7] = "F"
            }
            gradeop = 0
            if main_state.option(2) or main_state.option(3) then
            repeat
                gradeop = gradeop + 1
            until main_state.option(200+gradeop) or gradeop == 7
            end
            if gradeop == 7 and main_state.option(200) then 
                gradeop = 0
            end
            return rank[gradeop]
        end, align = 1},
        {id = "button-play-num", font = 2, size = 12, constantText = "[1]"},
        {id = "button-prac-num", font = 2, size = 12, constantText = "[3]"},
        {id = "button-auto-num", font = 2, size = 12, constantText = "[5]"},
        {id = "button-repl-num", font = 2, size = 12, constantText = "[7]"},

        {id = "option-play-big", font = 1, size = 36, constantText = "PLAY OPTIONS [start]", align = 2},
        {id = "option-play-lane", font = 2, size = 36, constantText = "lane option  ", align = 2},
        {id = "option-play-gauge", font = 2, size = 36, constantText = "gauge type  ", align = 2},
        {id = "option-play-hsfix", font = 2, size = 36, constantText = "hi-speed fix  ", align = 2},
        {id = "option-play-lanecover", font = 2, size = 36, constantText = "lane cover  ", align = 2},
        {id = "option-play-lift", font = 2, size = 36, constantText = "lift  ", align = 2},
        {id = "option-play-target", font = 2, size = 36, constantText = "target score  ", align = 2},
        {id = "option-target", font = 2, size = 36, ref = 3, align = 2},

        {id = "option-adv-big", font = 1, size = 36, constantText = "ADVANCED OPTIONS [start+select]", align = 2},
        {id = "option-adv-bga", font = 2, size = 36, constantText = "bga  ", align = 2},
        {id = "option-adv-gas", font = 2, size = 36, constantText = "gauge auto-shift  ", align = 2},
        {id = "option-adv-autoadj", font = 2, size = 36, constantText = "offset auto-adjust  ", align = 2},
        {id = "option-adv-scroll", font = 2, size = 36, constantText = "scroll speed  ", align = 2},
        {id = "option-adv-offset", font = 2, size = 36, constantText = "visual offset  ", align = 2},
        {id = "option-scroll", font = 2, size = 36, value = function() return main_state.number(313) .. " GN" end, align = 2},
        {id = "option-offset", font = 2, size = 36, value = function() 
        offs = main_state.number(12)
        if offs > 0 then
            offs = "+‎" .. offs
        end
        return offs
        end, align = 2},

        {id = "option-assist-big", font = 1, size = 36, constantText = "ASSIST OPTIONS [select]", align = 2},
        
    }

    skin.image = {
        {id = "bg", src = "src-bg", w = -1, h = -1},
        {id = "dupa", src = "test", x = 0, y = 0, w = 600, h = 335},
        {id = "bar-folder", src = "src-barcolors", x = 1, w = 1, h = 1},
        {id = "bar-song",   src = "src-barcolors", w = 1, h = 1},
        {id = "bar-nosong", src = "src-barcolors", x = 2, w = 1, h = 1},
        
        {id = "lamp-noplay", src = "src-lamps", y = 10, w = 2, h = 1, divx = 2},
        {id = "lamp-failed", src = "src-lamps", w = 2, h = 1, divx = 2, cycle = 33},
        {id = "lamp-assist", src = "src-lamps", y = 1, w = 2, h = 1, divx = 2},
        {id = "lamp-lassist", src = "src-lamps", y = 2, w = 2, h = 1, divx = 2},
        {id = "lamp-easy", src = "src-lamps", y = 3, w = 2, h = 1, divx = 2},
        {id = "lamp-normal", src = "src-lamps", y = 4, w = 2, h = 1, divx = 2},
        {id = "lamp-hard", src = "src-lamps", y = 5, w = 2, h = 1, divx = 2},
        {id = "lamp-exhard", src = "src-lamps", y = 6, w = 80, h = 1, divx = 80, cycle = 1333},
        {id = "lamp-fc", src = "src-lamps", y = 7, w = 80, h = 1, divx = 80, cycle = 1333},
        {id = "lamp-perfect", src = "src-lamps", y = 8, w = 80, h = 1, divx = 80, cycle = 1333},
        {id = "lamp-max", src = "src-lamps", y = 9, w = 80, h = 1, divx = 80, cycle = 1333},

        {id = "button-play",    src = "src-barcolors", x = 3, w = 1, h = 1, act = 15},
        {id = "button-prac",    src = "src-barcolors", x = 3, w = 1, h = 1, act = 315},
        {id = "button-auto",    src = "src-barcolors", x = 3, w = 1, h = 1, act = 16},

        {id = "button-repl-1",  src = "src-barcolors", x = 3, w = 1, h = 1, act = 19},
        {id = "button-repl-2",  src = "src-barcolors", x = 3, w = 1, h = 1, act = 316},
        {id = "button-repl-3",  src = "src-barcolors", x = 3, w = 1, h = 1, act = 317},
        {id = "button-repl-4",  src = "src-barcolors", x = 3, w = 1, h = 1, act = 318},

        {id = "option-lane-1", src = "src-lane-option", w = 300, h = 36},
        {id = "option-lane-2", src = "src-lane-option", y = 36, w = 300, h = 36},
        {id = "option-lane-3", src = "src-lane-option", y = 36 * 2, w = 300, h = 36},
        {id = "option-lane-4", src = "src-lane-option", y = 36 * 3, w = 300, h = 36},
        {id = "option-lane-5", src = "src-lane-option", y = 36 * 4, w = 300, h = 36},
        {id = "option-lane-6", src = "src-lane-option", y = 36 * 5, w = 300, h = 36},
        {id = "option-lane-7", src = "src-lane-option", y = 36 * 6, w = 300, h = 36},
        {id = "option-lane-8", src = "src-lane-option", y = 36 * 7, w = 300, h = 36},
        {id = "option-lane-9", src = "src-lane-option", y = 36 * 8, w = 300, h = 36},
        {id = "option-lane-10", src = "src-lane-option", y = 36 * 9, w = 300, h = 36},

        {id = "option-gauge-1", src = "src-gauge-option", w = 300, h = 36},
        {id = "option-gauge-2", src = "src-gauge-option", y = 36, w = 300, h = 36},
        {id = "option-gauge-3", src = "src-gauge-option", y = 36 * 2, w = 300, h = 36},
        {id = "option-gauge-4", src = "src-gauge-option", y = 36 * 3, w = 300, h = 36},
        {id = "option-gauge-5", src = "src-gauge-option", y = 36 * 4, w = 300, h = 36},
        {id = "option-gauge-6", src = "src-gauge-option", y = 36 * 5, w = 300, h = 36},

        {id = "option-hsfix-1", src = "src-hsfix-option", w = 300, h = 36},
        {id = "option-hsfix-2", src = "src-hsfix-option", y = 36, w = 300, h = 36},
        {id = "option-hsfix-3", src = "src-hsfix-option", y = 36 * 2, w = 300, h = 36},
        {id = "option-hsfix-4", src = "src-hsfix-option", y = 36 * 3, w = 300, h = 36},
        {id = "option-hsfix-5", src = "src-hsfix-option", y = 36 * 4, w = 300, h = 36},

        {id = "option-generic-1", src = "src-generic-option", w = 300, h = 36},
        {id = "option-generic-2", src = "src-generic-option", y = 36, w = 300, h = 36},

        {id = "option-bga-1", src = "src-bga-option", w = 300, h = 36},
        {id = "option-bga-2", src = "src-bga-option", y = 36, w = 300, h = 36},
        {id = "option-bga-3", src = "src-bga-option", y = 36 * 2, w = 300, h = 36},

        {id = "option-gas-1", src = "src-gas-option", w = 400, h = 36},
        {id = "option-gas-2", src = "src-gas-option", y = 36, w = 400, h = 36},
        {id = "option-gas-3", src = "src-gas-option", y = 36 * 2, w = 400, h = 36},
        {id = "option-gas-4", src = "src-gas-option", y = 36 * 3, w = 400, h = 36},
        {id = "option-gas-5", src = "src-gas-option", y = 36 * 4, w = 400, h = 36},

        {id = "option-assist-1", src = "src-assist-option", w = 300, h = 36},
        {id = "option-assist-2", src = "src-assist-option", y = 36, w = 300, h = 36},

    }



    skin.imageset = {
        {id = "bars", images = {
            "bar-song", "bar-folder", "bar-folder", "bar-folder", "bar-folder", "bar-folder", "bar-folder", "bar-nosong"
        }},
        {id = "option-lane", ref = 42, act = 42, images = {
            "option-lane-1", "option-lane-2", "option-lane-3", "option-lane-4", "option-lane-5", "option-lane-6", "option-lane-7", "option-lane-8", "option-lane-9", "option-lane-10"
        }},
        {id = "option-gauge", ref = 40, act = 40, images = {
            "option-gauge-1", "option-gauge-2", "option-gauge-3", "option-gauge-4", "option-gauge-5", "option-gauge-6"
        }},
        {id = "option-hsfix", ref = 55, act = 55, images = {
            "option-hsfix-1", "option-hsfix-2", "option-hsfix-3", "option-hsfix-4", "option-hsfix-5"
        }},
        {id = "option-lanecover", ref = 330, act = 330, images = {
            "option-generic-1", "option-generic-2"
        }},
        {id = "option-lift", ref = 331, act = 331, images = {
            "option-generic-1", "option-generic-2"
        }},
        {id = "option-autoadj", ref = 342, act = 342, images = {
            "option-generic-2", "option-generic-1"
        }},
        {id = "option-bga", ref = 72, act = 72, images = {
            "option-bga-3", "option-bga-2", "option-bga-1"
        }},
        {id = "option-gas", ref = 78, act = 78, images = {
            "option-gas-1", "option-gas-2", "option-gas-3", "option-gas-4", "option-gas-5"
        }},
        {id = "option-assist1", ref = 301, images = {
            "option-assist-1", "option-assist-2"
        }},
        {id = "option-assist2", ref = 302, images = {
            "option-assist-1", "option-assist-2"
        }},
        {id = "option-assist3", ref = 303, images = {
            "option-assist-1", "option-assist-2"
        }},
        {id = "option-assist4", ref = 304, images = {
            "option-assist-1", "option-assist-2"
        }},
        {id = "option-assist5", ref = 305, images = {
            "option-assist-1", "option-assist-2"
        }},
        {id = "option-assist6", ref = 306, images = {
            "option-assist-1", "option-assist-2"
        }},
        {id = "option-assist7", ref = 307, images = {
            "option-assist-1", "option-assist-2"
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
		
		local lamp_w		= list_w - 8
		local lamp_h		= list_h - 8
		local lamp_x		= 4
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
				table.insert(t_lamp,		{id = v, blend = 2, dst = {{x = lamp_x, y = lamp_y, w = lamp_w, h = lamp_h, a = 63}}})
				table.insert(t_playerlamp,	{id = v .. "_p", dst = {{x = lamp_x, y = lamp_y, w = lamp_w, h = lamp_h}}})
				table.insert(t_rivallamp,	{id = v .. "_r", dst = {{x = lamp_x, y = lamp_y, w = lamp_w, h = lamp_h}}})
			end
		end
	end

	skin.songlist = {
		id = "songlist",
		center = 7,
		clickable = {3,4,5,6,7,8,9,10,11,12},
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
		graph = {id = "graph-lamp", dst = {{w = 842, h = 67, x = 4, y = 4}}}
	}

    skin.graph = {
        {id = "scorebar", src = "src-barcolors", x = 5, w = 1, h = 1, type = 147, angle = 0},
        {id = "graph-lamp", src = "src-lampgraph", w = 11, h = 30, divx = 11, divy = 2, cycle = 100, type = -1},
    }

    local op_side_x = 2550
    
    local op_play_y = 1300

    skin.destination = {
        {id = "bg", dst = {{w = 2560, h = 1440}}},
        {id = -110, dst = {{x = 855, w = 850, h = 1440, a = 191}}},
  --[[       {id = "dupa", dst = {
            {x = 0, y = 0, w = 600, h = 335}
        }}, ]]
        {id = "songlist"},
        -- song score shit
        {id = -111, draw = function() return (main_state.option(3) or main_state.option(2)) and main_state.number(71) >= 0 end, dst = {
            {x = 855, y = 545, w = 850, h = 30, r = 28, g = 56, b = 77}
        }},
        {id = "scorebar", draw = function() return main_state.option(2) and main_state.number(71) >= 0 end, dst = {
            {x = 855, y = 550, w = 850, h = 20}
        }},
--[[         {id = "score_ex_text", draw = function() return (main_state.option(3) or main_state.option(2)) and main_state.number(71) >= 0 end, dst = {
            {x = 855 + 170, y = 545, w = 85, h = 24, r = 128, g = 128, b = 128}
        }}, ]]
        {id = "score_rate", draw = function() return (main_state.option(3) or main_state.option(2)) and main_state.number(71) >= 0 end, dst = {
            {x = 855 + 170, y = 545, w = 85, h = 24}
        }},
        {id = "score_bp_text", draw = function() return (main_state.option(3) or main_state.option(2)) and main_state.number(71) >= 0 end, dst = {
            {x = 855 + 170 * 2, y = 545, w = 85, h = 24, r = 128, g = 128, b = 128}
        }},
        {id = "score_bp", draw = function() return (main_state.option(3) or main_state.option(2)) and main_state.number(71) >= 0 end, dst = {
            {x = 855 + 170 * 2, y = 545, w = 85, h = 24}
        }},
        {id = "score_cb_text", draw = function() return (main_state.option(3) or main_state.option(2)) and main_state.number(71) >= 0 end, dst = {
            {x = 855 + 170 * 3, y = 545, w = 85, h = 24, r = 128, g = 128, b = 128}
        }},
        {id = "score_cb", draw = function() return (main_state.option(3) or main_state.option(2)) and main_state.number(71) >= 0 end, dst = {
            {x = 855 + 170 * 3, y = 545, w = 85, h = 24}
        }},
        {id = "score_gr", draw = function() return (main_state.option(3) or main_state.option(2)) and main_state.number(71) >= 0 end, dst = {
            {x = 855 + 170 * 4, y = 545, w = 85, h = 24}
        }},


        

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

        -- bottom bar
        {id = -111, dst = {
            {x = 855, y = -39, w = 850, h = 225, r = 31, g = 31, b = 31}
        }},
        {id = -110, dst = {
            {x = 865, y = 121, w = 830, h = 55}
        }},
        {id = "search", dst = {
            {x = 870, y = 133, w = 830, h = 36}
        }},
        {id = -111, dst = {
            {x = 865, y = 7 + 62, w = 420, h = 40, r = 15, g = 15, b = 15}
        }},
        {id = "button-play", draw = function() return main_state.option(2) or main_state.option(3) end, dst = {
            {x = 865, y = 7 + 62, w = 420, h = 40}
        }},
        {id = "button-play-num", draw = function() return main_state.option(2) or main_state.option(3) end, dst = {
            {x = 865, y = 69 + 25, w = 12, h = 12, r = 15, g = 15, b = 15}
        }},
        {id = "play_text", draw = function() return main_state.option(2) or main_state.option(3) end, dst = {
            {x = 865 + 419, y = 65, w = 420, h = 24}
        }},
        {id = -111, dst = {
            {x = 865, y = 13, w = 200, h = 40, r = 15, g = 15, b = 15}
        }},
        {id = "button-prac",draw = function() return main_state.option(2) or main_state.option(3) end, dst = {
            {x = 865, y = 13, w = 200, h = 40}
        }},
        {id = "button-prac-num", draw = function() return main_state.option(2) or main_state.option(3) end, dst = {
            {x = 865, y = 13 + 25, w = 12, h = 12, r = 15, g = 15, b = 15}
        }},
        {id = "prac_text", draw = function() return main_state.option(2) or main_state.option(3) end, dst = {
            {x = 865 + 199, y = 9, w = 200, h = 24}
        }},
        {id = -111, dst = {
            {x = 865 + 220, y = 13, w = 200, h = 40, r = 15, g = 15, b = 15}
        }},
        {id = "button-auto", draw = function() return main_state.option(2) or main_state.option(3) end, dst = {
            {x = 865 + 220, y = 13, w = 200, h = 40}
        }},
        {id = "button-auto-num", draw = function() return main_state.option(2) or main_state.option(3) end, dst = {
            {x = 865 + 220, y = 13 + 25, w = 12, h = 12, r = 15, g = 15, b = 15}
        }},
        {id = "auto_text", draw = function() return main_state.option(2) or main_state.option(3) end, dst = {
            {x = 865 + 220 + 199, y = 9, w = 200, h = 24}
        }},
        {id = -111, dst = {
            {x = 855 + 800, y = 69, w = 40, h = 40, r = 15, g = 15, b = 15}
        }},
        {id = -111, dst = {
            {x = 855 + 750, y = 69, w = 40, h = 40, r = 15, g = 15, b = 15}
        }},
        {id = -111, dst = {
            {x = 855 + 800, y = 19, w = 40, h = 40, r = 15, g = 15, b = 15}
        }},
        {id = -111, dst = {
            {x = 855 + 750, y = 19, w = 40, h = 40, r = 15, g = 15, b = 15}
        }},
        {id = "button-repl-1", op = {197}, dst = {
            {x = 855 + 750, y = 69, w = 40, h = 40}
        }},
        {id = -111, op = {1205}, dst = {
            {time = 0, x = 855 + 750, y = 69, w = 40, h = 40, g = 0, b = 0, a = 15},
            {time = 500, a = 127},
            {time = 1000, a = 15}
        }},
        {id = "button-repl-num", op = {1205}, dst = {
            {x = 855 + 750, y = 69 + 25, w = 12, h = 12, r = 15, g = 15, b = 15}
        }},
        {id = "button-repl-2", op = {1197}, dst = {
            {x = 855 + 800, y = 69, w = 40, h = 40}
        }},
        {id = -111, op = {1206}, dst = {
            {time = 0, x = 855 + 800, y = 69, w = 40, h = 40, g = 0, b = 0, a = 15},
            {time = 500, a = 127},
            {time = 1000, a = 15}
        }},
        {id = "button-repl-num", op = {1206}, dst = {
            {x = 855 + 800, y = 69 + 25, w = 12, h = 12, r = 15, g = 15, b = 15}
        }},
        {id = "button-repl-3", op = {1200}, dst = {
            {x = 855 + 750, y = 19, w = 40, h = 40}
        }},
        {id = -111, op = {1207}, dst = {
            {time = 0, x = 855 + 750, y = 19, w = 40, h = 40, g = 0, b = 0, a = 15},
            {time = 500, a = 127},
            {time = 1000, a = 15}
        }},
        {id = "button-repl-num", op = {1207}, dst = {
            {x = 855 + 750, y = 19 + 25, w = 12, h = 12, r = 15, g = 15, b = 15}
        }},
        {id = "button-repl-4", op = {1203}, dst = {
            {x = 855 + 800, y = 19, w = 40, h = 40}
        }},
        {id = -111, op = {1208}, dst = {
            {time = 0, x = 855 + 800, y = 19, w = 40, h = 40, g = 0, b = 0, a = 15},
            {time = 500, a = 127},
            {time = 1000, a = 15}
        }},
        {id = "button-repl-num", op = {1208}, dst = {
            {x = 855 + 800, y = 19 + 25, w = 12, h = 12, r = 15, g = 15, b = 15}
        }},
        -- song metadata
        {id = "root_directory", dst = {{w = 680, h = 36, x = 1020, y = 1165}}},
        {id = "root_text", dst = {{w = 850, h = 36, x = 1015, y = 1165, r = 127, g = 127, b = 127}}},

        {id = "genre", dst = {{w = 680, h = 36, x = 1020, y = 1115}}},
        {id = "genre_text", dst = {{w = 850, h = 36, x = 1015, y = 1115, r = 127, g = 127, b = 127}}},

        {id = "artist", dst = {{w = 680, h = 36, x = 1020, y = 1065}}},
        {id = "artist_text", dst = {{w = 850, h = 36, x = 1015, y = 1065, r = 127, g = 127, b = 127}}},

        {id = "bpm", dst = {{w = 680, h = 36, x = 1020, y = 1015}}},
        {id = "bpm_text", dst = {{w = 850, h = 36, x = 1015, y = 1015, r = 127, g = 127, b = 127}}},



        {id = "option-play-big", dst = {
            {x = op_side_x + 5, y = op_play_y - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-play-big", dst = {
            {x = op_side_x, y = op_play_y, w = 400, h = 36}
        }},
        {id = "option-play-lane", dst = {
            {x = op_side_x + 5, y = op_play_y - 50 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-play-lane", dst = {
            {x = op_side_x, y = op_play_y - 50, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-lane", dst = {
            {x = op_side_x - 280, y = op_play_y - 86, w = 300, h = 36}
        }},
        {id = "option-play-gauge", dst = {
            {x = op_side_x + 5, y = op_play_y - 136 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-play-gauge", dst = {
            {x = op_side_x, y = op_play_y - 136, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-gauge", dst = {
            {x = op_side_x - 280, y = op_play_y - 172, w = 300, h = 36}
        }},
        {id = "option-play-hsfix", dst = {
            {x = op_side_x + 5, y = op_play_y - 222 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-play-hsfix", dst = {
            {x = op_side_x, y = op_play_y - 222, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-hsfix", dst = {
            {x = op_side_x - 280, y = op_play_y - 258, w = 300, h = 36}
        }},
        {id = "option-play-lanecover", dst = {
            {x = op_side_x + 5, y = op_play_y - 308 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-play-lanecover", dst = {
            {x = op_side_x, y = op_play_y - 308, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-lanecover", dst = {
            {x = op_side_x - 280, y = op_play_y - 344, w = 300, h = 36}
        }},
        {id = "option-play-lift", dst = {
            {x = op_side_x + 5, y = op_play_y - 394 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-play-lift", dst = {
            {x = op_side_x, y = op_play_y - 394, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-lift", dst = {
            {x = op_side_x - 280, y = op_play_y - 430, w = 300, h = 36}
        }},
        {id = "option-play-target", dst = {
            {x = op_side_x + 5, y = op_play_y - 480 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-play-target", dst = {
            {x = op_side_x, y = op_play_y - 480, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-target", dst = {
            {x = op_side_x, y = op_play_y - 520, w = 300, h = 36}
        }},

        {id = "option-adv-big", dst = {
            {x = op_side_x + 5, y = op_play_y - 620 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-adv-big", dst = {
            {x = op_side_x, y = op_play_y - 620, w = 400, h = 36}
        }},
        {id = "option-adv-bga", dst = {
            {x = op_side_x + 5, y = op_play_y - 670 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-adv-bga", dst = {
            {x = op_side_x, y = op_play_y - 670, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-bga", dst = {
            {x = op_side_x - 280, y = op_play_y - 706, w = 300, h = 36}
        }},
        {id = "option-adv-gas", dst = {
            {x = op_side_x + 5, y = op_play_y - 756 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-adv-gas", dst = {
            {x = op_side_x, y = op_play_y - 756, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-gas", dst = {
            {x = op_side_x - 380, y = op_play_y - 792, w = 400, h = 36}
        }},
        {id = "option-adv-autoadj", dst = {
            {x = op_side_x + 5, y = op_play_y - 842 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-adv-autoadj", dst = {
            {x = op_side_x, y = op_play_y - 842, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-autoadj", dst = {
            {x = op_side_x - 280, y = op_play_y - 878, w = 300, h = 36}
        }},
        {id = "option-adv-scroll", dst = {
            {x = op_side_x + 5, y = op_play_y - 928 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-adv-scroll", dst = {
            {x = op_side_x, y = op_play_y - 928, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-scroll", dst = {
            {x = op_side_x, y = op_play_y - 964, w = 300, h = 36}
        }},
        {id = "option-adv-offset", dst = {
            {x = op_side_x + 5, y = op_play_y - 1014 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-adv-offset", dst = {
            {x = op_side_x, y = op_play_y - 1014, w = 400, h = 36, r = 128, g = 128, b = 128}
        }},
        {id = "option-offset", draw = function() return main_state.number(12) > 0 end, dst = {
            {x = op_side_x, y = op_play_y - 1050, w = 300, h = 36, g = 0, b = 0}
        }},
        {id = "option-offset", draw = function() return main_state.number(12) <= 0 end, dst = {
            {x = op_side_x, y = op_play_y - 1050, w = 300, h = 36, g = 0, r = 0}
        }},

        {id = "option-assist-big", dst = {
            {x = op_side_x + 5, y = op_play_y - 1150 - 5, w = 400, h = 36, r = 15, g = 15, b = 15, a = 127}
        }},
        {id = "option-assist-big", dst = {
            {x = op_side_x, y = op_play_y - 1150, w = 400, h = 36}
        }},
        {id = "option-assist1", dst = {
            {x = op_side_x - 280, y = op_play_y - 1186, w = 300, h = 36, g = 0, b = 0}
        }},
        {id = "option-assist2", dst = {
            {x = op_side_x - 280, y = op_play_y - 1186, w = 300, h = 36, g = 0, b = 0}
        }},
        {id = "option-assist3", dst = {
            {x = op_side_x - 280, y = op_play_y - 1186, w = 300, h = 36, g = 0, b = 0}
        }},
        {id = "option-assist4", dst = {
            {x = op_side_x - 280, y = op_play_y - 1186, w = 300, h = 36, g = 0, b = 0}
        }},
        {id = "option-assist5", dst = {
            {x = op_side_x - 280, y = op_play_y - 1186, w = 300, h = 36, g = 0, b = 0}
        }},
        {id = "option-assist6", dst = {
            {x = op_side_x - 280, y = op_play_y - 1186, w = 300, h = 36, g = 0, b = 0}
        }},
        {id = "option-assist7", dst = {
            {x = op_side_x - 280, y = op_play_y - 1186, w = 300, h = 36, g = 0, b = 0}
        }},
        
    }

  
    return skin
end

return {
    header = header,
    main = main
}