local header = {
	type = 0,
	name = "Private skin sorry",
	w = 2560,
	h = 1440,
	loadend = 3000,
	playstart = 1500,
	scene = 3600000,
	input = 500,
	close = 500,
	fadeout = 200,
	property = property,
	filepath = filepath,
	offset = offset
}

property = {

}

filepath = {

}

offset = {

}

local function main()
    local skin = {}
	-- ヘッダ情報をスキン本体にコピー
	for k, v in pairs(header) do
		skin[k] = v
    end

    skin.source = {
        {id = "w_note",     path = "nutki/white.png"},
        {id = "b_note",     path = "nutki/blue.png"}, 
        {id = "s_note",     path = "nutki/red.png"}, 
        {id = "mine_note" , path = "nutki/mine.png"},

    }

    skin.image = {

    }

    skin.font = {

    }

    local types = {}
	local hash = {}
	
	for _,v in ipairs(lane_types) do
		if (not hash[v]) then
			types[#types+1] = v
			hash[v] = true
		end
	end

    for i, k in ipairs(types) do
		-- print(k)
		if k == 'w' then
			note_source = "w_note"
		elseif k == 'b'	then
			note_source = "b_note"
		elseif k == 's'	then
			note_source = "s_note"
		elseif k == 'm'	then
			note_source = "m_note"
		end 
		skin.image[#skin.image+1] = {id = "note-" .. k, src = note_source, x = 0, y = 30, w = -1, h = 15}
		skin.image[#skin.image+1] = {id = "lne-"  .. k, src = note_source, x = 0, y =  0, w = -1, h = 15}
		skin.image[#skin.image+1] = {id = "lnb-"  .. k, src = note_source, x = 0, y = 15, w = -1, h = 15}
		skin.image[#skin.image+1] = {id = "lns-"  .. k, src = note_source, x = 0, y = 30, w = -1, h = 15}
    end
	
	skin.image[#skin.image+1] = {id = "mine",  src = "mine_note", x = 0, y = 30, w = -1, h = 15}

    skin.note = {id = "notes",note={},lnend={},lnbody={},lnstart={},lnbodyActive={},hcnend={},hcnbody={},hcnstart={},hcnbodyActive={},hcnbodyMiss={},hcnbodyReactive={},mine={},size={},dst={},time={},bpm={},stop={},
        group={
			{id = 'line', dst = {
				{x = 0, y = 0, w = 500, h = 1, a = 128}
			}}},
		time  = {
			{id = 'line', dst = {
				{x = 0, y = 0, w = 500, h = 1, a = 128, r = 64, g = 192, b = 192}
			}}},
		bpm   = {
			{id = 'line', dst = {
				{x = 0, y = 0, w = 500, h = 1, a = 128, h = 1, r = 0, g = 192, b = 0}
			}}},
		stop  = {
			{id = 'line', dst = {
				{x = 0, y = 0, w = 500, h = 1, a = 128, h = 1, r = 192, g = 192, b = 0}
			}}}
    }
    
    for i, k in ipairs(lane_order) do
        local note_id = "note-" .. lane_types[k]
        local lne_id  = "lne-"  .. lane_types[k]
        local lnb_id  = "lnb-"  .. lane_types[k]
        local lns_id  = "lns-"  .. lane_types[k]
        local mine    = "mine"
        -- table.insert(skin.note.note, {note_id}) -- this doesn't work, inserts it as a 1-element 'table'
        -- len+1 assign instead
        skin.note.note           [#skin.note.note            +1] = note_id
        skin.note.lnend          [#skin.note.lnend           +1] = lne_id 
        skin.note.lnbody         [#skin.note.lnbody          +1] = lnb_id 
        skin.note.lnstart        [#skin.note.lnstart         +1] = lns_id 
        skin.note.lnbodyActive   [#skin.note.lnbodyActive    +1] = lnb_id 
        skin.note.hcnend         [#skin.note.hcnend          +1] = lne_id 
        skin.note.hcnbody        [#skin.note.hcnbody         +1] = lnb_id 
        skin.note.hcnstart       [#skin.note.hcnstart        +1] = lns_id 
        skin.note.hcnbodyActive  [#skin.note.hcnbodyActive   +1] = lnb_id 
        skin.note.hcnbodyMiss    [#skin.note.hcnbodyMiss     +1] = lnb_id 
        skin.note.hcnbodyReactive[#skin.note.hcnbodyReactive +1] = lnb_id 
        skin.note.mine           [#skin.note.mine            +1] = mine   
		skin.note.size			 [#skin.note.size			 +1] = note_height
    end

    local lane_offset = lane_width.s+lane_pad
    for i, k in ipairs(lane_order) do
        -- add note at lane origin coord; incr offset equal to lane width + 2 for lane spacing
        if k ~= 8 then 
            skin.note.dst[#skin.note.dst + 1] = {x = lane_origin_x+lane_offset, y = lane_origin_y, w = lane_width.w, h = total_lane_height, r = 0, g = 192, b = 0}
            lane_offset = lane_offset + lane_width.w+lane_pad                              
        else -- scratch
            lane_offset = 0
            skin.note.dst[#skin.note.dst + 1] = {x = lane_origin_x+lane_offset, y = lane_origin_y, w = lane_width.s, h = total_lane_height, r = 0, g = 192, b = 0}
            -- lane_offset = lane_offset + lane_width.s+2
        end
    end
  
    skin.destination = {

    }

    table.insert(skin.destination, {id = "notes", offset = 0})
  
    return skin
end

return {
    header = header,
    main = main
}