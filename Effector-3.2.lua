	-----------------------------------------------------------------------------------------------------------------------------------------
	--[[ Copyright (c) 2015, Vict8r, Karalaura, Nagato Akatsuki & Itachi Akatsuki		All rights reserved / 01 January 2015 Colombia. ]]--
	-----------------------------------------------------------------------------------------------------------------------------------------
	--> Kara Effector 3.2.9.6					   --> IRC Chanel: #KaraEffector
	--> http://www.karaeffector.blogspot.com	   --> http://www.facebook.com/karaeffector
	--> http://www.youtube.com/user/victor8607	   --> http://www.youtube.com/user/NatsuoKE		--> http://www.youtube.com/user/karalaura2012
	-----------------------------------------------------------------------------------------------------------------------------------------
	--[[ El proyecto Effector es un archivo lua que tiene la capacidad de implementar Efectos Karaoke y de Líneas de Traducción prediseñados,
	también brinda la opción de poderlos modificar y crear nuevos Efectos si así se desea. El Effector está dotado de una amplia Librería que
	permite ejecutar los fx que tiene por Default y también crear nuevas y multiples combinaciones.
	El uso del Effector es libre, si se desea se pueden colocar los respectivos créditos de su autor y/o colaboradores. La mayor parte de las
	combinaciones de Efectos y Funciones son capaces de reproducir casi cualquier tipo de fx, además de poseer una amplia variedad de figuras
	Shapes para los efectos que así lo requieran.
	Deseamos que el Effector les sea de gran utilidad y sirva de punto de inicio para que cada uno pueda hacer libremente sus propios efectos
	y lograr combinaciones que sean usadas cuando se necesiten. Recomendamos evitar cualquier forma de modificación en el código del Effector
	o de su Librería, a menos que estén completamente seguros de lo que están haciendo ya que lo que más factible es que deje de funcionar de
	manera correcta. Sin más, nos despedimos, esperando que este trabajo sea del agrado de todos ustedes. ^^'... ]]--
	-----------------------------------------------------------------------------------------------------------------------------------------
	include( "karaskel.lua" )
	include( "Effector-utils-lib-3.2.lua" )
	leadin_fx, hilight_fx, leadout_fx, shape_fx, transla_fx = { }, { }, { }, { }, { }
	leadin_fx_library, hilight_fx_library, leadout_fx_library, shape_fx_library, transla_fx_library = { }, { }, { }, { }, { }
	list_mode = {"lead-in[fx]", "hi-light[fx]", "lead-out[fx]", "shape[fx]", "translation[fx]"}
	list_fx = {leadin_fx, hilight_fx, leadout_fx, shape_fx, transla_fx}
	list_library = {leadin_fx_library, hilight_fx_library, leadout_fx_library, shape_fx_library, transla_fx_library}
	--=====================================================================================================================================--
	script_name = "Kara Effector[fx]"
	script_description = "Effects Automation Karaokes. Creating Effects with Modifiable Parameters"
	script_author = "Project KaraLaura"
	script_version = "3.2"
	--=====================================================================================================================================--
	Path_Effector_newfx_lua = nil
	--Path_Effector_newfx_lua = "C:\\Users\\DM4\\Kara Effector 3.2\\Effector-newfx-3.2.lua"
	--=====================================================================================================================================--
	
	function effector.do_fx( subs, meta, line, sett )
		--------------------------------------------------------------
		xres = meta.res_x or 1280
		yres = meta.res_y or 720
		if xres == nil then
			ratio = 1
		else
			ratio = xres/1280
		end
		msa, msb = aegisub.ms_from_frame(1), aegisub.ms_from_frame(101)
		if msb  == nil then
			frame_dur = 41.708
		else
			frame_dur = (msb - msa)/100
		end
		--------------------------------------------------------------
		line.i, line.n = l_counter, maxil_counter
		line.index = idx_line[line.i] + count_line_dialogue - ini_line
		ii = line.index
		--------------------------------------------------------------
		fx, var = { }, { }
		l = linefx[ii]
		L = linefx[ii].styleref
		line.dur = l.duration
		l_fx = line.effect
		-------------------------------------------------------------------------------
		l_layer, l_style, l_actor, l_spacing = l.layer, l.style, l.actor, l.spacing
		l_ml, l_mr, l_mt, l_mb = l.margin_l, l.margin_r, l.margin_t, l.margin_b
		l_align, l_dur, l_x, l_y, l_i = l.align, line.dur, l.center, l.middle, line.i
		l_start, l_end, l_mid, l_n = l.start_time, l.end_time, l.mid_time, line.n
		l_left, l_center, l_right, l_width = l.left, l.center, l.right, l.width
		l_top, l_middle, l_bottom, l_height = l.top, l.middle, l.bottom, l.height
		l_angle, l_outline, l_shadow, l_mv = l.angle, l.outline, l.shadow, l.margin_v
		l_scale_x, l_scale_y, l_fsize, l_fname = l.scale_x, l.scale_y, l.fontsize, l.fontname
		l_color1, l_color2, l_color3, l_color4 = l.color1, l.color2, l.color3, l.color4
		l_alpha1, l_alpha2, l_alpha3, l_alpha4 = l.alpha1, l.alpha2, l.alpha3, l.alpha4
		-------------------------------------------------------------------------------
		lfx = linefx[ii]
		txt_chars = line.text_stripped:gsub("\\N", " "):gsub("  ", " ")
		char, left, width, line.char = { }, l.left, 0, linefx[ii].char
		char.i = 1
		if fx__.noblank == true then
			char.n = unicode.len(txt_chars:gsub(" ", ""))
		else
			char.n = unicode.len(txt_chars)
		end
		--------------------------------------
		text.color1 = color.ass(sett.color_1c)
		text.color1c = text.color1
		text.alpha1 = ass_alpha(sett.alpha_1a)
		text.alpha1a = text.alpha1
		text.color2 = color.ass(sett.color_2c)
		text.color2c = text.color2
		text.alpha2 = ass_alpha(sett.alpha_2a)
		text.alpha2a = text.alpha2
		text.color3 = color.ass(sett.color_3c)
		text.color3c = text.color3
		text.alpha3 = ass_alpha(sett.alpha_3a)
		text.alpha3a = text.alpha3
		text.color4 = color.ass(sett.color_4c)
		text.color4c = text.color4
		text.alpha4 = ass_alpha(sett.alpha_4a)
		text.alpha4a = text.alpha4
		shape.color1 = color.ass(fx__.color1)
		shape.color1c = shape.color1
		shape.alpha1 = ass_alpha(fx__.alpha1)
		shape.alpha1a = shape.alpha1
		shape.color3 = color.ass(fx__.color3)
		shape.color3c = shape.color3
		shape.alpha3 = ass_alpha(fx__.alpha3)
		shape.alpha3a = shape.alpha3
		shape.color4 = color.ass(fx__.color4)
		shape.color4c = shape.color4
		shape.alpha4 = ass_alpha(fx__.alpha4)
		shape.alpha4a = shape.alpha4
		-------------------------------------
		if text.color1 == l.color1 then
			txt_c1 = ""
		else
			txt_c1 = "\\1c"..text.color1
		end
		if text.alpha1 == l.alpha1 then
			txt_a1 = ""
		else
			txt_a1 = "\\1a"..text.alpha1
		end
		if text.color3 == l.color3 then
			txt_c3 = ""
		else
			txt_c3 = "\\3c"..text.color3
		end
		if text.alpha3 == l.alpha3 then
			txt_a3 = ""
		else
			txt_a3 = "\\3a"..text.alpha3
		end
		if text.color4 == l.color4 then
			txt_c4 = ""
		else
			txt_c4 = "\\4c"..text.color4
		end
		if text.alpha4 == l.alpha4 then
			txt_a4 = ""
		else
			txt_a4 = "\\4a"..text.alpha4
		end
		--------------------------------------------------------------------------------
		text.color = format("\\1c%s\\3c%s\\4c%s", text.color1, text.color3, text.color4)
		text.alpha = format("\\1a%s\\3a%s\\4a%s", text.alpha1, text.alpha3, text.alpha4)
		text.style = txt_c1..txt_c3..txt_c4..txt_a1..txt_a3..txt_a4
		text.alpha0 = "\\alpha&HFF&"
		shape.color = format("\\1c%s\\3c%s\\4c%s", shape.color1, shape.color3, shape.color4)
		shape.alpha = format("\\1a%s\\3a%s\\4a%s", shape.alpha1, shape.alpha3, shape.alpha4)
		shape.style = shape.color..shape.alpha
		shape.alpha0 = "\\alpha&HFF&"
		if sett.tags_filter == "No Tags Color and Alpha"
			or sett.tags_filter == "No Tags Color and Alpha [VSFilterMod]" then
			text.style = ""
			shape.style = ""
		end
		----------------------------
		effector.effect_offset( )
		----------------------------
		if fx__.v_kanji == true then
			fx.mode = "v"
		else
			fx.mode = "h"
		end
		if fx__.noblank == true then
			noblank1, noblank2 = "", " "
			blk = ""
		else
			noblank1 = script_name .. " " .. script_author
			noblank2 = script_name .. " " .. script_author
			blk = " "
		end
		if sett.tags_filter == "VSFilterMod"
			or sett.tags_filter == "No Tags Color and Alpha [VSFilterMod]" then
			fx.filter = "mod"
			fx.tm = tag.to_mod
		else
			fx.filter = "2.39"
			fx.tm = tag.to_vsf
		end
		function maxloop( new_maxloop )
			fx.maxloop_fx = new_maxloop
			maxj = fx.maxloop_fx
			return ""
		end
		function replay( num_replay )
			fx.replay_fx = num_replay
			maxJ = fx.replay_fx
			return ""
		end
		function relayer( new_layer )
			fx.layer = new_layer
			return ""
		end
		function export_text( mode )
			local newfile = aegisub.dialog.save("Kara Effector[fx]: Export File", "", "", "Text files (.txt)|.txt", false)
			local fxmode, fxname = mode, nil
			if mode:match(",") then
				fxmode = mode:match("%w+[ %w]*")
				fxname = mode:match("%,+[ %S]*"):gsub("%,[ ]*", ""):gsub(" ", "_")
			end
			if newfile then
				local file = io.open(newfile, "w")
				if fxmode == "export times ms" then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].start_time..","..linefx[idx_line[i] + count_line_dialogue - ini_line].end_time.."\n")
					end
				elseif fxmode == "export times" then
					for i = 1, line.n do
						file:write(ms_to_HMS(linefx[idx_line[i] + count_line_dialogue - ini_line].start_time)..","..ms_to_HMS(linefx[idx_line[i] + count_line_dialogue - ini_line].end_time).."\n")
					end
				elseif fxmode == "export lines" then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].raw.."\n")
					end
				elseif fxmode == "export text" then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].text.."\n")
					end
				elseif fxmode == "export hira" then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].hira.text.."\n")
					end
				elseif fxmode == "export kata" then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].kata.text.."\n")
					end
				elseif fxmode == "export roma" then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].roma.text.."\n")
					end
				elseif fxmode == "export text_stripped"	then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].text_stripped.."\n")
					end
				elseif fxmode == "export hira_stripped" then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].hira.text_stripped.."\n")
					end
				elseif fxmode == "export kata_stripped" then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].kata.text_stripped.."\n")
					end
				elseif fxmode == "export roma_stripped" then
					for i = 1, line.n do
						file:write(linefx[idx_line[i] + count_line_dialogue - ini_line].roma.text_stripped.."\n")
					end
				elseif fxmode == "export config" then
					if fx__.folderfx == "lead-in[fx]" then
						library_fx, library_mode, actor_fx = "leadin_fx_library", "leadin_fx", "lead-in"
					elseif fx__.folderfx == "hi-light[fx]" then
						library_fx, library_mode, actor_fx = "hilight_fx_library", "hilight_fx", "hi-light"
					elseif fx__.folderfx == "lead-out[fx]" then
						library_fx, library_mode, actor_fx = "leadout_fx_library", "leadout_fx", "lead-out"
					elseif fx__.folderfx == "shape[fx]" then
						library_fx, library_mode, actor_fx = "shape_fx_library", "shape_fx", "shape-fx"
					elseif fx__.folderfx == "translation[fx]" then
						library_fx, library_mode, actor_fx = "transla_fx_library", "transla_fx", "translation"
					end
					library_title = fx__.folderfx
					lines_comment = false
					newFX = fxname or library_mode .. "_" .. tostring(os.time( )):sub(-6, -1)
					if fx__.folderfx == "lead-in[fx]" or fx__.folderfx == "hi-light[fx]" or fx__.folderfx == "lead-out[fx]" then
						fx_GUI = "PfxM_Box"
					elseif fx__.folderfx == "shape[fx]" then
						fx_GUI = "Shape_Box"
					elseif fx__.folderfx == "translation[fx]" then
						if fx_box[29].value == "Char" then
							fx_box[29].value = "Translation Char"
						elseif fx_box[29].value == "Syl" or fx_box[29].value == "Furi" or fx_box[29].value == "Word"
							or fx_box[29].value == "Convert to Hiragana" or fx_box[29].value == "Convert to Katakana"
							or fx_box[29].value == "Convert to Romaji" then
							fx_box[29].value = "Translation Word"
						elseif fx_box[29].value == "Line" then
							fx_box[29].value = "Translation Line"
						end
						fx_GUI = "Trans_Box"
					end
					New_fx_config = format("%s = table.duplicate(%s); table.inbox(%s, \"%s: %s\",\"%s\",%s,%s,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%s); table.insert(%s, %s); table.insert(%s, \"%s\")", newFX, fx_GUI, newFX, library_title, newFX:gsub("_", " "), fx_box[29].value, ((fx_box[30].value == true) and "true" or "false"), ((fx_box[31].value == true) and "true" or "false"), fx_box[32].value, fx_box[33].value, fx_box[34].value, fx_box[35].value, fx_box[36].value, fx_box[37].value, Ps(fx_box[38].text), Ps(fx_box[39].text), Ps(fx_box[40].text), Ps(fx_box[41].text), Ps(fx_box[42].text), Ps(fx_box[43].text), Ps(fx_box[44].text), Ps(fx_box[45].text), Ps(fx_box[46].text), Ps(fx_box[47].text), Ps(fx_box[48].text), Ps(fx_box[49].text), Ps(fx_box[50].text), Ps(fx_box[51].text), Ps(fx_box[52].text), Ps(fx_box[53].text), Ps(fx_box[54].text), Ps(fx_box[55].text), Ps(fx_box[56].text), Ps(fx_box[57].text), fx_box[66].value, ((fx_box[67].value == true) and "true" or "false"), library_fx, newFX, library_mode, newFX:gsub("_", " "))
					fx_libx = format("%s", fx__.folderfx:sub(1, -5) .. " fx")
					while fx_libx:len( ) < 14 do
						fx_libx = fx_libx .. " "
					end
					fx_date = format("--[[%s %s]] ", fx_libx, tostring( os.date( ) ):sub(1, -4))
					file:write( fx_date .. New_fx_config .. "\n	" )
				end
			end
		end
		---------------------------------------------
		if (fx__.t_type == "Line" or fx__.t_type == "Syl" or fx__.t_type == "Char" or fx__.t_type == "Furi"
			or fx__.t_type == "Convert to Hiragana" or fx__.t_type == "Convert to Katakana"
			or fx__.t_type == "Convert to Romaji" or fx__.t_type == "Template Line [Word]"
			or fx__.t_type == "Template Line [Syl]" or fx__.t_type == "Template Line [Char]")
			and line.text_stripped:gsub(" ", ""):gsub("	", "") ~= noblank1 then
			
			if fx__.printfx == true then
				if fx__.folderfx == "lead-in[fx]" then
					library_fx, library_mode, actor_fx = "leadin_fx_library", "leadin_fx", "lead-in"
				elseif fx__.folderfx == "hi-light[fx]" then
					library_fx, library_mode, actor_fx = "hilight_fx_library", "hilight_fx", "hi-light"
				elseif fx__.folderfx == "lead-out[fx]" then
					library_fx, library_mode, actor_fx = "leadout_fx_library", "leadout_fx", "lead-out"
				elseif fx__.folderfx == "shape[fx]" then
					library_fx, library_mode, actor_fx = "shape_fx_library", "shape_fx", "shape-fx"
				elseif fx__.folderfx == "translation[fx]" then
					library_fx, library_mode, actor_fx = "transla_fx_library", "transla_fx", "translation"
				end
				library_title = fx__.folderfx
				lines_comment = false
				local l = table.copy(line)
				if line.i == 1 then
					newFX = fx__.namefx:gsub(" ", "_")
					if newFX == "" then
						newFX = library_mode .. "_" .. tostring(os.time( )):sub(-6, -1)
					end
					if fx__.folderfx == "lead-in[fx]" or fx__.folderfx == "hi-light[fx]" or fx__.folderfx == "lead-out[fx]" then
						fx_GUI = "PfxM_Box"
					elseif fx__.folderfx == "shape[fx]" then
						fx_GUI = "Shape_Box"
					elseif fx__.folderfx == "translation[fx]" then
						if fx_box[29].value == "Char" then
							fx_box[29].value = "Translation Char"
						elseif fx_box[29].value == "Syl" or fx_box[29].value == "Furi" or fx_box[29].value == "Word"
							or fx_box[29].value == "Convert to Hiragana" or fx_box[29].value == "Convert to Katakana"
							or fx_box[29].value == "Convert to Romaji" then
							fx_box[29].value = "Translation Word"
						elseif fx_box[29].value == "Line" then
							fx_box[29].value = "Translation Line"
						end
						fx_GUI = "Trans_Box"
					end
					New_fx_config = format("%s = table.duplicate(%s); table.inbox(%s, \"%s: %s\",\"%s\",%s,%s,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%s); table.insert(%s, %s); table.insert(%s, \"%s\")", newFX, fx_GUI, newFX, library_title, newFX:gsub("_", " "), fx_box[29].value, ((fx_box[30].value == true) and "true" or "false"), ((fx_box[31].value == true) and "true" or "false"), fx_box[32].value, fx_box[33].value, fx_box[34].value, fx_box[35].value, fx_box[36].value, fx_box[37].value, Ps(fx_box[38].text), Ps(fx_box[39].text), Ps(fx_box[40].text), Ps(fx_box[41].text), Ps(fx_box[42].text), Ps(fx_box[43].text), Ps(fx_box[44].text), Ps(fx_box[45].text), Ps(fx_box[46].text), Ps(fx_box[47].text), Ps(fx_box[48].text), Ps(fx_box[49].text), Ps(fx_box[50].text), Ps(fx_box[51].text), Ps(fx_box[52].text), Ps(fx_box[53].text), Ps(fx_box[54].text), Ps(fx_box[55].text), Ps(fx_box[56].text), Ps(fx_box[57].text), fx_box[66].value, ((fx_box[67].value == true) and "true" or "false"), library_fx, newFX, library_mode, newFX:gsub("_", " "))
					if Path_Effector_newfx_lua == nil then
						l.comment = true
						l.effect = "Effector [Fx] Config"
						l.start_time, l.end_time = 0, 0
						l.text = New_fx_config
						subs.append(l)
					else
						fx_libx = format("%s", fx__.folderfx:sub(1, -5) .. " fx")
						while fx_libx:len( ) < 14 do
							fx_libx = fx_libx .. " "
						end
						fx_date = format("--[[%s %s]] ", fx_libx, tostring( os.date( ) ):sub(1, -4))
						effector.savefx( fx_date .. New_fx_config .. "\n	", Path_Effector_newfx_lua )
						aegisub.debug.out("The effect ★%s★ is saved in the Folder %s, you must reload the script Kara Effector so you can see it in the list effects type %s.\n\nEl efecto ★%s★ se ha guardado en el Folder %s, debes recargar el script Kara Effector para que puedas verlo en la lista de efectos tipo %s.", newFX:gsub("_", " "), fx__.folderfx, fx__.folderfx, newFX:gsub("_", " "), fx__.folderfx, fx__.folderfx)
						aegisub.progress.set(100)
					end
				end
			else
				if fx__.namefx:sub(1, 7) == "export " then
					if line.i == 1 then
						export_text(fx__.namefx)
						lines_comment = false
					end
					fx_box[62].text = ""
				else
					actor_fx = fx__.effect:gsub("%[.+[%W+]*", "")
					if fx__.t_type == "Syl" or fx__.t_type == "Char" or fx__.t_type == "Convert to Hiragana"
						or fx__.t_type == "Convert to Katakana" or fx__.t_type == "Convert to Romaji" then
						FX_mode = line.kara.n
					elseif fx__.t_type == "Furi" then
						FX_mode = line.furi.n
					elseif fx__.t_type == "Line" or fx__.t_type == "Template Line [Word]"
						or fx__.t_type == "Template Line [Syl]" or fx__.t_type == "Template Line [Char]" then
						FX_mode = 1
					end
					for i = 1, FX_mode do
						furi = line.furi[i]
						syl = line.kara[i]
						local x = line.left + syl.center
						local y = line.middle
						local l = table.copy(line)
						count_s = i
						-----------------------------------------------------------
						hira = linefx[ii].hira[i]
						hira.i = i
						hira.n = line.kara.n
						kata = linefx[ii].kata[i]
						kata.i = i
						kata.n = line.kara.n
						roma = linefx[ii].roma[i]
						roma.i = i
						roma.n = line.kara.n
						-----------------------------------------------------------
						syl.n = line.kara.n
						syl.dur = syl.duration
						syl.mid_time = syl.start_time + syl.dur/2
						syl.center = x
						syl.middle = y
						syl.left = syl.center - syl.width/2
						syl.right = syl.center + syl.width/2
						syl.top = syl.middle - syl.height/2
						syl.bottom = syl.middle + syl.height/2
						syl.widtht = syl.width + syl.prespacewidth + syl.postspacewidth
						syl.widthmax = math.max(unpack(mmwth[ii].sy))
						syl.widthmin = math.min(unpack(mmwth[ii].sy))
						syl.durmax = math.max(unpack(mmdur[ii].sy))
						syl.durmin = math.min(unpack(mmdur[ii].sy))
						syl.text = syl.text_stripped
						-----------------------------------------------------------
						if fx__.t_type == "Syl" or fx__.t_type == "Line" or fx__.t_type == "Convert to Hiragana"
							or fx__.t_type == "Convert to Katakana" or fx__.t_type == "Convert to Romaji"
							or fx__.t_type == "Template Line [Word]" or fx__.t_type == "Template Line [Syl]"
							or fx__.t_type == "Template Line [Char]" then
							
							if syl.text ~= noblank1 and syl.text ~= noblank2 then
								---------------------------------------------------
								if fx__.t_type == "Syl" then
									val_width, val_height, val_text = syl.width, syl.height, syl.text
									val_center, val_middle, val_left, val_right = syl.center, syl.middle, syl.left, syl.right
									val_top, val_bottom, val_dur = syl.top, syl.bottom, syl.duration
									val_start, val_end, val_mid  = syl.start_time, syl.end_time, syl.mid_time
									val_i, val_n = syl.i, syl.n
								elseif fx__.t_type == "Convert to Hiragana" then
									val_width, val_height, val_text = hira.width, hira.height, hira.text
									val_center, val_middle, val_left, val_right = hira.center, hira.middle, hira.left, hira.right
									val_top, val_bottom, val_dur = hira.top, hira.bottom, hira.duration
									val_start, val_end, val_mid  = hira.start_time, hira.end_time, hira.mid_time
									val_i, val_n = hira.i, hira.n
								elseif fx__.t_type == "Convert to Katakana" then
									val_width, val_height, val_text = kata.width, kata.height, kata.text
									val_center, val_middle, val_left, val_right = kata.center, kata.middle, kata.left, kata.right
									val_top, val_bottom, val_dur = kata.top, kata.bottom, kata.duration
									val_start, val_end, val_mid  = kata.start_time, kata.end_time, kata.mid_time
									val_i, val_n = kata.i, kata.n
								elseif fx__.t_type == "Convert to Romaji" then
									val_width, val_height, val_text = roma.width, roma.height, roma.text
									val_center, val_middle, val_left, val_right = roma.center, roma.middle, roma.left, roma.right
									val_top, val_bottom, val_dur = roma.top, roma.bottom, roma.duration
									val_start, val_end, val_mid  = roma.start_time, roma.end_time, roma.mid_time
									val_i, val_n = roma.i, roma.n
								else
									val_width, val_height, val_text = l.width, l.height, line.text_stripped
									val_center, val_middle, val_left, val_right = l.center, l.middle, l.left, l.right
									val_top, val_bottom, val_dur = l.top, l.bottom, line.duration
									val_start, val_end, val_mid  = line.start_time, line.end_time, line.mid_time
									val_i, val_n = line.i, line.n
								end
								shape.trapeze1t = format("m 0 0 l 0 %d l %d %d l %d 0 ", syl.height, syl.width, syl.height, syl.width + syl.height)
								shape.trapeze1b = format("m 0 0 l 0 %d l %d %d l %d 0 ", syl.height, syl.width + syl.height, syl.height, syl.width)
								----------------------------------------------
								S_ = aegisub.word( line.text, line.dur, aegisub.word2s( ) )
								----------------------------------------------
								word_start, word_end, word_mid, word_dur, word_i, word_n, word_left, word_center, word_right, word_bottom, word_middle, word_top, word_width, word_height = word.start_time, word.end_time, word.mid_time, word.dur, word.i, word.n, word.left, word.center, word.right, word.bottom, word.middle, word.top, word.width, word.height
								syl_start,  syl_end,  syl_mid,  syl_dur,  syl_i,  syl_n,  syl_left,  syl_center,  syl_right,  syl_bottom,  syl_middle,  syl_top,  syl_width,  syl_height  = syl.start_time, syl.end_time, syl.mid_time, syl.dur, syl.i, syl.n, syl.left, syl.center, syl.right, syl.bottom, syl.middle, syl.top, syl.width, syl.height
								furi_start, furi_end, furi_mid, furi_dur, furi_i, furi_n, furi_left, furi_center, furi_right, furi_bottom, furi_middle, furi_top, furi_width, furi_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								hira_start, hira_end, hira_mid, hira_dur, hira_i, hira_n, hira_left, hira_center, hira_right, hira_bottom, hira_middle, hira_top, hira_width, hira_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								kata_start, kata_end, kata_mid, kata_dur, kata_i, kata_n, kata_left, kata_center, kata_right, kata_bottom, kata_middle, kata_top, kata_width, kata_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								roma_start, roma_end, roma_mid, roma_dur, roma_i, roma_n, roma_left, roma_center, roma_right, roma_bottom, roma_middle, roma_top, roma_width, roma_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								char_start, char_end, char_mid, char_dur, char_i, char_n, char_left, char_center, char_right, char_bottom, char_middle, char_top, char_width, char_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								----------------------------------------------
								C_ = aegisub.syls2c( )
								wordsyl = { }
								wordsyl.i, wordsyl.n = aegisub.wordsi( syl.i )
								----------------------------------------------
								if fx__.t_type == "Template Line [Char]" then
									char.n = unicode.len(line.text_stripped)
								end
								----------------------------------------------
								fx.replay_fx, J = 1, 1
								maxJ = fx.replay_fx
								while J <= fx.replay_fx do
									j = 1
									if fx.replay_fx == 1 then
										moduler = 0
									else
										moduler = (J - 1)/(maxJ - 1)
									end
									module = 0
									module1 = module
									module2 = module1
									fxgroup = true
									-----------------------------------------------
									effector.default_val( )
									-----------------------------------------------
									if pcall(loadstring("return function(fx__, line, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")) == true then
										variable_ = loadstring(format("return function(fx__, line, x, y) %s return \"\" end", tag.HTML_to_ass(fx__.variable)))( )
										var_KEfx_ = variable_( fx__, line, x, y )
									end
									variable_ = loadstring("return function(fx__, line, x, y) return {".. tag.HTML_to_ass(fx__.variable) .."} end")( )
									if line.i == 1 and syl.i == 1 and J == 1 then
										var.once = remember("v_once", variable_( fx__, line, x, y ))
									else
										var.once = recall.v_once
									end
									if syl.i  == 1 and J == 1 then
										var.line = variable_( fx__, line, x, y )
									end
									if wordsyl.i == 1 and J == 1 then
										var.word = variable_( fx__, line, x, y )
									end
									if J == 1 then
										var.rep  = variable_( fx__, line, x, y )
									end
									var.syl = variable_( fx__, line, x, y )
									var.furi, var.char = var.syl, var.syl
									var.loop = variable_( fx__, line, x, y )
									-----------------------------------------------
									maxloop1 = loadstring("return function(fx__, line, x, y) return {".. fx__.loops .."} end")( )
									maxloop_fx = maxloop1( fx__, line, x, y )
									loop_h = ceil((maxloop_fx[1] or 1)*(val_width + 2*L.outline)/(val_height + 2*L.outline))
									maxloop_fx = maxloop1( fx__, line, x, y )
									fx.loop_v = maxloop_fx[1] or 1
									fx.loop_h = maxloop_fx[2] or 1
									fx.loop_3 = maxloop_fx[3] or 1
									fx.maxloop_fx = fx.loop_v*fx.loop_h*fx.loop_3
									maxj = fx.maxloop_fx
									-----------------------------------------------
									while j <= fx.maxloop_fx do
										var.loop = variable_( fx__, line, x, y )
										--variables de modulo--
										if fx.maxloop_fx == 1 then
											module  = 0
										else
											module  = (j - 1)/(maxj - 1)
										end
										if syl.n == 1 then
											module1 = module
										else
											module1 = (syl.i + module - 1)/(syl.n + module - 1)
										end
										if line.n == 1 then
											module2 = module1
										else
											module2 = (line.i + module1 - 1)/(line.n + module1 - 1)
										end
										--variables de tiempo--
										fx__.start_t = fx__.start_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										fx__.end_t = fx__.end_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										start_t1 = loadstring("return function(fx__, line) return {".. fx__.start_t .."} end")( )
										start_t	= start_t1( fx__, line )
										if #start_t > 0 then
											fx.start_time = start_t[1]
										else
											fx.start_time = line.start_time
										end
										l.start_time = fx.start_time
										end_t1 = loadstring("return function(fx__, line) return {".. fx__.end_t .."} end")( )
										end_t = end_t1( fx__, line )
										if #end_t > 0 then
											fx.end_time = end_t[1]
										else
											fx.end_time = line.end_time
										end
										l.end_time = fx.end_time
										fx.dur = fx.end_time - fx.start_time
										function retime( mode, add_start, add_end )
											add_start = HMS_to_ms( add_start ) or 0
											add_end = HMS_to_ms( add_end ) or 0
											if mode == "line" then
												l.start_time = line.start_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "preline" then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + add_end
											elseif mode == "postline" then
												l.start_time = line.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "word" then
												l.start_time = line.start_time + word.start_time + add_start
												l.end_time = line.start_time + word.end_time + add_end
											elseif mode == "preword" then
												l.start_time = line.start_time + word.start_time + add_start
												l.end_time = line.start_time + word.start_time + add_end
											elseif mode == "postword" then
												l.start_time = line.start_time + word.end_time + add_start
												l.end_time = line.start_time + word.start_time + add_end
											elseif mode == "syl" then
												l.start_time = line.start_time + syl.start_time + add_start
												l.end_time = line.start_time + syl.end_time + add_end
											elseif mode == "presyl" then
												l.start_time = line.start_time + syl.start_time + add_start
												l.end_time = line.start_time + syl.start_time + add_end
											elseif mode == "postsyl" then
												l.start_time = line.start_time + syl.end_time + add_start
												l.end_time = line.start_time + syl.end_time + add_end
											elseif mode == "start2word"	then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + word.start_time + add_end
											elseif mode == "word2end" then
												l.start_time = line.start_time + word.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "start2syl" then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + syl.start_time + add_end
											elseif mode == "syl2end" then
												l.start_time = line.start_time + syl.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "linepct" then
												l.start_time = line.start_time + add_start*line.duration/100
												l.end_time = line.start_time + add_end*line.duration/100
											elseif mode == "wordpct" then
												l.start_time = line.start_time + word.start_time + add_start*word.duration/100
												l.end_time = line.start_time + word.start_time + add_end*word.duration/100
											elseif mode == "sylpct" then
												l.start_time = line.start_time + syl.start_time + add_start*syl.duration/100
												l.end_time = line.start_time + syl.start_time + add_end*syl.duration/100
											elseif mode == "set" or mode == "abs" then
												l.start_time = add_start; l.end_time = add_end
											elseif mode == "fxpretime" then
												l.start_time = fx.start_time + add_start
												l.end_time = fx.start_time + add_end
											elseif mode == "fxtime"	 then
												l.start_time = fx.start_time + add_start
												l.end_time = fx.end_time + add_end
											elseif mode == "fxposttime"	then
												l.start_time = fx.end_time + add_start
												l.end_time = fx.end_time + add_end
											elseif mode == "fxpct" then
												l.start_time = fx.start_time + add_start*fx.dur/100
												l.end_time = fx.start_time + add_end*fx.dur/100
											end
											fx.start_time, fx.end_time = l.start_time, l.end_time
											fx.dur = fx.end_time - fx.start_time
											return ""
										end
										---------------------------------------------------
										without = { }
										ini = line.start_time - fx.start_time
										without.syl = format("\\t(%s,%s,\\1a&HFF&\\3a&HFF&\\4a&HFF&)\\t(%s,%s,\\1a%s\\3a%s\\4a%s)", ini + syl.start_time, ini + syl.start_time + 1, ini + syl.end_time, ini + syl.end_time + 1, text.alpha1, text.alpha3, text.alpha4)
										syl.syl_start = ini + syl.start_time
										syl.syl_end = syl.syl_start + syl.dur
										--variables de punto de referencia--
										center_x1 = loadstring("return function(fx__, meta, line, x, y, module) return {".. fx__.center_x .."} end")( )
										center_x = center_x1( fx__, meta, line, x, y, module )
										if #center_x > 0 then
											fx.center_x = center_x[1]
										else
											fx.center_x = val_center
										end
										center_y1 = loadstring("return function(fx__, meta, line, x, y, module) return {".. fx__.center_y .."} end")( )
										center_y = center_y1( fx__, meta, line, x, y, module )
										if #center_y > 0 then
											fx.center_y = center_y[1]
										else
											fx.center_y = val_middle
										end
										--variables de escalas de funciones paramétricas-- 
										if j == 1 then
											scale_x1 = loadstring("return function(fx__, meta, line) return {".. fx__.scale_x .."} end")( )
											scale_x = scale_x1( fx__, meta, line )
											if #scale_x > 0 then
												fx.scale_x = scale_x[1]
											else
												fx.scale_x = 1
											end
											if fx.scale_x <= 0 then
												fx.scale_x = 0.1
											end
											scale_y1 = loadstring("return function(fx__, meta, line) return {".. fx__.scale_y .."} end")( )
											scale_y = scale_y1( fx__, meta, line )
											if #scale_y > 0 then
												fx.scale_y = scale_y[1]
											else
												fx.scale_y = 1
											end
											if fx.scale_y <= 0 then
												fx.scale_y = 0.1
											end
										end
										offset_maxspace = scale_x[2] or 0
										offset_h = center_y[2] or 0.9
										--variables de dominio de funciones--
										if j == 1 then
											s_i1 = loadstring("return function(fx__, meta, line) return {".. fx__.s_i .."} end")( )
											s_i = s_i1( fx__, meta, line )
											if #s_i > 0 then
												fx.domain_i = s_i[1]
											else
												fx.domain_i = 0
											end
											s_f1 = loadstring("return function(fx__, meta, line) return {".. fx__.s_f .."} end")( )
											s_f = s_f1( fx__, meta, line )
											if #s_f > 0 then
												fx.domain_f = s_f[1]
											else
												fx.domain_f = 1
											end
										end
										local s = fx.domain_i + module*(fx.domain_f - fx.domain_i)
										--variables de funciones paramétricas--
										fun_x1 = loadstring("return function(fx__, meta, line, s) return {".. fx__.fun_x .."} end")( )
										fun_x = fun_x1( fx__, meta, line, s )
										if #fun_x > 0 then
											fx.fun_x = fun_x[1]*fx.scale_x
										else
											fx.fun_x = 0
										end
										fun_y1 = loadstring("return function(fx__, meta, line, s) return {".. fx__.fun_y .."} end")( )
										fun_y = fun_y1( fx__, meta, line, s )
										if #fun_y > 0 then
											fx.fun_y = fun_y[1]*fx.scale_y
										else
											fx.fun_y = 0
										end
										--definir líneas de texto, verticales u horizontales--
										fx.pos_x, fx.pos_y = effector.knj( fx__.v_kanji )
										fx.off_x, fx.off_y = effector.modify_pos( )
										--variables de posiciones--
										fx.pos_x = fx.pos_x + fx.fun_x - fx.off_x
										fx.pos_y = fx.pos_y + fx.fun_y - fx.off_y
										fx.pos_l = fx.pos_x - val_width/2
										fx.pos_r = fx.pos_x + val_width/2
										fx.pos_t = fx.pos_y - l.height/2
										fx.pos_b = fx.pos_y + l.height/2
										x, y = fx.pos_x, fx.pos_y
										--variables de tamaño--
										size1 = loadstring("return function(fx__, meta, line, s) return {".. fx__.size .."} end")( )
										size = size1( fx__, meta, line, s )
										if #size > 0 then
											if #size == 1 then
												fx.sizex = math.round(size[1], 2)
												fx.sizey = fx.sizex
											elseif #size == 2 then
												fx.sizex = math.round(size[1], 2)
												fx.sizey = math.round(size[2], 2)
											end
											fx.tag_size = format("\\fscx%s\\fscy%s", fx.sizex, fx.sizey)
										else
											fx.sizex = L.scale_x
											fx.sizey = L.scale_y
											fx.tag_size = ""
										end
										--variables de alineación y de capa (layer)--
										align1 = loadstring("return function(fx__, meta, line, s, module) return {".. fx__.align .."} end")( )
										align = align1( fx__, meta, line, s, module )
										if #align > 0 then
											fx.align = "\\an"..align[1]
										else
											fx.align = ""
										end
										layer1 = loadstring("return function(fx__, meta, line, s, module) return {".. fx__.layer .."} end")( )
										layer = layer1( fx__, meta, line, s, module )
										fx.layer = layer[1] or l_layer
										--variables de posiciones definitivas, dependiendo del "move"--
										move_x11 = loadstring("return function(fx__, meta, line, x, y, s, module) return {".. fx__.move_x .."} end")( )
										move_x = math.round(move_x11( fx__, meta, line, x, y, s, module ), 2)
										move_y11 = loadstring("return function(fx__, meta, line, x, y, s, module) return {".. fx__.move_y .."} end")( )
										move_y = math.round(move_y11( fx__, meta, line, x, y, s, module ), 2)
										--variables de tiempo del movimiento--
										fx__.move_t = fx__.move_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										move_t1 = loadstring("return function(fx__, meta, line, s, module) return {".. fx__.move_t .."} end")( )
										move_t = move_t1( fx__, meta, line, s, module )
										fx.movet_i = math.round(move_t[1] or 0, 2)
										fx.movet_f = math.round(move_t[2] or fx.dur, 2)
										if #move_t > 0 then
											tags_times = ","..tostring(fx.movet_i)..","..tostring(fx.movet_f)
										else
											tags_times = ""
										end
										--posiciones finales--
										Nmove = math.max(#move_x, #move_y)
										fx.move_x1 = math.round(move_x[1] or fx.pos_x, 2)
										fx.move_y1 = math.round(move_y[1] or fx.pos_y, 2)
										fx.move_x2 = math.round(move_x[2] or fx.move_x1, 2)
										fx.move_y2 = math.round(move_y[2] or fx.move_y1, 2)
										fx.move_x3 = math.round(move_x[3] or fx.move_x2, 2)
										fx.move_y3 = math.round(move_y[3] or fx.move_y2, 2)
										fx.move_x4 = math.round(move_x[4] or fx.move_x3, 2)
										fx.move_y4 = math.round(move_y[4] or fx.move_y3, 2)
										fx.angle1 = fx.move_x3
										fx.angle2 = fx.move_x4
										fx.radius1 = math.round(move_x[5] or fx.pos_x, 2)
										fx.radius2 = math.round(move_x[6] or fx.radius1, 2)
										tb_pos = {fx.move_x1, fx.move_y1, fx.move_x2, fx.move_y2, fx.move_x3, fx.move_y3, fx.move_x4, fx.move_y4, fx.angle1, fx.angle2, fx.radius1, fx.radius2}
										fx.move_l1, fx.move_r1, fx.move_t1, fx.move_b1 = fx.move_x1 - val_width/2, fx.move_x1 + val_width/2, fx.move_y1 - val_height/2, fx.move_y1 + val_height/2
										fx.move_l2, fx.move_r2, fx.move_t2, fx.move_b2 = fx.move_x2 - val_width/2, fx.move_x2 + val_width/2, fx.move_y2 - val_height/2, fx.move_y2 + val_height/2
										fx.move_l3, fx.move_r3, fx.move_t3, fx.move_b3 = fx.move_x3 - val_width/2, fx.move_x3 + val_width/2, fx.move_y3 - val_height/2, fx.move_y3 + val_height/2
										fx.move_l4, fx.move_r4, fx.move_t4, fx.move_b4 = fx.move_x4 - val_width/2, fx.move_x4 + val_width/2, fx.move_y4 - val_height/2, fx.move_y4 + val_height/2
										fx.pos = effector.pos( Nmove, tb_pos, tags_times )
										fx_start, fx_end, fx_mid, fx_dur, fx_i, fx_n, fx_x, fx_y = fx.start_time, fx.end_time, fx.start_time + fx.dur/2, fx.dur, j, maxj, fx.move_x1, fx.move_y1
										fx_left, fx_center, fx_right, fx_width, fx_top, fx_middle, fx_bottom, fx_height = fx.move_l1, fx.move_x1, fx.move_r1, fx.move_r1 - fx.move_l1, fx.move_t1, fx.move_y1, fx.move_b1, fx.move_b1 - fx.move_t1
										if pcall(loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")) == true then
											returnfx1 = loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")( )
											returnfx = returnfx1( fx__, meta, syl, line )
										else
											returnfx = { [1] = fx__.returnfx }
										end
										Rline = 1
										if returnfx[2] and returnfx[2] == "random" then
											Rline = 2 - R(count_fx + 1)
										end
										T_line = false
										if #returnfx > 0 or returnfx[1] ~= nil then
											if returnfx[1]:match("m %-?%d+[%.%d+]* %-?%d+[%.%d+]*") then
												fx.Det = "\\p1"
												if returnfx[1]:match("\\p%d") then
													fx.Det = ""
												end
												tags_style = shape.style
											else
												fx.Det = ""
												tags_style = text.style
											end
											if (fx.Det == "\\p1" or returnfx[1]:match("\\p%d")) and fx.tag_size == "" then
												fx.tag_size = "\\fscx100\\fscy100"
											end
											if fx__.t_type ~= "Template Line [Word]"
												and fx__.t_type ~= "Template Line [Syl]"
												and fx__.t_type ~= "Template Line [Char]" then
												if fx__.language ~= "Automation Auto-4" then
													addtag1 = loadstring("return function(fx__, meta, line, x, y, module) return {".. tag.HTML_to_ass(fx__.addtag) .."} end")( )
													addtag = addtag1( fx__, meta, line, x, y, module )
													fx.add_tags = tag.do_tag( table.op(addtag, "concat") )
												else
													fx.add_tags = tag.to_Auto4( tag.HTML_to_ass(fx__.addtag) )
												end
											else
												returnfx[1] = tag.to_temp( fx__.addtag )
												fx.add_tags = ""
												T_line = true
											end
											if fxgroup == true then
												if fx__.modify == false and fx__.namefx ~= "raw" then
													if T_line == false then
														Ltags_style = tags_style
													else
														Ltags_style = ""
													end
													l.text = fx.tm(format("{%s %s: %s [line origin: %s - line fx: %s] %s%s%s%s%s%s}%s", script_name, script_version, fx__.effect:gsub("%S+[%-%S+]*%[fx%]: ", ""), ii, count_fx + 1, fx.align, fx.pos, Ltags_style, fx.tag_size, fx.add_tags, fx.Det, returnfx[1]))
													l.effect = "Effector [Fx]"
													l.layer = fx.layer
													l.actor = actor_fx
													subs.insert( #subs + Rline, l )
													count_fx = count_fx + 1
												elseif fx__.modify == false and fx__.namefx == "raw" then
													l.text = fx.tm(returnfx[1])
													subs.insert( #subs + Rline, l )
													count_fx = count_fx + 1
												else
													lines_comment = false
													line.start_time = fx.start_time
													line.end_time = fx.end_time
													line.text = fx.tm(format("{%s}%s", fx.add_tags, returnfx[1]))
												end
											end
										end
										j = j + 1
										aegisub.progress.task(F("Lines: [%d/%d]  Progress: [%s%%]  Lines Generated: %d", count_ln, #idx_line, math.round(100*count_ln/#idx_line, 2), count_fx))
										aegisub.progress.set(100*line.i/line.n)
									end
									J = J + 1
								end
							end
						end

						if fx__.t_type == "Char" then
							if syl.text ~= noblank1 and syl.text ~= noblank2 then
								-----------------------------------------------
								sylchar = { }
								sylchar.i = 0
								for cfx in unicode.chars(syl.text_stripped) do
									char.text = cfx
									char.text_stripped = cfx
									width, height, descent, extlead = aegisub.text_extents(line.styleref, char.text)
									char.width = width
									char.height = height
									char.top = l.top
									char.middle = l.middle
									char.bottom = l.bottom
									char.left = left
									char.right = left + char.width
									char.center = left + char.width/2
									sylchar.i = sylchar.i + ((char.text == " ") and 0 or 1)
									sylchar.n = unicode.len(syl.text_stripped:gsub(" ", ""))
									char.start_time = syl.start_time + syl.duration*(sylchar.i - 1)/sylchar.n
									char.end_time = syl.start_time + syl.duration*sylchar.i/sylchar.n
									char.duration = char.end_time - char.start_time
									char.dur = char.duration
									char.mid_time = char.start_time + char.dur/2
									char.widthmax = math.max(unpack(mmwth[ii].ch))
									char.widthmin = math.min(unpack(mmwth[ii].ch))
									char.durmax = math.max(unpack(mmdur[ii].ch))
									char.durmin = math.min(unpack(mmdur[ii].ch))
									-----------------------------------------------
									val_width, val_height, val_text = char.width, char.height, char.text
									val_center, val_middle, val_left, val_right = char.center, char.middle, char.left, char.right
									val_top, val_bottom, val_dur = char.top, char.bottom, char.duration
									val_start, val_end, val_mid  = char.start_time, char.end_time, char.start_time + char.duration/2
									val_i, val_n = char.i, char.n
									shape.trapeze1t = format("m 0 0 l 0 %d l %d %d l %d 0 ", char.height, char.width, char.height, char.width + char.height)
									shape.trapeze1b = format("m 0 0 l 0 %d l %d %d l %d 0 ", char.height, char.width + char.height, char.height, char.width)
									-----------------------------------------------
									W_ = aegisub.word(line.text, line.dur, aegisub.word2c( ))
									-----------------------------------------------
									word_start, word_end, word_mid, word_dur, word_i, word_n, word_left, word_center, word_right, word_bottom, word_middle, word_top, word_width, word_height = word.start_time, word.end_time, word.mid_time, word.dur, word.i, word.n, word.left, word.center, word.right, word.bottom, word.middle, word.top, word.width, word.height
									syl_start,  syl_end,  syl_mid,  syl_dur,  syl_i,  syl_n,  syl_left,  syl_center,  syl_right,  syl_bottom,  syl_middle,  syl_top,  syl_width,  syl_height  = syl.start_time, syl.end_time, syl.mid_time, syl.dur, syl.i, syl.n, syl.left, syl.center, syl.right, syl.bottom, syl.middle, syl.top, syl.width, syl.height
									furi_start, furi_end, furi_mid, furi_dur, furi_i, furi_n, furi_left, furi_center, furi_right, furi_bottom, furi_middle, furi_top, furi_width, furi_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
									hira_start, hira_end, hira_mid, hira_dur, hira_i, hira_n, hira_left, hira_center, hira_right, hira_bottom, hira_middle, hira_top, hira_width, hira_height = hira.start_time, hira.end_time, hira.mid_time, hira.dur, hira.i, hira.n, hira.left, hira.center, hira.right, hira.bottom, hira.middle, hira.top, hira.width, hira.height
									kata_start, kata_end, kata_mid, kata_dur, kata_i, kata_n, kata_left, kata_center, kata_right, kata_bottom, kata_middle, kata_top, kata_width, kata_height = kata.start_time, kata.end_time, kata.mid_time, kata.dur, kata.i, kata.n, kata.left, kata.center, kata.right, kata.bottom, kata.middle, kata.top, kata.width, kata.height
									roma_start, roma_end, roma_mid, roma_dur, roma_i, roma_n, roma_left, roma_center, roma_right, roma_bottom, roma_middle, roma_top, roma_width, roma_height = roma.start_time, roma.end_time, roma.mid_time, roma.dur, roma.i, roma.n, roma.left, roma.center, roma.right, roma.bottom, roma.middle, roma.top, roma.width, roma.height
									char_start, char_end, char_mid, char_dur, char_i, char_n, char_left, char_center, char_right, char_bottom, char_middle, char_top, char_width, char_height = char.start_time, char.end_time, char.mid_time, char.dur, char.i, char.n, char.left, char.center, char.right, char.bottom, char.middle, char.top, char.width, char.height
									-----------------------------------------------
									wordchar = { }
									wordchar.i, wordchar.n = aegisub.wordci( char.i )
									-----------------------------------------------
									fx.replay_fx, J = 1, 1
									maxJ = fx.replay_fx
									while J <= fx.replay_fx do
										j = 1
										if fx.replay_fx == 1 then
											moduler = 0
										else
											moduler = (J - 1)/(maxJ - 1)
										end
										module = 0
										module1 = module
										module2 = module1
										fxgroup = true
										-----------------------------------------------
										effector.default_val( )
										-----------------------------------------------
										if pcall(loadstring("return function(fx__, meta, syl, line, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")) == true then
											variable_ = loadstring("return function(fx__, meta, syl, line, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")( )
											var_KEfx_ = variable_( fx__, meta, syl, line, x, y )
										end
										variable_ = loadstring("return function(fx__, meta, syl, line, x, y) return {".. tag.HTML_to_ass(fx__.variable) .."} end")( )
										if line.i == 1 and syl.i == 1 and sylchar.i == 1 and J == 1 then
											var.once = remember("v_once", variable_( fx__, meta, syl, line, x, y ))
										else
											var.once = recall.v_once
										end
										if syl.i  == 1 and sylchar.i == 1 and J == 1 then
											var.line = variable_( fx__, meta, syl, line, x, y )
										end
										if wordchar.i == 1 and J == 1 then
											var.word = variable_( fx__, meta, syl, line, x, y )
										end
										if sylchar.i == 1 and J == 1 then
											var.syl = variable_( fx__, meta, syl, line, x, y )
										end
										if J == 1 then
											var.rep = variable_( fx__, meta, syl, line, x, y )
										end
										var.char = variable_( fx__, meta, syl, line, x, y )
										var.furi = var.char
										var.loop = variable_( fx__, meta, syl, line, x, y )
										text.char_size( )
										-----------------------------------------------
										maxloop1 = loadstring("return function(fx__, meta, syl, line, x, y) return {".. fx__.loops .."} end")( )
										maxloop_fx = maxloop1( fx__, meta, syl, line, x, y )
										loop_h = ceil((maxloop_fx[1] or 1)*(char.width + 2*L.outline)/(line.height + 2*L.outline))
										maxloop_fx = maxloop1( fx__, meta, syl, line, x, y )
										fx.loop_v = maxloop_fx[1] or 1
										fx.loop_h = maxloop_fx[2] or 1
										fx.loop_3 = maxloop_fx[3] or 1
										fx.maxloop_fx = fx.loop_v*fx.loop_h*fx.loop_3
										maxj = fx.maxloop_fx
										-----------------------------------------------
										while j <= fx.maxloop_fx do
											ci = 0
											var.loop = variable_( fx__, meta, syl, line, x, y )
											--variables de modulo--
											if fx.maxloop_fx == 1 then
												module = 0
											else
												module = (j - 1)/(maxj - 1)
											end
											if char.n == 1 then
												module1 = module
											else
												module1 = (char.i + module - 1)/(char.n + module - 1)
											end
											if line.n == 1 then
												module2 = module1
											else
												module2 = (line.i + module1 - 1)/(line.n + module1 - 1)
											end
											--variables de tiempo--
											fx__.start_t = fx__.start_t:gsub("(%d+%:%d+%:%d+%.%d+)",
												function( time_HMS )
													return tostring( HMS_to_ms( time_HMS ) )
												end
											)
											fx__.end_t = fx__.end_t:gsub("(%d+%:%d+%:%d+%.%d+)",
												function( time_HMS )
													return tostring( HMS_to_ms( time_HMS ) )
												end
											)
											start_t1 = loadstring("return function(fx__, meta, syl, line, module) return {".. fx__.start_t .."} end")( )
											start_t	= start_t1( fx__, meta, syl, line, module )
											if #start_t > 0 then
												fx.start_time = start_t[1]
											else
												fx.start_time = line.start_time
											end
											l.start_time = fx.start_time
											end_t1 = loadstring("return function(fx__, meta, syl, line, module) return {".. fx__.end_t .."} end")( )
											end_t = end_t1( fx__, meta, syl, line, module )
											if #end_t > 0 then
												fx.end_time = end_t[1]
											else
												fx.end_time = line.end_time
											end
											l.end_time = fx.end_time
											fx.dur = fx.end_time - fx.start_time
											function retime( mode, add_start, add_end )
												add_start = HMS_to_ms( add_start ) or 0
												add_end = HMS_to_ms( add_end ) or 0
												if mode == "line" then
													l.start_time = line.start_time + add_start
													l.end_time = line.end_time + add_end
												elseif mode == "preline" then
													l.start_time = line.start_time + add_start
													l.end_time = line.start_time + add_end
												elseif mode == "postline" then
													l.start_time = line.end_time + add_start
													l.end_time = line.end_time + add_end
												elseif mode == "word" then
													l.start_time = line.start_time + word.start_time + add_start
													l.end_time = line.start_time + word.end_time + add_end
												elseif mode == "preword" then
													l.start_time = line.start_time + word.start_time + add_start
													l.end_time = line.start_time + word.start_time + add_end
												elseif mode == "postword" then
													l.start_time = line.start_time + word.end_time + add_start
													l.end_time = line.start_time + word.start_time + add_end
												elseif mode == "syl" then
													l.start_time = line.start_time + syl.start_time + add_start
													l.end_time = line.start_time + syl.end_time + add_end
												elseif mode == "presyl" then
													l.start_time = line.start_time + syl.start_time + add_start
													l.end_time = line.start_time + syl.start_time + add_end
												elseif mode == "postsyl" then
													l.start_time = line.start_time + syl.end_time + add_start
													l.end_time = line.start_time + syl.end_time + add_end
												elseif mode == "char" then
													l.start_time = line.start_time + char.start_time + add_start
													l.end_time = line.start_time + char.end_time + add_end
												elseif mode == "prechar" then
													l.start_time = line.start_time + char.start_time + add_start
													l.end_time = line.start_time + char.start_time + add_end
												elseif mode == "postchar" then
													l.start_time = line.start_time + char.end_time + add_start
													l.end_time = line.start_time + char.start_time + add_end
												elseif mode == "start2word"	then
													l.start_time = line.start_time + add_start
													l.end_time = line.start_time + word.start_time + add_end
												elseif mode == "word2end" then
													l.start_time = line.start_time + word.end_time + add_start
													l.end_time = line.end_time + add_end
												elseif mode == "start2syl" then
													l.start_time = line.start_time + add_start
													l.end_time = line.start_time + syl.start_time + add_end
												elseif mode == "syl2end" then
													l.start_time = line.start_time + syl.end_time + add_start
													l.end_time = line.end_time + add_end
												elseif mode == "start2char"	then
													l.start_time = line.start_time + add_start
													l.end_time = line.start_time + char.start_time + add_end
												elseif mode == "char2end" then
													l.start_time = line.start_time + char.end_time + add_start
													l.end_time = line.end_time + add_end
												elseif mode == "linepct" then
													l.start_time = line.start_time + add_start*line.duration/100
													l.end_time = line.start_time + add_end*line.duration/100
												elseif mode == "wordpct" then
													l.start_time = line.start_time + word.start_time + add_start*word.duration/100
													l.end_time = line.start_time + word.start_time + add_end*word.duration/100
												elseif mode == "sylpct" then
													l.start_time = line.start_time + syl.start_time + add_start*syl.duration/100
													l.end_time = line.start_time + syl.start_time + add_end*syl.duration/100
												elseif mode == "charpct" then
													l.start_time = line.start_time + char.start_time + add_start*char.duration/100
													l.end_time = line.start_time + char.start_time + add_end*char.duration/100
												elseif mode == "set" or mode == "abs" then
													l.start_time = add_start
													l.end_time = add_end
												elseif mode == "fxpretime" then
													l.start_time = fx.start_time + add_start
													l.end_time = fx.start_time + add_end
												elseif mode == "fxtime" then
													l.start_time = fx.start_time + add_start
													l.end_time = fx.end_time + add_end
												elseif mode == "fxposttime"	then
													l.start_time = fx.end_time + add_start
													l.end_time = fx.end_time + add_end
												elseif mode == "fxpct" then
													l.start_time = fx.start_time + add_start*fx.dur/100
													l.end_time = fx.start_time + add_end*fx.dur/100
												end
												fx.start_time, fx.end_time = l.start_time, l.end_time
												fx.dur = fx.end_time - fx.start_time
												return ""
											end
											---------------------------------------------------
											without = { }
											ini = line.start_time - fx.start_time
											without.char = format("\\t(%s,%s,\\1a&HFF&\\3a&HFF&\\4a&HFF&)\\t(%s,%s,\\1a%s\\3a%s\\4a%s)", ini + char.start_time, ini + char.start_time + 1, ini + char.end_time, ini + char.end_time + 1, text.alpha1, text.alpha3, text.alpha4)
											without.syl = format("\\t(%s,%s,\\1a&HFF&\\3a&HFF&\\4a&HFF&)\\t(%s,%s,\\1a%s\\3a%s\\4a%s)", ini + syl.start_time, ini + syl.start_time + 1, ini + syl.end_time, ini + syl.end_time + 1, text.alpha1, text.alpha3, text.alpha4)
											syl.syl_start = ini + syl.start_time
											syl.syl_end = syl.syl_start + syl.dur
											char.syl_start = ini + char.start_time
											char.syl_end = char.syl_start + char.dur
											--variables de punto de referencia--
											center_x1 = loadstring("return function(fx__, meta, syl, line, x, y, module) return {".. fx__.center_x .."} end")( )
											center_x = center_x1( fx__, meta, syl, line, x, y, module )
											if #center_x > 0 then
												fx.center_x = center_x[1]
											else
												fx.center_x = val_center
											end
											center_y1 = loadstring("return function(fx__, meta, syl, line, x, y, module) return {".. fx__.center_y .."} end")( )
											center_y = center_y1( fx__, meta, syl, line, x, y, module )
											if #center_y > 0 then
												fx.center_y = center_y[1]
											else
												fx.center_y = val_middle
											end
											--variables de escalas de funciones paramétricas-- 
											if j == 1 then
												scale_x1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.scale_x .."} end")( )
												scale_x	= scale_x1( fx__, meta, syl, line )
												if #scale_x > 0 then
													fx.scale_x = scale_x[1]
												else
													fx.scale_x = 1
												end
												if fx.scale_x <= 0 then
													fx.scale_x = 0.1
												end
												scale_y1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.scale_y .."} end")( )
												scale_y	= scale_y1( fx__, meta, syl, line )
												if #scale_y > 0 then
													fx.scale_y = scale_y[1]
												else
													fx.scale_y = 1
												end
												if fx.scale_y <= 0 then
													fx.scale_y = 0.1
												end
											end
											offset_maxspace = scale_x[2] or 0
											offset_h = center_y[2] or 0.9
											--variables de dominio de funciones--
											if j == 1 then
												s_i1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.s_i .."} end")( )
												s_i = s_i1( fx__, meta, syl, line )
												if #s_i > 0 then
													fx.domain_i = s_i[1]
												else
													fx.domain_i = 0
												end
												s_f1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.s_f .."} end")( )
												s_f = s_f1( fx__, meta, syl, line )
												if #s_f > 0 then
													fx.domain_f = s_f[1]
												else
													fx.domain_f = 1
												end
											end
											local s = fx.domain_i + module*(fx.domain_f - fx.domain_i)
											--variables de funciones paramétricas--
											fun_x1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.fun_x .."} end")( )
											fun_x = fun_x1( fx__, meta, syl, line, s )
											if #fun_x > 0 then
												fx.fun_x = fun_x[1]*fx.scale_x
											else
												fx.fun_x = 0
											end
											fun_y1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.fun_y .."} end")( )
											fun_y = fun_y1( fx__, meta, syl, line, s )
											if #fun_y > 0 then
												fx.fun_y = fun_y[1]*fx.scale_y
											else
												fx.fun_y = 0
											end
											--definir líneas de texto, verticales u horizontales--
											fx.pos_x, fx.pos_y = effector.knj( fx__.v_kanji )
											fx.off_x, fx.off_y = effector.modify_pos( )
											--variables de posiciones--
											fx.pos_x = fx.pos_x + fx.fun_x - fx.off_x
											fx.pos_y = fx.pos_y + fx.fun_y - fx.off_y
											fx.pos_l = fx.pos_x - char.width/2
											fx.pos_r = fx.pos_x + char.width/2
											fx.pos_t = fx.pos_y - char.height/2
											fx.pos_b = fx.pos_y + char.height/2
											x, y = fx.pos_x, fx.pos_y
											--variables de tamaño--
											if fx__.size ~= nil and fx__.size ~= "" then
												size1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.size .."} end")( )
												size = size1( fx__, meta, syl, line, s )
												if #size == 1 then
													fx.sizex = math.round(size[1], 2)
													fx.sizey = fx.sizex
												elseif #size == 2 then
													fx.sizex = math.round(size[1], 2)
													fx.sizey = math.round(size[2], 2)
												end
												fx.tag_size = format("\\fscx%s\\fscy%s", fx.sizex, fx.sizey)
											else
												fx.sizex = L.scale_x
												fx.sizey = L.scale_y
												fx.tag_size = ""
											end
											--variables de alineación y de capa (layer)--
											align1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.align .."} end")( )
											align = align1( fx__, meta, syl, line, s, module )
											if #align > 0 then
												fx.align = "\\an"..align[1]
											else
												fx.align = ""
											end
											layer1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.layer .."} end")( )
											layer = layer1( fx__, meta, syl, line, s, module )
											fx.layer = layer[1] or l_layer
											--variables de posiciones, dependiendo del "move"--
											move_x11 = loadstring("return function(fx__, meta, syl, line, x, y, s, module) return {".. fx__.move_x .."} end")( )
											move_x	= math.round(move_x11( fx__, meta, syl, line, x, y, s, module ), 2)
											move_y11 = loadstring("return function(fx__, meta, syl, line, x, y, s, module) return {".. fx__.move_y .."} end")( )
											move_y	= math.round(move_y11( fx__, meta, syl, line, x, y, s, module ), 2)
											--variables de tiempo del movimiento--
											fx__.move_t = fx__.move_t:gsub("(%d+%:%d+%:%d+%.%d+)",
												function( time_HMS )
													return tostring( HMS_to_ms( time_HMS ) )
												end
											)
											move_t1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.move_t .."} end")( ) 		move_t	= move_t1(fx__, meta, syl, line, s, module)
											fx.movet_i = math.round(move_t[1] or 0, 2)
											fx.movet_f = math.round(move_t[2] or fx.dur, 2)
											if #move_t > 0 then
												tags_times = ","..tostring(fx.movet_i)..","..tostring(fx.movet_f)
											else
												tags_times = ""
											end
											--posiciones finales--
											Nmove = math.max(#move_x, #move_y)
											fx.move_x1 = math.round(move_x[1] or fx.pos_x, 2)
											fx.move_y1 = math.round(move_y[1] or fx.pos_y, 2)
											fx.move_x2 = math.round(move_x[2] or fx.move_x1, 2)
											fx.move_y2 = math.round(move_y[2] or fx.move_y1, 2)
											fx.move_x3 = math.round(move_x[3] or fx.move_x2, 2)
											fx.move_y3 = math.round(move_y[3] or fx.move_y2, 2)
											fx.move_x4 = math.round(move_x[4] or fx.move_x3, 2)
											fx.move_y4 = math.round(move_y[4] or fx.move_y3, 2)
											fx.angle1 = fx.move_x3
											fx.angle2 = fx.move_x4
											fx.radius1 = math.round(move_x[5] or fx.pos_x, 2)
											fx.radius2 = math.round(move_x[6] or fx.radius1, 2)
											tb_pos = {fx.move_x1, fx.move_y1, fx.move_x2, fx.move_y2, fx.move_x3, fx.move_y3, fx.move_x4, fx.move_y4, fx.angle1, fx.angle2, fx.radius1, fx.radius2}
											fx.move_l1, fx.move_r1, fx.move_t1, fx.move_b1 = fx.move_x1 - val_width/2, fx.move_x1 + val_width/2, fx.move_y1 - val_height/2, fx.move_y1 + val_height/2
											fx.move_l2, fx.move_r2, fx.move_t2, fx.move_b2 = fx.move_x2 - val_width/2, fx.move_x2 + val_width/2, fx.move_y2 - val_height/2, fx.move_y2 + val_height/2
											fx.move_l3, fx.move_r3, fx.move_t3, fx.move_b3 = fx.move_x3 - val_width/2, fx.move_x3 + val_width/2, fx.move_y3 - val_height/2, fx.move_y3 + val_height/2
											fx.move_l4, fx.move_r4, fx.move_t4, fx.move_b4 = fx.move_x4 - val_width/2, fx.move_x4 + val_width/2, fx.move_y4 - val_height/2, fx.move_y4 + val_height/2
											fx.pos = effector.pos( Nmove, tb_pos, tags_times )
											fx_start, fx_end, fx_mid, fx_dur, fx_i, fx_n, fx_x, fx_y = fx.start_time, fx.end_time, fx.start_time + fx.dur/2, fx.dur, j, maxj, fx.move_x1, fx.move_y1
											fx_left, fx_center, fx_right, fx_width, fx_top, fx_middle, fx_bottom, fx_height = fx.move_l1, fx.move_x1, fx.move_r1, fx.move_r1 - fx.move_l1, fx.move_t1, fx.move_y1, fx.move_b1, fx.move_b1 - fx.move_t1
											if pcall(loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")) == true then
												returnfx1 = loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")( )
												returnfx = returnfx1( fx__, meta, syl, line )
											else
												returnfx = { [1] = fx__.returnfx }
											end
											Rline = 1
											if returnfx[2] and returnfx[2] == "random" then
												Rline = 2 - R(count_fx + 1)
											end
											if fx__.noblank == true and (returnfx[1] == "" or returnfx[1] == " ") then
												returnfx[1] = nil
											end
											if #returnfx > 0 or returnfx[1] ~= nil then
												if returnfx[1]:match("m %-?%d+[%.%d+]* %-?%d+[%.%d+]*") then
													fx.Det = "\\p1"
													if returnfx[1]:match("\\p%d") then
														fx.Det = ""
													end
													tags_style = shape.style
												else
													fx.Det = ""
													tags_style = text.style
												end
												if (fx.Det == "\\p1" or returnfx[1]:match("\\p%d")) and fx.tag_size == "" then
													fx.tag_size = "\\fscx100\\fscy100"
												end
												if fx__.language ~= "Automation Auto-4" then
													addtag1 = loadstring("return function(fx__, meta, line, x, y, module) return {".. tag.HTML_to_ass(fx__.addtag) .."} end")( )
													addtag = addtag1( fx__, meta, line, x, y, module )
													fx.add_tags = tag.do_tag( table.op(addtag, "concat") )
												else
													fx.add_tags = tag.to_Auto4( tag.HTML_to_ass(fx__.addtag) )
												end
												if fxgroup == true then
													if fx__.modify == false and fx__.namefx ~= "raw" then
														l.text = fx.tm(format("{%s %s: %s [line origin: %s - line fx: %s] %s%s%s%s%s%s}%s", script_name, script_version, fx__.effect:gsub("%S+[%-%S+]*%[fx%]: ", ""), ii, count_fx + 1, fx.align, fx.pos, tags_style, fx.tag_size, fx.add_tags, fx.Det, returnfx[1]))
														l.effect = "Effector [Fx]"
														l.layer = fx.layer
														l.actor = actor_fx
														subs.insert( #subs + Rline, l )
														count_fx = count_fx + 1
													elseif fx__.modify == false and fx__.namefx == "raw" then
														l.text = fx.tm(returnfx[1])
														subs.insert( #subs + Rline, l )
														count_fx = count_fx + 1
													else
														lines_comment = false
														line.start_time = fx.start_time
														line.end_time = fx.end_time
														line.text = fx.tm(format("{%s}%s", fx.add_tags, returnfx[1]))
													end
												end
												ci = 1
											end
											j = j + 1
											aegisub.progress.task(F("Lines: [%d/%d]  Progress: [%s%%]  Lines Generated: %d", count_ln, #idx_line, math.round(100*count_ln/#idx_line, 2), count_fx))
											aegisub.progress.set(100*line.i/line.n)
										end
										J = J + 1
									end
									left = left + width
									char.i = char.i + ci
								end
							end
						end
						
						if fx__.t_type == "Furi" then
							if furi.text ~= noblank1 and furi.text ~= noblank2 then
								-----------------------------------------------
								function maxmin( mode )
									local mwidth, mduration = { }, { }
									for i = 1, furi.n do
										mwidth[i] = line.furi[i].width + line.furi[i].postspacewidth + line.furi[i].prespacewidth
										mduration[i] = line.furi[i].duration
									end
									if mode == "maxw" then
										return math.max(unpack(mwidth))
									end
									if mode == "minw" then
										return math.min(unpack(mwidth))
									end
									if mode == "maxd" then
										return math.max(unpack(mduration))
									end
									if mode == "mind" then
										return math.min(unpack(mduration))
									end
								end
								furi.center = furi.center + l.left
								furi.middle = syl.middle - l.height + l.descent/2
								furi.i = i
								furi.n = line.furi.n
								furi.left = furi.center - furi.width/2
								furi.right = furi.center + furi.width/2
								furi.top = furi.middle - furi.height/2
								furi.bottom = furi.middle + furi.height/2
								furi.dur = furi.duration
								furi.mid_time = furi.start_time + furi.dur/2
								furi.widthmax = maxmin("maxw")
								furi.widthmin = maxmin("minw")
								furi.durmax = maxmin("maxd")
								furi.durmin = maxmin("mind")
								----------------------------------------------
								val_width, val_height, val_text = furi.width, furi.height, furi.text
								val_center, val_middle, val_left, val_right = furi.center, furi.middle, furi.left, furi.right
								val_top, val_bottom, val_dur = furi.top, furi.bottom, furi.duration
								val_start, val_end, val_mid  = furi.start_time, furi.end_time, furi.start_time + furi.duration/2
								val_i, val_n = furi.i, furi.n
								shape.trapeze1t = format("m 0 0 l 0 %d l %d %d l %d 0 ", furi.height, furi.width, furi.height, furi.width + furi.height)
								shape.trapeze1b = format("m 0 0 l 0 %d l %d %d l %d 0 ", furi.height, furi.width + furi.height, furi.height, furi.width)
								----------------------------------------------
								word_start, word_end, word_mid, word_dur, word_i, word_n, word_left, word_center, word_right, word_bottom, word_middle, word_top, word_width, word_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								syl_start,  syl_end,  syl_mid,  syl_dur,  syl_i,  syl_n,  syl_left,  syl_center,  syl_right,  syl_bottom,  syl_middle,  syl_top,  syl_width,  syl_height  = syl.start_time, syl.end_time, syl.mid_time, syl.dur, syl.i, syl.n, syl.left, syl.center, syl.right, syl.bottom, syl.middle, syl.top, syl.width, syl.height
								furi_start, furi_end, furi_mid, furi_dur, furi_i, furi_n, furi_left, furi_center, furi_right, furi_bottom, furi_middle, furi_top, furi_width, furi_height = furi.start_time, furi.end_time, furi.mid_time, furi.dur, furi.i, furi.n, furi.left, furi.center, furi.right, furi.bottom, furi.middle, furi.top, furi.width, furi.height
								hira_start, hira_end, hira_mid, hira_dur, hira_i, hira_n, hira_left, hira_center, hira_right, hira_bottom, hira_middle, hira_top, hira_width, hira_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								kata_start, kata_end, kata_mid, kata_dur, kata_i, kata_n, kata_left, kata_center, kata_right, kata_bottom, kata_middle, kata_top, kata_width, kata_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								roma_start, roma_end, roma_mid, roma_dur, roma_i, roma_n, roma_left, roma_center, roma_right, roma_bottom, roma_middle, roma_top, roma_width, roma_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								char_start, char_end, char_mid, char_dur, char_i, char_n, char_left, char_center, char_right, char_bottom, char_middle, char_top, char_width, char_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								----------------------------------------------
								fx.replay_fx, J = 1, 1
								maxJ = fx.replay_fx
								while J <= fx.replay_fx do
									j = 1
									if fx.replay_fx == 1 then
										moduler = 0
									else
										moduler = (J - 1)/(maxJ - 1)
									end
									module = 0
									module1 = module
									module2 = module1
									fxgroup = true
									-----------------------------------------------
									effector.default_val( )
									-----------------------------------------------
									if pcall(loadstring("return function(fx__, meta, syl, line, furi, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")) == true then
										variable_ = loadstring("return function(fx__, meta, syl, line, furi, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")( )
										var_KEfx_ = variable_( fx__, meta, syl, line, furi, x, y )
									end
									variable_ = loadstring("return function(fx__, meta, syl, line, furi, x, y) return {".. tag.HTML_to_ass(fx__.variable) .."} end")( )
									if line.i == 1 and furi.i == 1 and J == 1 then
										var.once = remember("v_once", variable_( fx__, meta, syl, line, furi, x, y ))
									else
										var.once = recall.v_once
									end
									if furi.i == 1 and J == 1 then
										var.line = variable_( fx__, meta, syl, line, furi, x, y )
									end
									if J == 1 then
										var.rep  = variable_( fx__, meta, syl, line, furi, x, y )
									end
									var.furi = variable_( fx__, meta, syl, line, furi, x, y )
									var.word, var.syl, var.char = var.furi, var.furi, var.furi
									var.loop = variable_( fx__, meta, syl, line, furi, x, y )
									-----------------------------------------------
									maxloop1 = loadstring("return function(fx__, meta, syl, line, furi, x, y) return {".. fx__.loops .."} end")( )
									maxloop_fx = maxloop1( fx__, meta, syl, line, furi, x, y )
									loop_h = ceil((maxloop_fx[1] or 1)*(furi.width + 2*L.outline)/(furi.height + 2*L.outline))
									maxloop_fx = maxloop1( fx__, meta, syl, line, furi, x, y )
									fx.loop_v = maxloop_fx[1] or 1
									fx.loop_h = maxloop_fx[2] or 1
									fx.loop_3 = maxloop_fx[3] or 1
									fx.maxloop_fx = fx.loop_v*fx.loop_h*fx.loop_3
									maxj = fx.maxloop_fx
									-----------------------------------------------
									while j <= fx.maxloop_fx do
										var.loop = variable_( fx__, meta, syl, line, furi, x, y )
										--variables de modulo--
										if fx.maxloop_fx == 1 then
											module = 0
										else
											module = (j - 1)/(maxj - 1)
										end
										if furi.n == 1 then
											module1 = module
										else
											module1 = (furi.i + module - 1)/(furi.n + module - 1)
										end
										if line.n == 1 then
											module2 = module1
										else
											module2 = (line.i + module1 - 1)/(line.n + module1 - 1)
										end
										--variables de tiempo--
										fx__.start_t = fx__.start_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										fx__.end_t = fx__.end_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										start_t1 = loadstring("return function(fx__, meta, syl, line, furi, module) return {".. fx__.start_t .."} end")( )
										start_t	= start_t1( fx__, meta, syl, line, furi, module )
										if #start_t > 0 then
											fx.start_time = start_t[1]
										else
											fx.start_time = line.start_time
										end
										l.start_time = fx.start_time
										end_t1 = loadstring("return function(fx__, meta, syl, line, furi, module) return {".. fx__.end_t .."} end")( )
										end_t = end_t1( fx__, meta, syl, line, furi, module )
										if #end_t > 0 then
											fx.end_time = end_t[1]
										else
											fx.end_time = line.end_time
										end
										l.end_time = fx.end_time
										fx.dur = fx.end_time - fx.start_time
										function retime( mode, add_start, add_end )
											add_start = HMS_to_ms( add_start ) or 0
											add_end = HMS_to_ms( add_end ) or 0
											if mode == "line" then
												l.start_time = line.start_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "preline" then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + add_end
											elseif mode == "postline" then
												l.start_time = line.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "syl" then
												l.start_time = line.start_time + syl.start_time + add_start
												l.end_time = line.start_time + syl.end_time + add_end
											elseif mode == "presyl" then
												l.start_time = line.start_time + syl.start_time + add_start
												l.end_time = line.start_time + syl.start_time + add_end
											elseif mode == "postsyl" then
												l.start_time = line.start_time + syl.end_time + add_start
												l.end_time = line.start_time + syl.end_time + add_end
											elseif mode == "furi" then
												l.start_time = line.start_time + furi.start_time + add_start
												l.end_time = line.start_time + furi.end_time + add_end
											elseif mode == "prefuri" then
												l.start_time = line.start_time + furi.start_time + add_start
												l.end_time = line.start_time + furi.start_time + add_end
											elseif mode == "postfuri" then
												l.start_time = line.start_time + furi.end_time + add_start
												l.end_time = line.start_time + furi.end_time + add_end
											elseif mode == "start2syl" then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + syl.start_time + add_end
											elseif mode == "syl2end" then
												l.start_time = line.start_time + syl.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "start2furi"	then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + furi.start_time + add_end
											elseif mode == "furi2end" then
												l.start_time = line.start_time + furi.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "linepct" then
												l.start_time = line.start_time + add_start*line.duration/100
												l.end_time = line.start_time + add_end*line.duration/100
											elseif mode == "sylpct" then
												l.start_time = line.start_time + syl.start_time + add_start*syl.duration/100
												l.end_time = line.start_time + syl.start_time + add_end*syl.duration/100
											elseif mode == "furipct" then
												l.start_time = line.start_time + furi.start_time + add_start*furi.duration/100
												l.end_time = line.start_time + furi.start_time + add_end*furi.duration/100
											elseif mode == "set" or mode == "abs" then
												l.start_time = add_start
												l.end_time = add_end
											elseif mode == "fxpretime" then
												l.start_time = fx.start_time + add_start
												l.end_time = fx.start_time + add_end
											elseif mode == "fxtime" then
												l.start_time = fx.start_time + add_start
												l.end_time = fx.end_time + add_end
											elseif mode == "fxposttime"	then
												l.start_time = fx.end_time + add_start
												l.end_time = fx.end_time + add_end
											elseif mode == "fxpct" then
												l.start_time = fx.start_time + add_start*fx.dur/100
												l.end_time = fx.start_time + add_end*fx.dur/100
											end
											fx.start_time, fx.end_time = l.start_time, l.end_time
											fx.dur = fx.end_time - fx.start_time
											return ""
										end
										---------------------------------------------------
										without = { }
										ini = line.start_time - fx.start_time
										without.furi = format("\\t(%s,%s,\\1va%s\\3va%s\\4va%s)\\t(%s,%s,\\1va%s\\3va%s\\4va%s)", ini + furi.start_time, ini + furi.start_time + 1, alpha.va('&HFF&'), alpha.va('&HFF&'), alpha.va('&HFF&'), ini + furi.end_time, ini + furi.end_time + 1, text.alpha1, text.alpha3, text.alpha4)
										furi.syl_start = ini + furi.start_time
										furi.syl_end = furi.syl_start + furi.dur
										--variables de punto de referencia--
										center_x1 = loadstring("return function(fx__, meta, syl, line, furi, x, y, module) return {".. fx__.center_x .."} end")( )
										center_x = center_x1( fx__, meta, syl, line, furi, x, y, module )
										if #center_x > 0 then
											fx.center_x = center_x[1]
										else
											fx.center_x = val_center
										end
										center_y1 = loadstring("return function(fx__, meta, syl, line, furi, x, y, module) return {".. fx__.center_y .."} end")( )
										center_y = center_y1( fx__, meta, syl, line, furi, x, y, module )
										if #center_y > 0 then
											fx.center_y = center_y[1]
										else
											fx.center_y = val_middle
										end
										--variables de escalas de funciones paramétricas-- 
										if j == 1 then
											scale_x1 = loadstring("return function(fx__, meta, syl, line, furi) return {".. fx__.scale_x .."} end")( )
											scale_x	= scale_x1( fx__, meta, syl, line, furi )
											if #scale_x > 0 then
												fx.scale_x = scale_x[1]
											else
												fx.scale_x = 1
											end
											if fx.scale_x <= 0 then
												fx.scale_x = 0.1
											end
											scale_y1 = loadstring("return function(fx__, meta, syl, line, furi) return {".. fx__.scale_y .."} end")( )
											scale_y	= scale_y1( fx__, meta, syl, line, furi )
											if #scale_y > 0 then
												fx.scale_y = scale_y[1]
											else
												fx.scale_y = 1
											end
											if fx.scale_y <= 0 then
												fx.scale_y = 0.1
											end
										end
										offset_maxspace = scale_x[2] or 0
										--variables de dominio de funciones--
										if j == 1 then
											s_i1 = loadstring("return function(fx__, meta, syl, line, furi) return {".. fx__.s_i .."} end")( )
											s_i = s_i1( fx__, meta, syl, line, furi )
											if #s_i > 0 then
												fx.domain_i = s_i[1]
											else
												fx.domain_i = 0
											end
											s_f1 = loadstring("return function(fx__, meta, syl, line, furi) return {".. fx__.s_f .."} end")( )
											s_f = s_f1( fx__, meta, syl, line, furi )
											if #s_f > 0 then
												fx.domain_f = s_f[1]
											else
												fx.domain_f = 1
											end
										end
										local s = fx.domain_i + module*(fx.domain_f - fx.domain_i)
										--variables de funciones paramétricas--
										fun_x1 = loadstring("return function(fx__, meta, syl, line, furi, s) return {".. fx__.fun_x .."} end")( )
										fun_x = fun_x1( fx__, meta, syl, line, furi, s )
										if #fun_x > 0 then
											fx.fun_x = fun_x[1]*fx.scale_x
										else
											fx.fun_x = 0
										end
										fun_y1 = loadstring("return function(fx__, meta, syl, line, furi, s) return {".. fx__.fun_y .."} end")( )
										fun_y = fun_y1( fx__, meta, syl, line, furi, s )
										if #fun_y > 0 then
											fx.fun_y = fun_y[1]*fx.scale_y
										else
											fx.fun_y = 0
										end
										--definir posición inicial--
										fx.pos_x = fx.center_x
										fx.pos_y = fx.center_y
										--fx.pos_x, fx.pos_y = effector.knj( fx__.v_kanji )
										fx.off_x, fx.off_y = effector.modify_pos( )
										--variables de posiciones--
										fx.pos_x = fx.pos_x + fx.fun_x - fx.off_x
										fx.pos_y = fx.pos_y + fx.fun_y - fx.off_y
										fx.pos_l = fx.pos_x - furi.width/2
										fx.pos_r = fx.pos_x + furi.width/2
										fx.pos_t = fx.pos_y - furi.height/2
										fx.pos_b = fx.pos_y + furi.height/2
										x, y = fx.pos_x, fx.pos_y
										--variables de tamaño--
										size1 = loadstring("return function(fx__, meta, syl, line, furi, s) return {".. fx__.size .."} end")( )
										size = size1( fx__, meta, syl, line, furi, s )
										if #size > 0 then
											if #size == 1 then
												fx.sizex = math.round(size[1], 2)
												fx.sizey = fx.sizex
											elseif #size == 2 then
												fx.sizex = math.round(size[1], 2)
												fx.sizey = math.round(size[2], 2)
											end
											fx.tag_size = format("\\fscx%s\\fscy%s", fx.sizex, fx.sizey)
										else
											fx.sizex = L.scale_x
											fx.sizey = L.scale_y
											fx.tag_size = ""
										end
										--variables de alineación y de capa (layer)--
										align1 = loadstring("return function(fx__, meta, syl, line, furi, s, module) return {".. fx__.align .."} end")( )
										align = align1( fx__, meta, syl, line, furi, s, module )
										if #align > 0 then
											fx.align = "\\an"..align[1]
										else
											fx.align = ""
										end
										layer1 = loadstring("return function(fx__, meta, syl, line, furi, s, module) return {".. fx__.layer .."} end")( )
										layer = layer1( fx__, meta, syl, line, furi, s, module )
										fx.layer = layer[1] or l_layer
										--variables de posiciones definitivas, dependiendo del "move"--
										move_x11 = loadstring("return function(fx__, meta, syl, line, furi, x, y, s, module) return {".. fx__.move_x .."} end")( )
										move_x = math.round(move_x11( fx__, meta, syl, line, furi, x, y, s, module ), 2)
										move_y11 = loadstring("return function(fx__, meta, syl, line, furi, x, y, s, module) return {".. fx__.move_y .."} end")( )
										move_y = math.round(move_y11( fx__, meta, syl, line, furi, x, y, s, module ), 2)
										--variables de tiempo del movimiento--
										fx__.move_t = fx__.move_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										move_t1 = loadstring("return function(fx__, meta, syl, line, furi, s, module) return {".. fx__.move_t .."} end")( )
										move_t = move_t1( fx__, meta, syl, line, furi, s, module )
										fx.movet_i = math.round(move_t[1] or 0, 2)
										fx.movet_f = math.round(move_t[2] or fx.dur, 2)
										if #move_t > 0 then
											tags_times = ","..tostring(fx.movet_i)..","..tostring(fx.movet_f)
										else
											tags_times = ""
										end
										--posiciones finales--
										Nmove = math.max(#move_x, #move_y)
										fx.move_x1 = math.round(move_x[1] or fx.pos_x, 2)
										fx.move_y1 = math.round(move_y[1] or fx.pos_y, 2)
										fx.move_x2 = math.round(move_x[2] or fx.move_x1, 2)
										fx.move_y2 = math.round(move_y[2] or fx.move_y1, 2)
										fx.move_x3 = math.round(move_x[3] or fx.move_x2, 2)
										fx.move_y3 = math.round(move_y[3] or fx.move_y2, 2)
										fx.move_x4 = math.round(move_x[4] or fx.move_x3, 2)
										fx.move_y4 = math.round(move_y[4] or fx.move_y3, 2)
										fx.angle1 = fx.move_x3
										fx.angle2 = fx.move_x4
										fx.radius1 = math.round(move_x[5] or fx.pos_x, 2)
										fx.radius2 = math.round(move_x[6] or fx.radius1, 2)
										tb_pos = {fx.move_x1, fx.move_y1, fx.move_x2, fx.move_y2, fx.move_x3, fx.move_y3, fx.move_x4, fx.move_y4, fx.angle1, fx.angle2, fx.radius1, fx.radius2}
										fx.move_l1, fx.move_r1, fx.move_t1, fx.move_b1 = fx.move_x1 - val_width/2, fx.move_x1 + val_width/2, fx.move_y1 - val_height/2, fx.move_y1 + val_height/2
										fx.move_l2, fx.move_r2, fx.move_t2, fx.move_b2 = fx.move_x2 - val_width/2, fx.move_x2 + val_width/2, fx.move_y2 - val_height/2, fx.move_y2 + val_height/2
										fx.move_l3, fx.move_r3, fx.move_t3, fx.move_b3 = fx.move_x3 - val_width/2, fx.move_x3 + val_width/2, fx.move_y3 - val_height/2, fx.move_y3 + val_height/2
										fx.move_l4, fx.move_r4, fx.move_t4, fx.move_b4 = fx.move_x4 - val_width/2, fx.move_x4 + val_width/2, fx.move_y4 - val_height/2, fx.move_y4 + val_height/2
										fx.pos = effector.pos(Nmove, tb_pos, tags_times)
										fx_start, fx_end, fx_mid, fx_dur, fx_i, fx_n, fx_x, fx_y = fx.start_time, fx.end_time, fx.start_time + fx.dur/2, fx.dur, j, maxj, fx.move_x1, fx.move_y1
										fx_left, fx_center, fx_right, fx_width, fx_top, fx_middle, fx_bottom, fx_height = fx.move_l1, fx.move_x1, fx.move_r1, fx.move_r1 - fx.move_l1, fx.move_t1, fx.move_y1, fx.move_b1, fx.move_b1 - fx.move_t1
										if pcall(loadstring("return function(fx__, meta, syl, line, furi) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")) == true then
											returnfx1 = loadstring("return function(fx__, meta, syl, line, furi) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")( )
											returnfx = returnfx1( fx__, meta, syl, line, furi )
										else
											returnfx = { [1] = fx__.returnfx }
										end
										Rline = 1
										if returnfx[2] and returnfx[2] == "random" then
											Rline = 2 - R(count_fx + 1)
										end
										if #returnfx > 0 or returnfx[1] ~= nil then
											if returnfx[1]:match("m %-?%d+[%.%d+]* %-?%d+[%.%d+]*") then
												fx.Det = "\\p1"
												if returnfx[1]:match("\\p%d") then
													fx.Det = ""
												end
												tags_style = shape.style
											else
												fx.Det = ""
												tags_style = text.style
											end
											if (fx.Det == "\\p1" or returnfx[1]:match("\\p%d")) and fx.tag_size == "" then
												fx.tag_size = "\\fscx100\\fscy100"
											end
											if fx__.language ~= "Automation Auto-4" then
												addtag1 = loadstring("return function(fx__, meta, line, furi, x, y, module) return {".. tag.HTML_to_ass(fx__.addtag) .."} end")( )
												addtag = addtag1( fx__, meta, line, furi, x, y, module )
												fx.add_tags = tag.do_tag( table.op(addtag, "concat") )
											else
												fx.add_tags = tag.to_Auto4( tag.HTML_to_ass(fx__.addtag) )
											end
											if fxgroup == true then
												if fx__.modify == false and fx__.namefx ~= "raw" then
													l.text = fx.tm(format("{%s %s: %s [line origin: %s - line fx: %s] %s%s%s%s%s%s}%s", script_name, script_version, fx__.effect:gsub("%S+[%-%S+]*%[fx%]: ", ""), ii, count_fx + 1, fx.align, fx.pos, tags_style, fx.tag_size, fx.add_tags, fx.Det, returnfx[1]))
													l.effect = "Effector [Fx]"
													l.style = furi.style.name
													l.layer = fx.layer
													l.actor = actor_fx
													subs.insert( #subs + Rline, l )
													count_fx = count_fx + 1
												elseif fx__.modify == false and fx__.namefx == "raw" then
													l.text = fx.tm(returnfx[1])
													subs.insert( #subs + Rline, l )
													count_fx = count_fx + 1
												else
													lines_comment = false
													line.start_time = fx.start_time
													line.end_time = fx.end_time
													line.text = fx.tm(format("{%s}%s", fx.add_tags, returnfx[1]))
												end
											end
										end
										j = j + 1
										aegisub.progress.task(F("Lines: [%d/%d]  Progress: [%s%%]  Lines Generated: %d", count_ln, #idx_line, math.round(100*count_ln/#idx_line, 2), count_fx))
										aegisub.progress.set(100*line.i/line.n)
									end
									J = J + 1
								end
							end
						end
					end
				end
			end
		end
		
		if (fx__.t_type == "Translation Line" or fx__.t_type == "Translation Word" or fx__.t_type == "Translation Char" or fx__.t_type == "Word")
			and line.text_stripped:gsub(" ", ""):gsub("	", "") ~= noblank1 then
			
			local x = line.center
			local y	= line.middle
			local l = table.copy(line)
			if fx__.folderfx == "lead-in[fx]" then
				library_fx, library_mode, actor_fx = "leadin_fx_library", "leadin_fx", "lead-in"
			elseif fx__.folderfx == "hi-light[fx]" then
				library_fx, library_mode, actor_fx = "hilight_fx_library", "hilight_fx", "hi-light"
			elseif fx__.folderfx == "lead-out[fx]" then
				library_fx, library_mode, actor_fx = "leadout_fx_library", "leadout_fx", "lead-out"
			elseif fx__.folderfx == "shape[fx]" then
				library_fx, library_mode, actor_fx = "shape_fx_library", "shape_fx", "shape-fx"
			elseif fx__.folderfx == "translation[fx]" then
				library_fx, library_mode, actor_fx = "transla_fx_library", "transla_fx", "translation"
			end
			if fx__.printfx == true then
				library_title = fx__.folderfx
				lines_comment = false
				if line.i == 1 then
					newFX = fx__.namefx:gsub(" ", "_")
					if newFX == "" then
						newFX = library_mode.."_"..tostring(os.time()):sub(-6, -1)
					end
					if fx__.folderfx == "translation[fx]" then
						fx_GUI = "Trans_Box"
					elseif fx__.folderfx == "shape[fx]" then
						fx_GUI = "Shape_Box"
					else
						fx_GUI = "PfxM_Box"
					end
					New_fx_config = format("%s = table.duplicate(%s); table.inbox(%s, \"%s: %s\",\"%s\",%s,%s,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"); table.insert(%s, %s); table.insert(%s, \"%s\")", newFX, fx_GUI, newFX, library_title, newFX:gsub("_", " "), fx_box[29].value, ((fx_box[30].value == true) and "true" or "false"), ((fx_box[31].value == true) and "true" or "false"), fx_box[32].value, fx_box[33].value, fx_box[34].value, fx_box[35].value, fx_box[36].value, fx_box[37].value, Ps(fx_box[38].text), Ps(fx_box[39].text), Ps(fx_box[40].text), Ps(fx_box[41].text), Ps(fx_box[42].text), Ps(fx_box[43].text), Ps(fx_box[44].text), Ps(fx_box[45].text), Ps(fx_box[46].text), Ps(fx_box[47].text), Ps(fx_box[48].text), Ps(fx_box[49].text), Ps(fx_box[50].text), Ps(fx_box[51].text), Ps(fx_box[52].text), Ps(fx_box[53].text), Ps(fx_box[54].text), Ps(fx_box[55].text), Ps(fx_box[56].text), Ps(fx_box[57].text), fx_box[66].value, library_fx, newFX, library_mode, newFX:gsub("_", " "))
					if Path_Effector_newfx_lua == nil then
						l.comment = true
						l.effect = "Effector [Fx] Config"
						l.start_time, l.end_time = 0, 0
						l.text = New_fx_config
						subs.append(l)
					else
						fx_libx = format("%s", fx__.folderfx:sub(1, -5).." fx")
						while fx_libx:len() < 14 do
							fx_libx = fx_libx.." "
						end
						fx_date = format("--[[%s %s]] ", fx_libx, tostring(os.date()):sub(1, -4))
						effector.savefx(fx_date..New_fx_config.."\n	", Path_Effector_newfx_lua)
						aegisub.debug.out("The effect ★%s★ is saved in the Folder %s, you must reload the script Kara Effector so you can see it in the list effects type %s.\n\nEl efecto ★%s★ se ha guardado en el Folder %s, debes recargar el script Kara Effector para que puedas verlo en la lista de efectos tipo %s.", newFX:gsub("_", " "), fx__.folderfx, fx__.folderfx, newFX:gsub("_", " "), fx__.folderfx, fx__.folderfx)
						aegisub.progress.set(100)
					end
				end
			else
				if fx__.namefx:sub(1, 7) == "export " then
					if line.i == 1 then
						export_text(fx__.namefx)
						lines_comment = false
					end
					fx_box[62].text = ""
				else
				
					actor_fx = fx__.effect:gsub("%[.+[%W+]*", "")
					if line.text_stripped:gsub(" ", ""):gsub("	", "") ~= noblank1 and line.duration > 0 then

						if fx__.t_type == "Translation Line" then
							-----------------------------------------------
							val_width, val_height, val_text = l.width, l.height, l.text
							val_center, val_middle, val_left, val_right = l.center, l.middle, l.left, l.right
							val_top, val_bottom, val_dur = l.top, l.bottom, l.duration
							val_start, val_end, val_mid  = line.start_time, line.end_time, line.start_time + line.duration/2
							val_i, val_n = l.i, l.n
							shape.trapeze1t = format("m 0 0 l 0 %d l %d %d l %d 0 ", l.height, l.width, l.height, l.width + l.height)
							shape.trapeze1b = format("m 0 0 l 0 %d l %d %d l %d 0 ", l.height, l.width + l.height, l.height, l.width)
							-----------------------------------------------
							word_start, word_end, word_mid, word_dur, word_i, word_n, word_left, word_center, word_right, word_bottom, word_middle, word_top, word_width, word_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
							syl_start,  syl_end,  syl_mid,  syl_dur,  syl_i,  syl_n,  syl_left,  syl_center,  syl_right,  syl_bottom,  syl_middle,  syl_top,  syl_width,  syl_height  = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
							furi_start, furi_end, furi_mid, furi_dur, furi_i, furi_n, furi_left, furi_center, furi_right, furi_bottom, furi_middle, furi_top, furi_width, furi_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
							hira_start, hira_end, hira_mid, hira_dur, hira_i, hira_n, hira_left, hira_center, hira_right, hira_bottom, hira_middle, hira_top, hira_width, hira_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
							kata_start, kata_end, kata_mid, kata_dur, kata_i, kata_n, kata_left, kata_center, kata_right, kata_bottom, kata_middle, kata_top, kata_width, kata_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
							roma_start, roma_end, roma_mid, roma_dur, roma_i, roma_n, roma_left, roma_center, roma_right, roma_bottom, roma_middle, roma_top, roma_width, roma_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
							char_start, char_end, char_mid, char_dur, char_i, char_n, char_left, char_center, char_right, char_bottom, char_middle, char_top, char_width, char_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
							-----------------------------------------------
							W_ = aegisub.line2W( )
							S_ = aegisub.line2S( )
							C_ = aegisub.line2C( )
							-----------------------------------------------
							fx.replay_fx, J = 1, 1
							maxJ = fx.replay_fx
							while J <= fx.replay_fx do
								j = 1
								if fx.replay_fx == 1 then
									moduler = 0
								else
									moduler = (J - 1)/(maxJ - 1)
								end
								module = 0
								module1 = module
								module2 = module1
								fxgroup = true
								-----------------------------------------------
								effector.default_val( )
								-----------------------------------------------
								if pcall(loadstring("return function(fx__, meta, syl, line, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")) == true then
									variable_ = loadstring("return function(fx__, meta, syl, line, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")( )
									var_KEfx_ = variable_( fx__, meta, syl, line, x, y )
								end
								variable_ = loadstring("return function(fx__, meta, syl, line, x, y) return {".. tag.HTML_to_ass(fx__.variable) .."} end")( )
								if line.i == 1 and J == 1 then
									var.once = remember("v_once", variable_( fx__, meta, syl, line, x, y ))
								else
									var.once = recall.v_once
								end
								if J == 1 then
									var.rep = variable_( fx__, meta, syl, line, x, y )
								end
								var.line = variable_( fx__, meta, syl, line, x, y )
								var.word, var.syl, var.furi, var.char = var.line, var.line, var.line, var.line
								var.loop = variable_( fx__, meta, syl, line, x, y )
								-----------------------------------------------
								maxloop1 = loadstring("return function(fx__, meta, syl, line, x, y) return {".. fx__.loops .."} end")( )
								maxloop_fx = maxloop1( fx__, meta, syl, line, x, y )
								loop_h = ceil((maxloop_fx[1] or 1)*(line.width + 2*L.outline)/(line.height + 2*L.outline))
								maxloop_fx = maxloop1( fx__, meta, syl, line, x, y )
								fx.loop_v = maxloop_fx[1] or 1
								fx.loop_h = maxloop_fx[2] or 1
								fx.loop_3 = maxloop_fx[3] or 1
								fx.maxloop_fx = fx.loop_v*fx.loop_h*fx.loop_3
								maxj = fx.maxloop_fx
								-----------------------------------------------
								while j <= fx.maxloop_fx do
									var.loop = variable_( fx__, meta, syl, line, x, y )
									--variables de modulo--
									if fx.maxloop_fx == 1 then
										module = 0
									else
										module = (j - 1)/(maxj - 1)
									end
									if line.n == 1 then
										module2 = module
									else
										module2 = (line.i + module - 1)/(line.n + module - 1)
									end
									--variables de tiempo--
									fx__.start_t = fx__.start_t:gsub("(%d+%:%d+%:%d+%.%d+)",
										function( time_HMS )
											return tostring( HMS_to_ms( time_HMS ) )
										end
									)
									fx__.end_t = fx__.end_t:gsub("(%d+%:%d+%:%d+%.%d+)",
										function( time_HMS )
											return tostring( HMS_to_ms( time_HMS ) )
										end
									)
									start_t1 = loadstring("return function(fx__, meta, syl, line, module) return {".. fx__.start_t .."} end")( )
									start_t	= start_t1( fx__, meta, syl, line, module )
									if #start_t > 0 then
										fx.start_time = start_t[1]
									else
										fx.start_time = line.start_time
									end
									l.start_time = fx.start_time
									end_t1 = loadstring("return function(fx__, meta, syl, line, module) return {".. fx__.end_t .."} end")( )
									end_t = end_t1( fx__, meta, syl, line, module )
									if #end_t > 0 then
										fx.end_time = end_t[1]
									else
										fx.end_time = line.end_time
									end
									l.end_time = fx.end_time
									fx.dur = fx.end_time - fx.start_time
									function retime( mode, add_start, add_end )
										add_start = HMS_to_ms( add_start ) or 0
										add_end = HMS_to_ms( add_end ) or 0
										if mode == "line" then
											l.start_time = line.start_time + add_start
											l.end_time = line.end_time + add_end
										elseif mode == "preline" then
											l.start_time = line.start_time + add_start
											l.end_time = line.start_time + add_end
										elseif mode == "postline" then
											l.start_time = line.end_time + add_start
											l.end_time = line.end_time + add_end
										elseif mode == "linepct" then
											l.start_time = line.start_time + add_start*line.duration/100
											l.end_time = line.start_time + add_end*line.duration/100
										elseif mode == "set" or mode == "abs" then
											l.start_time = add_start
											l.end_time = add_end
										elseif mode == "fxpretime" then
											l.start_time = fx.start_time + add_start
											l.end_time = fx.start_time + add_end
										elseif mode == "fxtime" then
											l.start_time = fx.start_time + add_start
											l.end_time = fx.end_time + add_end
										elseif mode == "fxposttime"	then
											l.start_time = fx.end_time + add_start
											l.end_time = fx.end_time + add_end
										elseif mode == "fxpct" then
											l.start_time = fx.start_time + add_start*fx.dur/100
											l.end_time = fx.start_time + add_end*fx.dur/100
										end
										fx.start_time, fx.end_time = l.start_time, l.end_time
										fx.dur = fx.end_time - fx.start_time
										return ""
									end
									---------------------------------------------------
									--variables de punto de referencia--
									center_x1 = loadstring("return function(fx__, meta, syl, line, x, y, module) return {".. fx__.center_x .."} end")( )
									center_x = center_x1( fx__, meta, syl, line, x, y, module )
									if #center_x > 0 then
										fx.center_x = center_x[1]
									else
										fx.center_x = val_center
									end
									center_y1 = loadstring("return function(fx__, meta, syl, line, x, y, module) return {".. fx__.center_y .."} end")( )
									center_y = center_y1( fx__, meta, syl, line, x, y, module )
									if #center_y > 0 then
										fx.center_y = center_y[1]
									else
										fx.center_y = val_middle
									end
									--variables de escalas de funciones paramétricas-- 
									if j == 1 then
										scale_x1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.scale_x .."} end")( )
										scale_x	= scale_x1( fx__, meta, syl, line )
										if #scale_x > 0 then
											fx.scale_x = scale_x[1]
										else
											fx.scale_x = 1
										end
										if fx.scale_x <= 0 then
											fx.scale_x = 0.1
										end
										scale_y1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.scale_y .."} end")( )
										scale_y	= scale_y1( fx__, meta, syl, line )
										if #scale_y > 0 then
											fx.scale_y = scale_y[1]
										else
											fx.scale_y = 1
										end
										if fx.scale_y <= 0 then
											fx.scale_y = 0.1
										end
									end
									offset_maxspace = scale_x[2] or 0
									--variables de dominio de funciones--
									if j == 1 then
										s_i1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.s_i .."} end")( )
										s_i = s_i1( fx__, meta, syl, line )
										if #s_i > 0 then
											fx.domain_i = s_i[1]
										else
											fx.domain_i = 0
										end
										s_f1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.s_f .."} end")( )
										s_f = s_f1( fx__, meta, syl, line )
										if #s_f > 0 then
											fx.domain_f = s_f[1]
										else
											fx.domain_f = 1
										end
									end
									local
									s = fx.domain_i + module*(fx.domain_f - fx.domain_i)
									--variables de funciones paramétricas--
									fun_x1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.fun_x .."} end")( )
									fun_x = fun_x1( fx__, meta, syl, line, s )
									if #fun_x > 0 then
										fx.fun_x = fun_x[1]*fx.scale_x
									else
										fx.fun_x = 0
									end
									fun_y1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.fun_y .."} end")( )
									fun_y = fun_y1( fx__, meta, syl, line, s )
									if #fun_y > 0 then
										fx.fun_y = fun_y[1]*fx.scale_y
									else
										fx.fun_y = 0
									end
									--definir las posiciones iniciales--
									fx.pos_x = fx.center_x
									fx.pos_y = fx.center_y
									fx.off_x, fx.off_y = effector.modify_pos( )
									--variables de posiciones--
									fx.pos_x = fx.pos_x + fx.fun_x - fx.off_x
									fx.pos_y = fx.pos_y + fx.fun_y - fx.off_y
									fx.pos_l = fx.pos_x - l.width/2
									fx.pos_r = fx.pos_x + l.width/2
									fx.pos_t = fx.pos_y - l.height/2
									fx.pos_b = fx.pos_y + l.height/2
									x, y = fx.pos_x, fx.pos_y
									--variables de tamaño--
									if fx__.size ~= nil and fx__.size ~= "" then
										size1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.size .."} end")( )
										size = size1( fx__, meta, syl, line, s )
										if #size == 1 then
											fx.sizex = math.round(size[1], 2)
											fx.sizey = fx.sizex
										elseif #size == 2 then
											fx.sizex = math.round(size[1], 2)
											fx.sizey = math.round(size[2], 2)
										end
										fx.tag_size = format("\\fscx%s\\fscy%s", fx.sizex, fx.sizey)
									else
										fx.sizex = L.scale_x
										fx.sizey = L.scale_y
										fx.tag_size = ""
									end
									--variables de alineación y de capa (layer)--
									align1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.align .."} end")( )
									align = align1( fx__, meta, syl, line, s, module )
									if #align > 0 then
										fx.align = "\\an"..align[1]
									else
										fx.align = ""
									end
									layer1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.layer .."} end")( )
									layer = layer1( fx__, meta, syl, line, s, module )
									fx.layer = layer[1] or l_layer
									--variables de posiciones, dependiendo del "move"--
									move_x11 = loadstring("return function(fx__, meta, syl, line, x, y, s, module) return {".. fx__.move_x .."} end")( )
									move_x = math.round(move_x11( fx__, meta, syl, line, x, y, s, module ), 2)
									move_y11 = loadstring("return function(fx__, meta, syl, line, x, y, s, module) return {".. fx__.move_y .."} end")( )
									move_y = math.round(move_y11( fx__, meta, syl, line, x, y, s, module ), 2)
									--variables de tiempo del movimiento--
									fx__.move_t = fx__.move_t:gsub("(%d+%:%d+%:%d+%.%d+)",
										function( time_HMS )
											return tostring( HMS_to_ms( time_HMS ) )
										end
									)
									move_t1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.move_t .."} end")( )
									move_t = move_t1( fx__, meta, syl, line, s, module )
									fx.movet_i = math.round(move_t[1] or 0, 2)
									fx.movet_f = math.round(move_t[2] or fx.dur, 2)
									if #move_t > 0 then
										tags_times = ","..tostring(fx.movet_i)..","..tostring(fx.movet_f)
									else
										tags_times = ""
									end
									--posiciones finales--
									Nmove = math.max(#move_x, #move_y)
									fx.move_x1 = math.round(move_x[1] or fx.pos_x, 2)
									fx.move_y1 = math.round(move_y[1] or fx.pos_y, 2)
									fx.move_x2 = math.round(move_x[2] or fx.move_x1, 2)
									fx.move_y2 = math.round(move_y[2] or fx.move_y1, 2)
									fx.move_x3 = math.round(move_x[3] or fx.move_x2, 2)
									fx.move_y3 = math.round(move_y[3] or fx.move_y2, 2)
									fx.move_x4 = math.round(move_x[4] or fx.move_x3, 2)
									fx.move_y4 = math.round(move_y[4] or fx.move_y3, 2)
									fx.angle1 = fx.move_x3
									fx.angle2 = fx.move_x4
									fx.radius1 = math.round(move_x[5] or fx.pos_x, 2)
									fx.radius2 = math.round(move_x[6] or fx.radius1, 2)
									tb_pos = {fx.move_x1, fx.move_y1, fx.move_x2, fx.move_y2, fx.move_x3, fx.move_y3, fx.move_x4, fx.move_y4, fx.angle1, fx.angle2, fx.radius1, fx.radius2}
									fx.move_l1, fx.move_r1, fx.move_t1, fx.move_b1 = fx.move_x1 - val_width/2, fx.move_x1 + val_width/2, fx.move_y1 - val_height/2, fx.move_y1 + val_height/2
									fx.move_l2, fx.move_r2, fx.move_t2, fx.move_b2 = fx.move_x2 - val_width/2, fx.move_x2 + val_width/2, fx.move_y2 - val_height/2, fx.move_y2 + val_height/2
									fx.move_l3, fx.move_r3, fx.move_t3, fx.move_b3 = fx.move_x3 - val_width/2, fx.move_x3 + val_width/2, fx.move_y3 - val_height/2, fx.move_y3 + val_height/2
									fx.move_l4, fx.move_r4, fx.move_t4, fx.move_b4 = fx.move_x4 - val_width/2, fx.move_x4 + val_width/2, fx.move_y4 - val_height/2, fx.move_y4 + val_height/2
									fx.pos = effector.pos(Nmove, tb_pos, tags_times)
									fx_start, fx_end, fx_mid, fx_dur, fx_i, fx_n, fx_x, fx_y = fx.start_time, fx.end_time, fx.start_time + fx.dur/2, fx.dur, j, maxj, fx.move_x1, fx.move_y1
									fx_left, fx_center, fx_right, fx_width, fx_top, fx_middle, fx_bottom, fx_height = fx.move_l1, fx.move_x1, fx.move_r1, fx.move_r1 - fx.move_l1, fx.move_t1, fx.move_y1, fx.move_b1, fx.move_b1 - fx.move_t1
									if pcall(loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")) == true then
										returnfx1 = loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")( )
										returnfx = returnfx1( fx__, meta, syl, line )
									else
										returnfx = { [1] = fx__.returnfx }
									end
									Rline = 1
									if returnfx[2] and returnfx[2] == "random" then
										Rline = 2 - R(count_fx + 1)
									end
									if #returnfx > 0 or returnfx[1] ~= nil then
										if returnfx[1]:match("m %-?%d+[%.%d+]* %-?%d+[%.%d+]*") then
											fx.Det = "\\p1"
											if returnfx[1]:match("\\p%d") then
												fx.Det = ""
											end
											tags_style = shape.style
										else
											fx.Det = ""
											tags_style = text.style
										end
										if (fx.Det == "\\p1" or returnfx[1]:match("\\p%d")) and fx.tag_size == "" then
											fx.tag_size = "\\fscx100\\fscy100"
										end
										if fx__.language ~= "Automation Auto-4" then
											addtag1 = loadstring("return function(fx__, meta, line, x, y, module) return {".. tag.HTML_to_ass(fx__.addtag) .."} end")( )
											addtag = addtag1( fx__, meta, line, x, y, module )
											fx.add_tags = tag.do_tag( table.op(addtag, "concat") )
										else
											fx.add_tags = tag.to_Auto4( tag.HTML_to_ass(fx__.addtag) )
										end
										if fxgroup == true then
											if fx__.modify == false and fx__.namefx ~= "raw" then
												l.text = fx.tm(format("{%s %s: %s [line origin: %s - line fx: %s] %s%s%s%s%s%s}%s", script_name, script_version, fx__.effect:gsub("%S+[%-%S+]*%[fx%]: ", ""), ii, count_fx + 1, fx.align, fx.pos, tags_style, fx.tag_size, fx.add_tags, fx.Det, returnfx[1]))
												l.effect = "Effector [Fx]"
												l.layer = fx.layer
												l.actor = actor_fx
												subs.insert( #subs + Rline, l )
												count_fx = count_fx + 1
											elseif fx__.modify == false and fx__.namefx == "raw" then
												l.text = fx.tm(returnfx[1])
												subs.insert( #subs + Rline, l )
												count_fx = count_fx + 1
											else
												lines_comment = false
												line.start_time = fx.start_time
												line.end_time = fx.end_time
												line.text = fx.tm(format("{%s}%s", fx.add_tags, returnfx[1]))
											end
										end
									end
									j = j + 1
									aegisub.progress.task(F("Lines: [%d/%d]  Progress: [%s%%]  Lines Generated: %d", count_ln, #idx_line, math.round(100*count_ln/#idx_line, 2), count_fx))
									aegisub.progress.set(100*line.i/line.n)
								end
								J = J + 1
							end
						end

						if fx__.t_type == "Word" or fx__.t_type == "Translation Word" then
							-----------------------------------------------
							fx.replay_fx, J = 1, 1
							maxJ = fx.replay_fx
							while J <= fx.replay_fx do
								if fx.replay_fx == 1 then
									moduler = 0
								else
									moduler = (J - 1)/(maxJ - 1)
								end
								module = 0
								module1 = module
								module2 = module1
								fxgroup = true
								--------------------------------------------------
								word = { }
								for w in line.text_stripped:gmatch("%S+") do
									table.insert(word, w)
								end
								word.i, word.n, width, left = 1, #word, 0, line.left
								--------------------------------------------------
								for w in line.text_stripped:gsub("\\N", " "):gsub("  ", " "):gmatch("%S+") do
									j = 1
									word.text = w
									word.text_stripped = w
									width = aegisub.text_extents(line.styleref, word.text)
									widtht = aegisub.text_extents(line.styleref, word.text.." ")
									word.width = width
									word.height = l.height
									word.top = l.top
									word.middle = l.middle
									word.bottom = l.bottom
									word.left = left
									word.right = left + word.width
									word.center = left + word.width/2
									word.start_time = line.duration*(word.i - 1)/word.n
									word.end_time = line.duration*(word.i - 0)/word.n
									word.duration = word.end_time - word.start_time
									word.dur = word.duration
									word.mid_time = word.start_time + word.dur/2
									word.widthmax = math.max(unpack(mmwth[ii].wo))
									word.widthmin = math.min(unpack(mmwth[ii].wo))
									word.durmax = math.max(unpack(mmdur[ii].wo))
									word.durmin = math.min(unpack(mmdur[ii].wo))
									--word.text_raw	= linefx[ii].word[word.i].text_raw
									-----------------------------------------------
									W_ = aegisub.word(line.text, line.dur, word.i)
									-----------------------------------------------
									val_width, val_height, val_text = word.width, word.height, word.text
									val_center, val_middle, val_left, val_right = word.center, word.middle, word.left, word.right
									val_top, val_bottom, val_dur = word.top, word.bottom, word.duration
									val_start, val_end, val_mid  = word.start_time, word.end_time, word.start_time + word.duration/2
									val_i, val_n = word.i, word.n
									shape.trapeze1t = format("m 0 0 l 0 %d l %d %d l %d 0 ", word.height, word.width, word.height, word.width + word.height)
									shape.trapeze1b = format("m 0 0 l 0 %d l %d %d l %d 0 ", word.height, word.width + word.height, word.height, word.width)
									-----------------------------------------------
									word_start, word_end, word_mid, word_dur, word_i, word_n, word_left, word_center, word_right, word_bottom, word_middle, word_top, word_width, word_height = word.start_time, word.end_time, word.mid_time, word.dur, word.i, word.n, word.left, word.center, word.right, word.bottom, word.middle, word.top, word.width, word.height
									syl_start,  syl_end,  syl_mid,  syl_dur,  syl_i,  syl_n,  syl_left,  syl_center,  syl_right,  syl_bottom,  syl_middle,  syl_top,  syl_width,  syl_height  = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
									furi_start, furi_end, furi_mid, furi_dur, furi_i, furi_n, furi_left, furi_center, furi_right, furi_bottom, furi_middle, furi_top, furi_width, furi_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
									hira_start, hira_end, hira_mid, hira_dur, hira_i, hira_n, hira_left, hira_center, hira_right, hira_bottom, hira_middle, hira_top, hira_width, hira_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
									kata_start, kata_end, kata_mid, kata_dur, kata_i, kata_n, kata_left, kata_center, kata_right, kata_bottom, kata_middle, kata_top, kata_width, kata_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
									roma_start, roma_end, roma_mid, roma_dur, roma_i, roma_n, roma_left, roma_center, roma_right, roma_bottom, roma_middle, roma_top, roma_width, roma_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
									char_start, char_end, char_mid, char_dur, char_i, char_n, char_left, char_center, char_right, char_bottom, char_middle, char_top, char_width, char_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
									-----------------------------------------------
									S_ = aegisub.word2S( )
									C_ = aegisub.word2C( )
									-----------------------------------------------
									effector.default_val( )
									-----------------------------------------------
									if pcall(loadstring("return function(fx__, meta, syl, line, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")) == true then
										variable_ = loadstring("return function(fx__, meta, syl, line, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")( )
										var_KEfx_ = variable_( fx__, meta, syl, line, x, y )
									end
									variable_ = loadstring("return function(fx__, meta, syl, line, x, y) return {".. tag.HTML_to_ass(fx__.variable) .."} end")( )
									if line.i == 1 and word.i == 1 and J == 1 then
										var.once = remember("v_once", variable_( fx__, meta, syl, line, x, y ))
									else
										var.once = recall.v_once
									end
									if word.i == 1 and J == 1 then
										var.line = variable_( fx__, meta, syl, line, x, y )
									end
									if J == 1 then
										var.rep = variable_( fx__, meta, syl, line, x, y )
									end
									var.word = variable_( fx__, meta, syl, line, x, y )
									var.syl, var.furi, var.char = var.word, var.word, var.word
									var.loop = variable_( fx__, meta, syl, line, x, y )
									-----------------------------------------------
									maxloop1 = loadstring("return function(fx__, meta, syl, line, x, y) return {".. fx__.loops .."} end")( )
									maxloop_fx = maxloop1( fx__, meta, syl, line, x, y )
									loop_h = ceil((maxloop_fx[1] or 1)*(word.width + 2*L.outline)/(word.height + 2*L.outline))
									maxloop_fx = maxloop1( fx__, meta, syl, line, x, y )
									fx.loop_v = maxloop_fx[1] or 1
									fx.loop_h = maxloop_fx[2] or 1
									fx.loop_3 = maxloop_fx[3] or 1
									fx.maxloop_fx = fx.loop_v*fx.loop_h*fx.loop_3
									maxj = fx.maxloop_fx
									-----------------------------------------------
									while j <= fx.maxloop_fx do
										var.loop = variable_( fx__, meta, syl, line, x, y )
										--variables de modulo--
										if fx.maxloop_fx == 1 then
											module = 0
										else
											module = (j - 1)/(maxj - 1)
										end
										if word.n == 1 then
											module1 = module
										else
											module1 = (word.i + module - 1)/(word.n + module - 1)
										end
										if line.n == 1 then
											module2 = module1
										else
											module2 = (line.i + module1 - 1)/(line.n + module1 - 1)
										end
										--variables de tiempo--
										fx__.start_t = fx__.start_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										fx__.end_t = fx__.end_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										start_t1 = loadstring("return function(fx__, meta, syl, line, module) return {".. fx__.start_t .."} end")( )
										start_t	= start_t1( fx__, meta, syl, line, module )
										if #start_t > 0 then
											fx.start_time = start_t[1]
										else
											fx.start_time = line.start_time
										end
										l.start_time = fx.start_time
										end_t1 = loadstring("return function(fx__, meta, syl, line, module) return {".. fx__.end_t .."} end")( )
										end_t = end_t1( fx__, meta, syl, line, module )
										if #end_t > 0 then
											fx.end_time = end_t[1]
										else
											fx.end_time = line.end_time
										end
										l.end_time = fx.end_time
										fx.dur = fx.end_time - fx.start_time
										function retime( mode, add_start, add_end )
											add_start = HMS_to_ms( add_start ) or 0
											add_end = HMS_to_ms( add_end ) or 0
											if mode == "line" then
												l.start_time = line.start_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "preline" then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + add_end
											elseif mode == "postline" then
												l.start_time = line.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "word" then
												l.start_time = line.start_time + word.start_time + add_start
												l.end_time = line.start_time + word.end_time + add_end
											elseif mode == "preword" then
												l.start_time = line.start_time + word.start_time + add_start
												l.end_time = line.start_time + word.start_time + add_end
											elseif mode == "postword" then
												l.start_time = line.start_time + word.end_time + add_start
												l.end_time = line.start_time + word.start_time + add_end
											elseif mode == "start2word"	then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + word.start_time + add_end
											elseif mode == "word2end" then
												l.start_time = line.start_time + word.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "linepct" then
												l.start_time = line.start_time + add_start*line.duration/100
												l.end_time = line.start_time + add_end*line.duration/100
											elseif mode == "wordpct" then
												l.start_time = line.start_time + word.start_time + add_start*word.duration/100
												l.end_time = line.start_time + word.start_time + add_end*word.duration/100
											elseif mode == "set" or mode == "abs" then
												l.start_time = add_start
												l.end_time = add_end
											elseif mode == "fxpretime" then
												l.start_time = fx.start_time + add_start
												l.end_time = fx.start_time + add_end
											elseif mode == "fxtime" then
												l.start_time = fx.start_time + add_start
												l.end_time = fx.end_time + add_end
											elseif mode == "fxposttime"	then
												l.start_time = fx.end_time + add_start
												l.end_time = fx.end_time + add_end
											elseif mode == "fxpct" then
												l.start_time = fx.start_time + add_start*fx.dur/100
												l.end_time = fx.start_time + add_end*fx.dur/100
											end
											fx.start_time, fx.end_time = l.start_time, l.end_time
											fx.dur = fx.end_time - fx.start_time
											return ""
										end
										---------------------------------------------------
										without = { }
										ini = line.start_time - fx.start_time
										without.word = format("\\t(%s,%s,\\1a&HFF&\\3a&HFF&\\4a&HFF&)\\t(%s,%s,\\1a%s\\3a%s\\4a%s)", ini + word.start_time, ini + word.start_time + 1, ini + word.end_time, ini + word.end_time + 1, text.alpha1, text.alpha3, text.alpha4)
										word.word_start = ini + word.start_time
										word.word_end = word.word_start + word.dur
										--variables de punto de referencia--
										center_x1 = loadstring("return function(fx__, meta, syl, line, x, y, module) return {".. fx__.center_x .."} end")( )
										center_x = center_x1( fx__, meta, syl, line, x, y, module )
										if #center_x > 0 then
											fx.center_x = center_x[1]
										else
											fx.center_x = val_center
										end
										center_y1 = loadstring("return function(fx__, meta, syl, line, x, y, module) return {".. fx__.center_y .."} end")( )
										center_y = center_y1( fx__, meta, syl, line, x, y, module )
										if #center_y > 0 then
											fx.center_y = center_y[1]
										else
											fx.center_y = val_middle
										end
										--variables de escalas de funciones paramétricas-- 
										if j == 1 then
											scale_x1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.scale_x .."} end")( )
											scale_x	= scale_x1( fx__, meta, syl, line )
											if #scale_x > 0 then
												fx.scale_x = scale_x[1]
											else
												fx.scale_x = 1
											end
											if fx.scale_x <= 0 then
												fx.scale_x = 0.1
											end
											scale_y1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.scale_y .."} end")( )
											scale_y	= scale_y1( fx__, meta, syl, line )
											if #scale_y > 0 then
												fx.scale_y = scale_y[1]
											else
												fx.scale_y = 1
											end
											if fx.scale_y <= 0 then
												fx.scale_y = 0.1
											end
										end
										offset_maxspace = scale_x[2] or 0
										--variables de dominio de funciones--
										if j == 1 then
											s_i1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.s_i .."} end")( )
											s_i = s_i1( fx__, meta, syl, line )
											if #s_i > 0 then
												fx.domain_i = s_i[1]
											else
												fx.domain_i = 0
											end
											s_f1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.s_f .."} end")( )
											s_f = s_f1( fx__, meta, syl, line )
											if #s_f > 0 then
												fx.domain_f = s_f[1]
											else
												fx.domain_f = 1
											end
										end
										local s = fx.domain_i + module*(fx.domain_f - fx.domain_i)
										--variables de funciones paramétricas--
										fun_x1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.fun_x .."} end")( )
										fun_x = fun_x1( fx__, meta, syl, line, s )
										if #fun_x > 0 then
											fx.fun_x = fun_x[1]*fx.scale_x
										else
											fx.fun_x = 0
										end
										fun_y1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.fun_y .."} end")( )
										fun_y = fun_y1( fx__, meta, syl, line, s )
										if #fun_y > 0 then
											fx.fun_y = fun_y[1]*fx.scale_y
										else
											fx.fun_y = 0
										end
										--definir las posiciones iniciales--
										fx.pos_x = fx.center_x
										fx.pos_y = fx.center_y
										fx.off_x, fx.off_y = effector.modify_pos( )
										--variables de posiciones--
										fx.pos_x = fx.pos_x + fx.fun_x - fx.off_x
										fx.pos_y = fx.pos_y + fx.fun_y - fx.off_y
										fx.pos_l = fx.pos_x - word.width/2
										fx.pos_r = fx.pos_x + word.width/2
										fx.pos_t = fx.pos_y - word.height/2
										fx.pos_b = fx.pos_y + word.height/2
										x, y = fx.pos_x, fx.pos_y
										--variables de tamaño--
										if fx__.size ~= nil and fx__.size ~= "" then
											size1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.size .."} end")( )
											size = size1( fx__, meta, syl, line, s )
											if #size == 1 then
												fx.sizex = math.round(size[1], 2)
												fx.sizey = fx.sizex
											elseif #size == 2 then
												fx.sizex = math.round(size[1], 2)
												fx.sizey = math.round(size[2], 2)
											end
											fx.tag_size = format("\\fscx%s\\fscy%s", fx.sizex, fx.sizey)
										else
											fx.sizex = L.scale_x
											fx.sizey = L.scale_y
											fx.tag_size = ""
										end
										--variables de alineación y de capa (layer)--
										align1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.align .."} end")( )
										align = align1( fx__, meta, syl, line, s, module )
										if #align > 0 then
											fx.align = "\\an"..align[1]
										else
											fx.align = ""
										end
										layer1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.layer .."} end")( )
										layer = layer1( fx__, meta, syl, line, s, module )
										fx.layer = layer[1] or l_layer
										--variables de posiciones, dependiendo del "move"--
										move_x11 = loadstring("return function(fx__, meta, syl, line, x, y, s, module) return {".. fx__.move_x .."} end")( )
										move_x = math.round(move_x11( fx__, meta, syl, line, x, y, s, module ), 2)
										move_y11 = loadstring("return function(fx__, meta, syl, line, x, y, s, module) return {".. fx__.move_y .."} end")( )
										move_y = math.round(move_y11( fx__, meta, syl, line, x, y, s, module ), 2)
										--variables de tiempo del movimiento--
										fx__.move_t = fx__.move_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										move_t1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.move_t .."} end")( )
										move_t = move_t1( fx__, meta, syl, line, s, module )
										fx.movet_i = math.round(move_t[1] or 0, 2)
										fx.movet_f = math.round(move_t[2] or fx.dur, 2)
										if #move_t > 0 then
											tags_times = ","..tostring(fx.movet_i)..","..tostring(fx.movet_f)
										else
											tags_times = ""
										end
										--posiciones finales--
										Nmove = math.max(#move_x, #move_y)
										fx.move_x1 = math.round(move_x[1] or fx.pos_x, 2)
										fx.move_y1 = math.round(move_y[1] or fx.pos_y, 2)
										fx.move_x2 = math.round(move_x[2] or fx.move_x1, 2)
										fx.move_y2 = math.round(move_y[2] or fx.move_y1, 2)
										fx.move_x3 = math.round(move_x[3] or fx.move_x2, 2)
										fx.move_y3 = math.round(move_y[3] or fx.move_y2, 2)
										fx.move_x4 = math.round(move_x[4] or fx.move_x3, 2)
										fx.move_y4 = math.round(move_y[4] or fx.move_y3, 2)
										fx.angle1 = fx.move_x3
										fx.angle2 = fx.move_x4
										fx.radius1 = math.round(move_x[5] or fx.pos_x, 2)
										fx.radius2 = math.round(move_x[6] or fx.radius1, 2)
										tb_pos = {fx.move_x1, fx.move_y1, fx.move_x2, fx.move_y2, fx.move_x3, fx.move_y3, fx.move_x4, fx.move_y4, fx.angle1, fx.angle2, fx.radius1, fx.radius2}
										fx.move_l1, fx.move_r1, fx.move_t1, fx.move_b1 = fx.move_x1 - val_width/2, fx.move_x1 + val_width/2, fx.move_y1 - val_height/2, fx.move_y1 + val_height/2
										fx.move_l2, fx.move_r2, fx.move_t2, fx.move_b2 = fx.move_x2 - val_width/2, fx.move_x2 + val_width/2, fx.move_y2 - val_height/2, fx.move_y2 + val_height/2
										fx.move_l3, fx.move_r3, fx.move_t3, fx.move_b3 = fx.move_x3 - val_width/2, fx.move_x3 + val_width/2, fx.move_y3 - val_height/2, fx.move_y3 + val_height/2
										fx.move_l4, fx.move_r4, fx.move_t4, fx.move_b4 = fx.move_x4 - val_width/2, fx.move_x4 + val_width/2, fx.move_y4 - val_height/2, fx.move_y4 + val_height/2
										fx.pos = effector.pos( Nmove, tb_pos, tags_times )
										fx_start, fx_end, fx_mid, fx_dur, fx_i, fx_n, fx_x, fx_y = fx.start_time, fx.end_time, fx.start_time + fx.dur/2, fx.dur, j, maxj, fx.move_x1, fx.move_y1
										fx_left, fx_center, fx_right, fx_width, fx_top, fx_middle, fx_bottom, fx_height = fx.move_l1, fx.move_x1, fx.move_r1, fx.move_r1 - fx.move_l1, fx.move_t1, fx.move_y1, fx.move_b1, fx.move_b1 - fx.move_t1
										if pcall(loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")) == true then
											returnfx1 = loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")( )
											returnfx = returnfx1( fx__, meta, syl, line )
										else
											returnfx = { [1] = fx__.returnfx }
										end
										Rline = 1
										if returnfx[2] and returnfx[2] == "random" then
											Rline = 2 - R(count_fx + 1)
										end
										if #returnfx > 0 or returnfx[1] ~= nil then
											if returnfx[1]:match("m %-?%d+[%.%d+]* %-?%d+[%.%d+]*") then
												fx.Det = "\\p1"
												if returnfx[1]:match("\\p%d") then
													fx.Det = ""
												end
												tags_style = shape.style
											else
												fx.Det = ""
												tags_style = text.style
											end
											if (fx.Det == "\\p1" or returnfx[1]:match("\\p%d")) and fx.tag_size == "" then
												fx.tag_size = "\\fscx100\\fscy100"
											end
											if fx__.language ~= "Automation Auto-4" then
													addtag1 = loadstring("return function(fx__, meta, line, x, y, module) return {".. tag.HTML_to_ass(fx__.addtag) .."} end")( )
													addtag = addtag1( fx__, meta, line, x, y, module )
													fx.add_tags = tag.do_tag( table.op(addtag, "concat") )
												else
													fx.add_tags = tag.to_Auto4( tag.HTML_to_ass(fx__.addtag) )
												end
											if fxgroup == true then
												if fx__.modify == false and fx__.namefx ~= "raw" then
													l.text = fx.tm(format("{%s %s: %s [line origin: %s - line fx: %s] %s%s%s%s%s%s}%s", script_name, script_version, fx__.effect:gsub("%S+[%-%S+]*%[fx%]: ", ""), ii, count_fx + 1, fx.align, fx.pos, tags_style, fx.tag_size, fx.add_tags, fx.Det, returnfx[1]))
													l.effect = "Effector [Fx]"
													l.layer = fx.layer
													l.actor = actor_fx
													subs.insert( #subs + Rline, l )
													count_fx = count_fx + 1
												elseif fx__.modify == false and fx__.namefx == "raw" then
													l.text = fx.tm(returnfx[1])
													subs.insert( #subs + Rline, l )
													count_fx = count_fx + 1
												else
													lines_comment = false
													line.start_time = fx.start_time
													line.end_time = fx.end_time
													line.text = fx.tm(format("{%s}%s", fx.add_tags, returnfx[1]))
												end
											end
										end
										j = j + 1
										aegisub.progress.task(F("Lines: [%d/%d]  Progress: [%s%%]  Lines Generated: %d", count_ln, #idx_line, math.round(100*count_ln/#idx_line, 2), count_fx))
										aegisub.progress.set(100*line.i/line.n)
									end
									left = left + widtht
									word.i = word.i + 1
								end
								J = J + 1
							end
						end

						if fx__.t_type == "Translation Char" then
							-----------------------------------------------
							for cfxt in unicode.chars(line.text_stripped:gsub("\\N", " "):gsub("  ", " ")) do
								char.text = cfxt
								char.text_stripped = cfxt
								width, height, descent, extlead = aegisub.text_extents(line.styleref, char.text)
								char.width = width
								char.height = height
								char.top = l.top
								char.middle = l.middle
								char.bottom = l.bottom
								char.left = left
								char.right = left + char.width
								char.center = left + char.width/2
								char.start_time = line.duration*(char.i - 1)/char.n
								char.end_time = line.duration*(char.i - 0)/char.n
								char.duration = char.end_time - char.start_time
								char.dur = char.duration
								char.mid_time = char.start_time + char.dur/2
								char.widthmax = math.max(unpack(mmwth[ii].ch))
								char.widthmin = math.min(unpack(mmwth[ii].ch))
								char.durmax = math.max(unpack(mmdur[ii].ch))
								char.durmin = math.min(unpack(mmdur[ii].ch))
								-----------------------------------------------
								val_width, val_height, val_text = char.width, char.height, char.text
								val_center, val_middle, val_left, val_right = char.center, char.middle, char.left, char.right
								val_top, val_bottom, val_dur = char.top, char.bottom, char.duration
								val_start, val_end, val_mid  = char.start_time, char.end_time, char.start_time + char.duration/2
								val_i, val_n = char.i, char.n
								shape.trapeze1t = format("m 0 0 l 0 %d l %d %d l %d 0 ", char.height, char.width, char.height, char.width + char.height)
								shape.trapeze1b = format("m 0 0 l 0 %d l %d %d l %d 0 ", char.height, char.width + char.height, char.height, char.width)
								---------------------------------------------------
								W_ = aegisub.word(line.text, line.dur, aegisub.word2c( ))
								---------------------------------------------------
								word_start, word_end, word_mid, word_dur, word_i, word_n, word_left, word_center, word_right, word_bottom, word_middle, word_top, word_width, word_height = word.start_time, word.end_time, word.mid_time, word.dur, word.i, word.n, word.left, word.center, word.right, word.bottom, word.middle, word.top, word.width, word.height
								syl_start,  syl_end,  syl_mid,  syl_dur,  syl_i,  syl_n,  syl_left,  syl_center,  syl_right,  syl_bottom,  syl_middle,  syl_top,  syl_width,  syl_height  = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								furi_start, furi_end, furi_mid, furi_dur, furi_i, furi_n, furi_left, furi_center, furi_right, furi_bottom, furi_middle, furi_top, furi_width, furi_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								hira_start, hira_end, hira_mid, hira_dur, hira_i, hira_n, hira_left, hira_center, hira_right, hira_bottom, hira_middle, hira_top, hira_width, hira_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								kata_start, kata_end, kata_mid, kata_dur, kata_i, kata_n, kata_left, kata_center, kata_right, kata_bottom, kata_middle, kata_top, kata_width, kata_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								roma_start, roma_end, roma_mid, roma_dur, roma_i, roma_n, roma_left, roma_center, roma_right, roma_bottom, roma_middle, roma_top, roma_width, roma_height = val_start, val_end, val_mid, val_dur, val_i, val_n, val_left, val_center, val_right, val_bottom, val_middle, val_top, val_width, val_height
								char_start, char_end, char_mid, char_dur, char_i, char_n, char_left, char_center, char_right, char_bottom, char_middle, char_top, char_width, char_height = char.start_time, char.end_time, char.mid_time, char.dur, char.i, char.n, char.left, char.center, char.right, char.bottom, char.middle, char.top, char.width, char.height
								---------------------------------------------------
								wordchar = { }
								wordchar.i, wordchar.n = aegisub.wordci(char.i)
								syl = word
								---------------------------------------------------
								fx.replay_fx, J = 1, 1
								maxJ = fx.replay_fx
								while J <= fx.replay_fx do
									j = 1
									if fx.replay_fx == 1 then
										moduler = 0
									else
										moduler = (J - 1)/(maxJ - 1)
									end
									module = 0
									module1 = module
									module2 = module1
									fxgroup = true
									-----------------------------------------------
									effector.default_val( )
									-----------------------------------------------
									if pcall(loadstring("return function(fx__, meta, syl, line, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")) == true then
										variable_ = loadstring("return function(fx__, meta, syl, line, x, y) ".. tag.HTML_to_ass(fx__.variable) .." return '' end")( )
										var_KEfx_ = variable_( fx__, meta, syl, line, x, y )
									end
									variable_ = loadstring("return function(fx__, meta, syl, line, x, y) return {".. tag.HTML_to_ass(fx__.variable) .."} end")( )
									if line.i == 1 and char.i == 1 and J == 1 then
										var.once = remember("v_once", variable_( fx__, meta, syl, line, x, y ))
									else
										var.once = recall.v_once
									end
									if char.i == 1 and J == 1 then
										var.line = variable_( fx__, meta, syl, line, x, y )
									end
									if wordchar.i == 1 and J == 1 then
										var.word = variable_( fx__, meta, syl, line, x, y )
									end
									if J == 1 then
										var.rep = variable_( fx__, meta, syl, line, x, y )
									end
									var.char = variable_( fx__, meta, syl, line, x, y )
									var.syl, var.furi = var.char, var.char
									var.loop = variable_( fx__, meta, syl, line, x, y )
									text.char_size( )
									-----------------------------------------------
									maxloop1 = loadstring("return function(fx__, meta, syl, line, x, y) return {".. fx__.loops .."} end")( )
									maxloop_fx = maxloop1( fx__, meta, syl, line, x, y )
									loop_h = ceil((maxloop_fx[1] or 1)*(char.width + 2*L.outline)/(char.height + 2*L.outline))
									maxloop_fx = maxloop1( fx__, meta, syl, line, x, y )
									fx.loop_v = maxloop_fx[1] or 1
									fx.loop_h = maxloop_fx[2] or 1
									fx.loop_3 = maxloop_fx[3] or 1
									fx.maxloop_fx = fx.loop_v*fx.loop_h*fx.loop_3
									maxj = fx.maxloop_fx
									-----------------------------------------------
									while j <= fx.maxloop_fx do
										ci = 0
										var.loop = variable_( fx__, meta, syl, line, x, y )
										--variables de modulo--
										if fx.maxloop_fx == 1 then
											module = 0
										else
											module = (j - 1)/(maxj - 1)
										end
										if char.n == 1 then
											module1 = module
										else
											module1 = (char.i + module - 1)/(char.n + module - 1)
										end
										if line.n == 1 then
											module2 = module1
										else
											module2 = (line.i + module1 - 1)/(line.n + module1 - 1)
										end
										--variables de tiempo--
										fx__.start_t = fx__.start_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										fx__.end_t = fx__.end_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										start_t1 = loadstring("return function(fx__, meta, syl, line, module) return {".. fx__.start_t .."} end")( )
										start_t	= start_t1( fx__, meta, syl, line, module )
										if #start_t > 0 then
											fx.start_time = start_t[1]
										else
											fx.start_time = line.start_time
										end
										l.start_time = fx.start_time
										end_t1 = loadstring("return function(fx__, meta, syl, line, module) return {".. fx__.end_t .."} end")( )
										end_t = end_t1( fx__, meta, syl, line, module )
										if #end_t > 0 then
											fx.end_time = end_t[1]
										else
											fx.end_time = line.end_time
										end
										l.end_time = fx.end_time
										fx.dur = fx.end_time - fx.start_time
										function retime( mode, add_start, add_end )
											add_start = HMS_to_ms( add_start ) or 0
											add_end = HMS_to_ms( add_end ) or 0
											if mode == "line" then
												l.start_time = line.start_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "preline" then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + add_end
											elseif mode == "postline" then
												l.start_time = line.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "word" then
												l.start_time = line.start_time + word.start_time + add_start
												l.end_time = line.start_time + word.end_time + add_end
											elseif mode == "preword" then
												l.start_time = line.start_time + word.start_time + add_start
												l.end_time = line.start_time + word.start_time + add_end
											elseif mode == "postword" then
												l.start_time = line.start_time + word.end_time + add_start
												l.end_time = line.start_time + word.start_time + add_end
											elseif mode == "char" then
												l.start_time = line.start_time + char.start_time + add_start
												l.end_time = line.start_time + char.end_time + add_end
											elseif mode == "prechar" then
												l.start_time = line.start_time + char.start_time + add_start
												l.end_time = line.start_time + char.start_time + add_end
											elseif mode == "postchar" then
												l.start_time = line.start_time + char.end_time + add_start
												l.end_time = line.start_time + char.start_time + add_end
											elseif mode == "start2word"	then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + word.start_time + add_end
											elseif mode == "word2end" then
												l.start_time = line.start_time + word.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "start2char"	then
												l.start_time = line.start_time + add_start
												l.end_time = line.start_time + char.start_time + add_end
											elseif mode == "char2end" then
												l.start_time = line.start_time + char.end_time + add_start
												l.end_time = line.end_time + add_end
											elseif mode == "linepct" then
												l.start_time = line.start_time + add_start*line.duration/100
												l.end_time = line.start_time + add_end*line.duration/100
											elseif mode == "wordpct" then
												l.start_time = line.start_time + word.start_time + add_start*word.duration/100
												l.end_time = line.start_time + word.start_time + add_end*word.duration/100
											elseif mode == "charpct" then
												l.start_time = line.start_time + char.start_time + add_start*char.duration/100
												l.end_time = line.start_time + char.start_time + add_end*char.duration/100
											elseif mode == "set" or mode == "abs" then
												l.start_time = add_start
												l.end_time = add_end
											elseif mode == "fxpretime" then
												l.start_time = fx.start_time + add_start
												l.end_time = fx.start_time + add_end
											elseif mode == "fxtime" then
												l.start_time = fx.start_time + add_start
												l.end_time = fx.end_time + add_end
											elseif mode == "fxposttime"	then
												l.start_time = fx.end_time + add_start
												l.end_time = fx.end_time + add_end
											elseif mode == "fxpct" then
												l.start_time = fx.start_time + add_start*fx.dur/100
												l.end_time = fx.start_time + add_end*fx.dur/100
											end
											fx.start_time, fx.end_time = l.start_time, l.end_time
											fx.dur = fx.end_time - fx.start_time
											return ""
										end
										---------------------------------------------------
										without = { }
										ini = line.start_time - fx.start_time
										without.char = format("\\t(%s,%s,\\1a&HFF&\\3a&HFF&\\4a&HFF&)\\t(%s,%s,\\1a%s\\3a%s\\4a%s)", ini + char.start_time, ini + char.start_time + 1, ini + char.end_time, ini + char.end_time + 1, text.alpha1, text.alpha3, text.alpha4)
										char.char_start = ini + char.start_time
										char.char_end = char.char_start + char.dur
										--variables de punto de referencia--
										center_x1 = loadstring("return function(fx__, meta, syl, line, x, y, module) return {".. fx__.center_x .."} end")( )
										center_x = center_x1( fx__, meta, syl, line, x, y, module )
										if #center_x > 0 then
											fx.center_x = center_x[1]
										else
											fx.center_x = val_center
										end
										center_y1 = loadstring("return function(fx__, meta, syl, line, x, y, module) return {".. fx__.center_y .."} end")( )
										center_y = center_y1( fx__, meta, syl, line, x, y, module )
										if #center_y > 0 then
											fx.center_y = center_y[1]
										else
											fx.center_y = val_middle
										end
										--variables de escalas de funciones paramétricas-- 
										if j == 1 then
											scale_x1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.scale_x .."} end")( )
											scale_x	= scale_x1( fx__, meta, syl, line )
											if #scale_x > 0 then
												fx.scale_x = scale_x[1]
											else
												fx.scale_x = 1
											end
											if fx.scale_x <= 0 then
												fx.scale_x = 0.1
											end
											scale_y1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.scale_y .."} end")( )
											scale_y	= scale_y1( fx__, meta, syl, line )
											if #scale_y > 0 then
												fx.scale_y = scale_y[1]
											else
												fx.scale_y = 1
											end
											if fx.scale_y <= 0 then
												fx.scale_y = 0.1
											end
										end
										offset_maxspace = scale_x[2] or 0
										--variables de dominio de funciones--
										if j == 1 then
											s_i1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.s_i .."} end")( )
											s_i = s_i1( fx__, meta, syl, line )
											if #s_i > 0 then
												fx.domain_i = s_i[1]
											else
												fx.domain_i = 0
											end
											s_f1 = loadstring("return function(fx__, meta, syl, line) return {".. fx__.s_f .."} end")( )
											s_f = s_f1( fx__, meta, syl, line )
											if #s_f > 0 then
												fx.domain_f = s_f[1]
											else
												fx.domain_f = 1
											end
										end
										local s = fx.domain_i + module*(fx.domain_f - fx.domain_i)
										--variables de funciones paramétricas--
										fun_x1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.fun_x .."} end")( )
										fun_x = fun_x1( fx__, meta, syl, line, s )
										if #fun_x > 0 then
											fx.fun_x = fun_x[1]*fx.scale_x
										else
											fx.fun_x = 0
										end
										fun_y1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.fun_y .."} end")( )
										fun_y = fun_y1( fx__, meta, syl, line, s )
										if #fun_y > 0 then
											fx.fun_y = fun_y[1]*fx.scale_y
										else
											fx.fun_y = 0
										end
										--definir las posiciones iniciales--
										fx.pos_x = fx.center_x
										fx.pos_y = fx.center_y
										fx.off_x, fx.off_y = effector.modify_pos( )
										--variables de posiciones--
										fx.pos_x = fx.pos_x + fx.fun_x - fx.off_x
										fx.pos_y = fx.pos_y + fx.fun_y - fx.off_y
										fx.pos_l = fx.pos_x - char.width/2
										fx.pos_r = fx.pos_x + char.width/2
										fx.pos_t = fx.pos_y - char.height/2
										fx.pos_b = fx.pos_y + char.height/2
										x, y = fx.pos_x, fx.pos_y
										--variables de tamaño--
										if fx__.size ~= nil and fx__.size ~= "" then
											size1 = loadstring("return function(fx__, meta, syl, line, s) return {".. fx__.size .."} end")( )
											size = size1( fx__, meta, syl, line, s )
											if #size == 1 then
												fx.sizex = math.round(size[1], 2)
												fx.sizey = fx.sizex
											elseif #size == 2 then
												fx.sizex = math.round(size[1], 2)
												fx.sizey = math.round(size[2], 2)
											end
											fx.tag_size = format("\\fscx%s\\fscy%s", fx.sizex, fx.sizey)
										else
											fx.sizex = L.scale_x
											fx.sizey = L.scale_y
											fx.tag_size = ""
										end
										--variables de alineación y de capa (layer)--
										align1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.align .."} end")( )
										align = align1( fx__, meta, syl, line, s, module )
										if #align > 0 then
											fx.align = "\\an"..align[1]
										else
											fx.align = ""
										end
										layer1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.layer .."} end")( )
										layer = layer1( fx__, meta, syl, line, s, module )
										fx.layer = layer[1] or l_layer
										--variables de posiciones, dependiendo del "move"--
										move_x11 = loadstring("return function(fx__, meta, syl, line, x, y, s, module) return {".. fx__.move_x .."} end")( )
										move_x = math.round(move_x11( fx__, meta, syl, line, x, y, s, module ), 2)
										move_y11 = loadstring("return function(fx__, meta, syl, line, x, y, s, module) return {".. fx__.move_y .."} end")( )
										move_y = math.round(move_y11( fx__, meta, syl, line, x, y, s, module ), 2)
										--variables de tiempo del movimiento--
										fx__.move_t = fx__.move_t:gsub("(%d+%:%d+%:%d+%.%d+)",
											function( time_HMS )
												return tostring( HMS_to_ms( time_HMS ) )
											end
										)
										move_t1 = loadstring("return function(fx__, meta, syl, line, s, module) return {".. fx__.move_t .."} end")( )
										move_t = move_t1( fx__, meta, syl, line, s, module )
										fx.movet_i = math.round(move_t[1] or 0, 2)
										fx.movet_f = math.round(move_t[2] or fx.dur, 2)
										if #move_t > 0 then
											tags_times = ","..tostring(fx.movet_i)..","..tostring(fx.movet_f)
										else
											tags_times = ""
										end
										--posiciones finales--
										Nmove = math.max(#move_x, #move_y)
										fx.move_x1 = math.round(move_x[1] or fx.pos_x, 2)
										fx.move_y1 = math.round(move_y[1] or fx.pos_y, 2)
										fx.move_x2 = math.round(move_x[2] or fx.move_x1, 2)
										fx.move_y2 = math.round(move_y[2] or fx.move_y1, 2)
										fx.move_x3 = math.round(move_x[3] or fx.move_x2, 2)
										fx.move_y3 = math.round(move_y[3] or fx.move_y2, 2)
										fx.move_x4 = math.round(move_x[4] or fx.move_x3, 2)
										fx.move_y4 = math.round(move_y[4] or fx.move_y3, 2)
										fx.angle1 = fx.move_x3
										fx.angle2 = fx.move_x4
										fx.radius1 = math.round(move_x[5] or fx.pos_x, 2)
										fx.radius2 = math.round(move_x[6] or fx.radius1, 2)
										tb_pos = {fx.move_x1, fx.move_y1, fx.move_x2, fx.move_y2, fx.move_x3, fx.move_y3, fx.move_x4, fx.move_y4, fx.angle1, fx.angle2, fx.radius1, fx.radius2}
										fx.move_l1, fx.move_r1, fx.move_t1, fx.move_b1 = fx.move_x1 - val_width/2, fx.move_x1 + val_width/2, fx.move_y1 - val_height/2, fx.move_y1 + val_height/2
										fx.move_l2, fx.move_r2, fx.move_t2, fx.move_b2 = fx.move_x2 - val_width/2, fx.move_x2 + val_width/2, fx.move_y2 - val_height/2, fx.move_y2 + val_height/2
										fx.move_l3, fx.move_r3, fx.move_t3, fx.move_b3 = fx.move_x3 - val_width/2, fx.move_x3 + val_width/2, fx.move_y3 - val_height/2, fx.move_y3 + val_height/2
										fx.move_l4, fx.move_r4, fx.move_t4, fx.move_b4 = fx.move_x4 - val_width/2, fx.move_x4 + val_width/2, fx.move_y4 - val_height/2, fx.move_y4 + val_height/2
										fx.pos = effector.pos( Nmove, tb_pos, tags_times )
										fx_start, fx_end, fx_mid, fx_dur, fx_i, fx_n, fx_x, fx_y = fx.start_time, fx.end_time, fx.start_time + fx.dur/2, fx.dur, j, maxj, fx.move_x1, fx.move_y1
										fx_left, fx_center, fx_right, fx_width, fx_top, fx_middle, fx_bottom, fx_height = fx.move_l1, fx.move_x1, fx.move_r1, fx.move_r1 - fx.move_l1, fx.move_t1, fx.move_y1, fx.move_b1, fx.move_b1 - fx.move_t1
										if pcall(loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")) == true then
											returnfx1 = loadstring("return function(fx__, meta, syl, line) return {".. tag.HTML_to_ass(fx__.returnfx) .."} end")( )
											returnfx = returnfx1( fx__, meta, syl, line )
										else
											returnfx = { [1] = fx__.returnfx }
										end
										Rline = 1
										if returnfx[2] and returnfx[2] == "random" then
											Rline = 2 - R(count_fx + 1)
										end
										if fx__.noblank == true and (returnfx[1] == "" or returnfx[1] == " ") then
											returnfx[1] = nil
										end
										if #returnfx > 0 or returnfx[1] ~= nil then
											if returnfx[1]:match("m %-?%d+[%.%d+]* %-?%d+[%.%d+]*") then
												fx.Det = "\\p1"
												if returnfx[1]:match("\\p%d") then
													fx.Det = ""
												end
												tags_style = shape.style
											else
												fx.Det = ""
												tags_style = text.style
											end
											if (fx.Det == "\\p1" or returnfx[1]:match("\\p%d")) and fx.tag_size == "" then
												fx.tag_size = "\\fscx100\\fscy100"
											end
											if fx__.language ~= "Automation Auto-4" then
												addtag1 = loadstring("return function(fx__, meta, line, x, y, module) return {".. tag.HTML_to_ass(fx__.addtag) .."} end")( )
												addtag = addtag1( fx__, meta, line, x, y, module )
												fx.add_tags = tag.do_tag( table.op(addtag, "concat") )
											else
												fx.add_tags = tag.to_Auto4( tag.HTML_to_ass(fx__.addtag) )
											end
											if fxgroup == true then
												if fx__.modify == false and fx__.namefx ~= "raw" then
													l.text = fx.tm(format("{%s %s: %s [line origin: %s - line fx: %s] %s%s%s%s%s%s}%s", script_name, script_version, fx__.effect:gsub("%S+[%-%S+]*%[fx%]: ", ""), ii, count_fx + 1, fx.align, fx.pos, tags_style, fx.tag_size, fx.add_tags, fx.Det, returnfx[1]))
													l.effect = "Effector [Fx]"
													l.layer = fx.layer
													l.actor = actor_fx
													subs.insert( #subs + Rline, l )
													count_fx = count_fx + 1
												elseif fx__.modify == false and fx__.namefx == "raw" then
													l.text = fx.tm(returnfx[1])
													subs.insert( #subs + Rline, l )
													count_fx = count_fx + 1
												else
													lines_comment = false
													line.start_time = fx.start_time
													line.end_time = fx.end_time
													line.text = fx.tm(format("{%s}%s", fx.add_tags, returnfx[1]))
												end
											end
											ci = 1
										end
										j = j + 1
										aegisub.progress.task(F("Lines: [%d/%d]  Progress: [%s%%]  Lines Generated: %d", count_ln, #idx_line, math.round(100*count_ln/#idx_line, 2), count_fx))
										aegisub.progress.set(100*line.i/line.n)
									end
									J = J + 1
								end
								left = left + width
								char.i = char.i + ci
							end
						end
					end
				end
			end
		end
	end

	--lead-in FX List
	Agitation_Char = table.duplicate(PfxM_Box); table.inbox(Agitation_Char, "lead-in[fx]: Agitation Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 + 8)","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x - char.height, fx.pos_x","fx.pos_y, fx.pos_y","0, 400","1","","char.text","tag.oscill(450, 150, '\\\\fsvp'..var.char.dy, '\\\\fsvp'..-var.char.dy, '\\\\fsvp0'), '\\\\fad(150,0)'","dy = 7*ratio"); table.insert(leadin_fx_library, Agitation_Char); table.insert(leadin_fx, "Agitation Char")
	Asault = table.duplicate(PfxM_Box); table.inbox(Asault, "lead-in[fx]: Asault","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.loop.delay","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y - var.syl.d, fx.pos_y","200, 400","1","","char.text","format('\\\\org(%s,%s)\\\\frx180\\\\fscx%s\\\\fscy%s\\\\blur3\\\\t(0,400,0.5,\\\\frx0\\\\fscx%s\\\\blur0)\\\\t(0,400,\\\\fscy%s)\\\\fad(150,0)', fx.pos_x, fx.pos_y, 0.3*l.scale_x, 3*l.scale_y, l.scale_x, l.scale_y)","delay = R(400, 800), d = 100"); table.insert(leadin_fx_library, Asault); table.insert(leadin_fx, "Asault")
	Asault_Sequence_Char = table.duplicate(PfxM_Box); table.inbox(Asault_Sequence_Char, "lead-in[fx]: Asault Sequence Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - var.loop.delay","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y - var.syl.d, fx.pos_y","200, 400","1","","char.text","format('\\\\org(%s,%s)\\\\frx180\\\\fscx%s\\\\fscy%s\\\\blur3\\\\t(0,400,0.5,\\\\frx0\\\\fscx%s\\\\blur0)\\\\t(0,400,\\\\fscy%s)\\\\fad(150,0)', fx.pos_x, fx.pos_y, 0.3*l.scale_x, 3*l.scale_y, l.scale_x, l.scale_y)","delay = R(400, 800), d = 100*ratio"); table.insert(leadin_fx_library, Asault_Sequence_Char); table.insert(leadin_fx, "Asault Sequence Char")
	Asault_Line_I = table.duplicate(PfxM_Box); table.inbox(Asault_Line_I, "lead-in[fx]: Asault Line I","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.syl.delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x - var.syl.d1, fx.pos_x","fx.pos_y, fx.pos_y","0, var.syl.delay","1","","syl.text","format('\\\\org(%s,%s)\\\\frx-180\\\\t(0,%s,\\\\frx0)\\\\fad(300,0)', fx.pos_x - var.syl.d2*(1 - 2*(syl.i - 1)/(syl.n - 2)), fx.pos_y + var.syl.d2/2, var.syl.delay)","delay = 500, d1 = 150*ratio*(1 - 2*(syl.i - 1)/(syl.n - 2)), d2 = 100*ratio"); table.insert(leadin_fx_library, Asault_Line_I); table.insert(leadin_fx, "Asault Line I")
	Asault_Line_II = table.duplicate(PfxM_Box); table.inbox(Asault_Line_II, "lead-in[fx]: Asault Line II","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.syl.delay + 25*(syl.i - syl.n -1)","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x - var.syl.d1, fx.pos_x","fx.pos_y, fx.pos_y","0, var.syl.delay","1","","syl.text","format('\\\\org(%s,%s)\\\\frx-180\\\\t(0,%s,\\\\frx0)\\\\fad(300,0)', fx.pos_x - var.syl.d2*(1 - 2*(syl.i - 1)/(syl.n - 2)), fx.pos_y + var.syl.d2/2, var.syl.delay)","delay = 500, d1 = 150*ratio*(1 - 2*(syl.i - 1)/(syl.n - 2)), d2 = 100*ratio"); table.insert(leadin_fx_library, Asault_Line_II); table.insert(leadin_fx, "Asault Line II")
	Char_Random_LI = table.duplicate(PfxM_Box); table.inbox(Char_Random_LI, "lead-in[fx]: Char Random LI","Char",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time + time_li(30) + delay*(j - 1)","tag.only( j == maxj, l.start_time + syl.start_time, fx.start_time + delay)","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","5","","tag.only( j == maxj, char.text, string.char(R(56,99)))","tag.only(j ~= maxj, format('\\\\alpha%s\\\\t(\\\\alpha%s)', alpha.interpolate('&HFF&', '&H00&', (j-1)/maxj), alpha.interpolate('&HFF&', '&H00&', j/maxj)))","delay = 80","Lua",false); table.insert(leadin_fx_library, Char_Random_LI); table.insert(leadin_fx, "Char Random LI")
	Char_Random_LI_II = table.duplicate(PfxM_Box); table.inbox(Char_Random_LI_II, "lead-in[fx]: Char Random LI II","Char",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time + delay*(j - 1) + var.syl.delay2 - delay*maxj","tag.only( j == maxj, l.start_time + syl.start_time, fx.start_time + delay)","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","5","","tag.only( j == maxj, char.text, string.char(R(56,99)))","tag.only(j ~= maxj, format('\\\\alpha%s\\\\t(\\\\alpha%s)', alpha.interpolate('&HFF&', '&H00&', (j-1)/maxj), alpha.interpolate('&HFF&', '&H00&', j/maxj)))","delay = 2*frame_dur; delay2 = R(-300,100)","Lua",false); table.insert(leadin_fx_library, Char_Random_LI_II); table.insert(leadin_fx, "Char Random LI II")
	Chess_Multi_Color = table.duplicate(PfxM_Box); table.inbox(Chess_Multi_Color, "lead-in[fx]: Chess Multi Color","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","2, 2","","char.text","tag.clip(fx.pos_l, fx.pos_t, char.width, char.height, 71), '\\\\bord0\\\\1vc'..color.vc(var.char.C[(j + char.i - 2)%4 + 1])","C = {'&H00F3F3&', '&HFF8D00&', '&H0102FB&', '&H15F905&'}"); table.insert(leadin_fx_library, Chess_Multi_Color); table.insert(leadin_fx, "Chess Multi Color")
	Distort_Clip_in_Line = table.duplicate(PfxM_Box); table.inbox(Distort_Clip_in_Line, "lead-in[fx]: Distort Clip in Line","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time - var.syl.delay1 - var.syl.delay2*j","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.syl.dx, fx.pos_x","fx.pos_y, fx.pos_y","0, var.loop.delay1","3","","syl.text","format('%s\\\\t(0,%s,0.7,\\\\frx-360)\\\\fad(300,0)', tag.clip(fx.pos_l, fx.pos_t, meta.res_x, syl.height), var.loop.delay1)","delay1 = 500, delay2 = 100, dx = 180*ratio"); table.insert(leadin_fx_library, Distort_Clip_in_Line); table.insert(leadin_fx, "Distort Clip in Line")
	Distort_in_Syl_I = table.duplicate(PfxM_Box); table.inbox(Distort_in_Syl_I, "lead-in[fx]: Distort in Syl I","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 300","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\3vc%s\\\\org(%s,%s)\\\\rnd6\\\\blur10\\\\bord2\\\\shad0\\\\fscy%s\\\\t(0,300,0.8,\\\\rnd0\\\\blur0)\\\\t(0,500,0.8,\\\\bord%s\\\\shad%s\\\\3vc%s\\\\fscy%s)\\\\fad(150,0)', color.vc('&HFFFFFF&'), fx.pos_x, -10000*ratio, 0.8*l.scale_y, l.outline, l.shadow, text.color3, l.scale_y)",""); table.insert(leadin_fx_library, Distort_in_Syl_I); table.insert(leadin_fx, "Distort in Syl I")
	Distort_in_Syl_I_buttLine = table.duplicate(PfxM_Box); table.inbox(Distort_in_Syl_I_buttLine, "lead-in[fx]: Distort in Syl I buttLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + time_mid2(70) - 120","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\3vc%s\\\\org(%s,%s)\\\\rnd6\\\\blur10\\\\bord2\\\\shad0\\\\fscy%s\\\\t(0,300,0.8,\\\\rnd0\\\\blur0)\\\\t(0,500,0.8,\\\\bord%s\\\\shad%s\\\\3vc%s\\\\fscy%s)\\\\fad(150,0)', color.vc('&HFFFFFF&'), fx.pos_x, -10000*ratio, 0.8*l.scale_y, l.outline, l.shadow, text.color3, l.scale_y)",""); table.insert(leadin_fx_library, Distort_in_Syl_I_buttLine); table.insert(leadin_fx, "Distort in Syl I buttLine")
	Distort_in_Syl_I_Inverse = table.duplicate(PfxM_Box); table.inbox(Distort_in_Syl_I_Inverse, "lead-in[fx]: Distort in Syl I Inverse","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - 50*(syl.i - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\3vc%s\\\\org(%s,%s)\\\\rnd6\\\\blur10\\\\bord2\\\\shad0\\\\fscy%s\\\\t(0,300,0.8,\\\\rnd0\\\\blur0)\\\\t(0,500,0.8,\\\\bord%s\\\\shad%s\\\\3vc%s\\\\fscy%s)\\\\fad(150,0)', color.vc('&HFFFFFF&'), fx.pos_x, -10000*ratio, 0.8*l.scale_y, l.outline, l.shadow, text.color3, l.scale_y)",""); table.insert(leadin_fx_library, Distort_in_Syl_I_Inverse); table.insert(leadin_fx, "Distort in Syl I Inverse")
	Distort_in_Syl_I_midLine = table.duplicate(PfxM_Box); table.inbox(Distort_in_Syl_I_midLine, "lead-in[fx]: Distort in Syl I midLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + time_mid1(70) - 120","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\3vc%s\\\\org(%s,%s)\\\\rnd6\\\\blur10\\\\bord2\\\\shad0\\\\fscy%s\\\\t(0,300,0.8,\\\\rnd0\\\\blur0)\\\\t(0,500,0.8,\\\\bord%s\\\\shad%s\\\\3vc%s\\\\fscy%s)\\\\fad(150,0)', color.vc('&HFFFFFF&'), fx.pos_x, -10000*ratio, 0.8*l.scale_y, l.outline, l.shadow, text.color3, l.scale_y)",""); table.insert(leadin_fx_library, Distort_in_Syl_I_midLine); table.insert(leadin_fx, "Distort in Syl I midLine")
	Emerge_Clip_Grip_I = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_I, "lead-in[fx]: Emerge Clip Grip I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 60*(syl.i - syl.n/2 - 1) - 400","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","5, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(300,0)'","dx = R(-30, 30), dy = R(-30, 30)"); table.insert(leadin_fx_library, Emerge_Clip_Grip_I); table.insert(leadin_fx, "Emerge Clip Grip I")
	Emerge_Clip_Grip_I_buttline = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_I_buttline, "lead-in[fx]: Emerge Clip Grip I buttline","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + time_mid2(70) - 120","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","5, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(300,0)'","dx = R(-30, 30), dy = R(-30, 30)"); table.insert(leadin_fx_library, Emerge_Clip_Grip_I_buttline); table.insert(leadin_fx, "Emerge Clip Grip I buttline")
	Emerge_Clip_Grip_I_Inverse = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_I_Inverse, "lead-in[fx]: Emerge Clip Grip I Inverse","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time - 50*(syl.i - 1) - 600","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","5, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(300,0)'","dx = R(-30, 30), dy = R(-30, 30)"); table.insert(leadin_fx_library, Emerge_Clip_Grip_I_Inverse); table.insert(leadin_fx, "Emerge Clip Grip I Inverse")
	Emerge_Clip_Grip_I_midline = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_I_midline, "lead-in[fx]: Emerge Clip Grip I midline","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + time_mid1(70) - 120","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","5, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(300,0)'","dx = R(-30, 30), dy = R(-30, 30)"); table.insert(leadin_fx_library, Emerge_Clip_Grip_I_midline); table.insert(leadin_fx, "Emerge Clip Grip I midline")
	Emerge_Clip_Grip_II = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_II, "lead-in[fx]: Emerge Clip Grip II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 60*(syl.i - syl.n/2 - 1) - R(30, 50)*10","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","5, loop_h","","syl.text","format('%s\\\\t(0,450,%s)\\\\fad(120,0)', tag.clip(fx.pos_l + var.loop.dx, fx.pos_t + var.loop.dy, syl.width, syl.height), tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height))","dx = R(-50, 50), dy = R(-50, 50)"); table.insert(leadin_fx_library, Emerge_Clip_Grip_II); table.insert(leadin_fx, "Emerge Clip Grip II")
	Emerge_Clip_Grip_II_buttLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_II_buttLine, "lead-in[fx]: Emerge Clip Grip II buttLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + time_mid2(70) - 120 - R(30, 50)*10","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","5, loop_h","","syl.text","format('%s\\\\t(0,450,%s)\\\\fad(120,0)', tag.clip(fx.pos_l + var.loop.dx, fx.pos_t + var.loop.dy, syl.width, syl.height), tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height))","dx = R(-50, 50), dy = R(-50, 50)"); table.insert(leadin_fx_library, Emerge_Clip_Grip_II_buttLine); table.insert(leadin_fx, "Emerge Clip Grip II buttLine")
	Emerge_Clip_Grip_II_Inverse = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_II_Inverse, "lead-in[fx]: Emerge Clip Grip II Inverse","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time - 50*(syl.i - 1) - 300 - R(30, 50)*10","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","5, loop_h","","syl.text","format('%s\\\\t(0,450,%s)\\\\fad(120,0)', tag.clip(fx.pos_l + var.loop.dx, fx.pos_t + var.loop.dy, syl.width, syl.height), tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height))","dx = R(-50, 50), dy = R(-50, 50)"); table.insert(leadin_fx_library, Emerge_Clip_Grip_II_Inverse); table.insert(leadin_fx, "Emerge Clip Grip II Inverse")
	Emerge_Clip_Grip_II_midLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_II_midLine, "lead-in[fx]: Emerge Clip Grip II midLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + time_mid1(70) - 120 - R(30, 50)*10","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","5, loop_h","","syl.text","format('%s\\\\t(0,450,%s)\\\\fad(120,0)', tag.clip(fx.pos_l + var.loop.dx, fx.pos_t + var.loop.dy, syl.width, syl.height), tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height))","dx = R(-50, 50), dy = R(-50, 50)"); table.insert(leadin_fx_library, Emerge_Clip_Grip_II_midLine); table.insert(leadin_fx, "Emerge Clip Grip II midLine")
	Emerge_Clip_Grip_III = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_III, "lead-in[fx]: Emerge Clip Grip III","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - R(var.loop.d1 - var.loop.d2)","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","5, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(300,0)'","d1 = 1000, d2 = 300"); table.insert(leadin_fx_library, Emerge_Clip_Grip_III); table.insert(leadin_fx, "Emerge Clip Grip III")
	Emerge_Clip_Horizontal = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Horizontal, "lead-in[fx]: Emerge Clip Horizontal","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 60*(syl.i - syl.n/2 - 1) - 300","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","8","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(300, 0)'","dx = R(-50, 50), dy = R(-40, 40)"); table.insert(leadin_fx_library, Emerge_Clip_Horizontal); table.insert(leadin_fx, "Emerge Clip Horizontal")
	Emerge_Clip_Horizontal_buttLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Horizontal_buttLine, "lead-in[fx]: Emerge Clip Horizontal buttLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + time_mid2(70) - 120","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","8","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(300, 0)'","dx = R(-50, 50), dy = R(-40, 40)"); table.insert(leadin_fx_library, Emerge_Clip_Horizontal_buttLine); table.insert(leadin_fx, "Emerge Clip Horizontal buttLine")
	Emerge_Clip_Horizontal_Inverse = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Horizontal_Inverse, "lead-in[fx]: Emerge Clip Horizontal Inverse","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time - 50*(syl.i - 1) - 600","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","8","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(300, 0)'","dx = R(-50, 50), dy = R(-40, 40)"); table.insert(leadin_fx_library, Emerge_Clip_Horizontal_Inverse); table.insert(leadin_fx, "Emerge Clip Horizontal Inverse")
	Emerge_Clip_Horizontal_midLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Horizontal_midLine, "lead-in[fx]: Emerge Clip Horizontal midLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + time_mid1(70) - 120","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","8","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(300, 0)'","dx = R(-50, 50), dy = R(-40, 40)"); table.insert(leadin_fx_library, Emerge_Clip_Horizontal_midLine); table.insert(leadin_fx, "Emerge Clip Horizontal midLine")
	Emerge_Clip_Vertical = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Vertical, "lead-in[fx]: Emerge Clip Vertical","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 60*(syl.i - syl.n/2 - 1) - 600","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","1, ceil(syl.width/7)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.widtht, syl.height), '\\\\fad(300, 0)'","dx = R(-50, 50), dy = R(-40, 40)"); table.insert(leadin_fx_library, Emerge_Clip_Vertical); table.insert(leadin_fx, "Emerge Clip Vertical")
	Emerge_Clip_Vertical_buttLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Vertical_buttLine, "lead-in[fx]: Emerge Clip Vertical buttLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + time_mid2(70) - 120","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","1, ceil(syl.width/7)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.widtht, syl.height), '\\\\fad(300, 0)'","dx = R(-50, 50), dy = R(-40, 40)"); table.insert(leadin_fx_library, Emerge_Clip_Vertical_buttLine); table.insert(leadin_fx, "Emerge Clip Vertical buttLine")
	Emerge_Clip_Vertical_Inverse = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Vertical_Inverse, "lead-in[fx]: Emerge Clip Vertical Inverse","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time - 50*(syl.i - 1) - 600","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","1, ceil(syl.width/7)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.widtht, syl.height), '\\\\fad(300, 0)'","dx = R(-50, 50), dy = R(-40, 40)"); table.insert(leadin_fx_library, Emerge_Clip_Vertical_Inverse); table.insert(leadin_fx, "Emerge Clip Vertical Inverse")
	Emerge_Clip_Vertical_midLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Vertical_midLine, "lead-in[fx]: Emerge Clip Vertical midLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + time_mid1(70) - 120","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, 450","1, ceil(syl.width/7)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.widtht, syl.height), '\\\\fad(300, 0)'","dx = R(-50, 50), dy = R(-40, 40)"); table.insert(leadin_fx_library, Emerge_Clip_Vertical_midLine); table.insert(leadin_fx, "Emerge Clip Vertical midLine")
	Emerge_Clip_Sequence_HV_Syl = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Sequence_HV_Syl, "lead-in[fx]: Emerge Clip Sequence HV Syl","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 60*(char.i - char.n/2 - 1) - 300","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x + ((char.i%2 == 0) and var.loop.dx or 0), fx.pos_x","fx.pos_y + ((char.i%2 == 1) and var.loop.dy or 0), fx.pos_y","0, 450","(char.i%2 == 0) and 8 or 1, (char.i%2 == 1) and 8 or 1","","char.text","tag.clip(fx.pos_l - 20, fx.pos_t - 20, char.width + 40, char.height + 40), '\\\\fad(300, 0)'","dx = R(-80, 80)*ratio, dy = R(-80, 80)*ratio"); table.insert(leadin_fx_library, Emerge_Clip_Sequence_HV_Syl); table.insert(leadin_fx, "Emerge Clip Sequence HV Syl")
	Flashing_Intro_Aux = table.duplicate(PfxM_Box); table.inbox(Flashing_Intro_Aux, "lead-in[fx]: Flashing Intro Aux","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.syl.delay","l.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","15","","syl.text","format('\\\\bord0\\\\blur3\\\\org(%s,%s)\\\\fr%s\\\\1va%s\\\\3va%s\\\\4va%s\\\\t(0,%s,0.8,\\\\fr0\\\\blur0%s)', fx.pos_x - 10000*ratio, fx.pos_y, var.syl.a*(2*module - 1), alpha.va('&HDD&'), alpha.va('&HEE&'), alpha.va('&HEE&'), var.syl.delay, tag.only((j == maxj/2), format('\\\\1va%s\\\\3va%s\\\\4va%s', text.alpha1, text.alpha3, text.alpha4), ''))","delay = 400, a = 0.2"); table.insert(leadin_fx_library, Flashing_Intro_Aux); table.insert(leadin_fx, "Flashing Intro Aux")
	Function_Alpha_Delay = table.duplicate(PfxM_Box); table.inbox(Function_Alpha_Delay, "lead-in[fx]: Function Alpha Delay","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 60*(syl.i - syl.n/2 - 1) - var.loop.delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","alpha.delay(0, 800, '&HFF&', text.alpha1a, '\\\\1va', '\\\\3va')","delay = 600 - R(0, 20)*10"); table.insert(leadin_fx_library, Function_Alpha_Delay); table.insert(leadin_fx, "Function Alpha Delay")
	Function_Alpha_Mask = table.duplicate(PfxM_Box); table.inbox(Function_Alpha_Mask, "lead-in[fx]: Function Alpha Mask","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 300","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","alpha.mask('\\\\1va', text.alpha1a), '\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Function_Alpha_Mask); table.insert(leadin_fx, "Function Alpha Mask")
	Function_Alpha_MoveMask = table.duplicate(PfxM_Box); table.inbox(Function_Alpha_MoveMask, "lead-in[fx]: Function Alpha MoveMask","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 300","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","alpha.movemask(fx.dur, 240, '\\\\1va', text.alpha1a), '\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Function_Alpha_MoveMask); table.insert(leadin_fx, "Function Alpha MoveMask")
	Function_Color_Gradient_Vertical = table.duplicate(PfxM_Box); table.inbox(Function_Color_Gradient_Vertical, "lead-in[fx]: Function Color Gradient Vertical","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 300","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\1vc%s\\\\fad(300,0)', color.gradientv('&HFFFFFF&', '&H47950B&'))",""); table.insert(leadin_fx_library, Function_Color_Gradient_Vertical); table.insert(leadin_fx, "Function Color Gradient Vertical")
	Function_Color_Gradient_Horizontal_I = table.duplicate(PfxM_Box); table.inbox(Function_Color_Gradient_Horizontal_I, "lead-in[fx]: Function Color Gradient Horizontal I","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\1vc%s\\\\fad(300,0)', color.gradienth('&HCB00FF&', '&HFE8D00&'))",""); table.insert(leadin_fx_library, Function_Color_Gradient_Horizontal_I); table.insert(leadin_fx, "Function Color Gradient Horizontal I")
	Function_Color_Gradient_Horizontal_II = table.duplicate(PfxM_Box); table.inbox(Function_Color_Gradient_Horizontal_II, "lead-in[fx]: Function Color Gradient Horizontal II","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\1vc%s\\\\fad(300,0)', color.gradienth('&HFFFFFF&', '&HFE8D00&', '1 - abs(2*%s - 1)'))",""); table.insert(leadin_fx_library, Function_Color_Gradient_Horizontal_II); table.insert(leadin_fx, "Function Color Gradient Horizontal II")
	Function_Color_Mask = table.duplicate(PfxM_Box); table.inbox(Function_Color_Mask, "lead-in[fx]: Function Color Mask","Syl",true,false,"#FFFFFF","#67D7FE","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","color.mask('\\\\1vc', '&H07F92B&'), '\\\\bord0\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Function_Color_Mask); table.insert(leadin_fx, "Function Color Mask")
	Function_Color_MoveMask = table.duplicate(PfxM_Box); table.inbox(Function_Color_MoveMask, "lead-in[fx]: Function Color MoveMask","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","color.movemask(fx.dur, 180, '\\\\1vc', '&HFF8D00&'), '\\\\fad(300,0)\\\\bord0'",""); table.insert(leadin_fx_library, Function_Color_MoveMask); table.insert(leadin_fx, "Function Color MoveMask")
	Function_Color_MoveMask_Vertical = table.duplicate(PfxM_Box); table.inbox(Function_Color_MoveMask_Vertical, "lead-in[fx]: Function Color MoveMask Vertical","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","color.movemaskv(fx.dur, 240, '\\\\1vc', '&H00CCFF&'), '\\\\fad(300,0)\\\\bord0'",""); table.insert(leadin_fx_library, Function_Color_MoveMask_Vertical); table.insert(leadin_fx, "Function Color MoveMask Vertical")
	Function_Color_Set = table.duplicate(PfxM_Box); table.inbox(Function_Color_Set, "lead-in[fx]: Function Color Set","Syl",true,false,"#929292","#0B2442","#000000","25","25","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","color.set(var.line.times, var.line.colors, '\\\\1vc'), '\\\\fad(300,0)'","times = {'0:00:06.066', '0:00:08.300', '0:00:10.535', '0:00:14.306', '0:00:20.200', '0:00:30.116', '0:00:43.066'}; colors = {'&HB82AFB&', '&HFB7E35&', '&H4414FA&', '&HB82AFB&', '&H44AAFA&', '&HFB7E35&', '&HB82AFB&'}","Lua",false); table.insert(leadin_fx_library, Function_Color_Set); table.insert(leadin_fx, "Function Color Set")
	Function_Color_Set_Mask = table.duplicate(PfxM_Box); table.inbox(Function_Color_Set_Mask, "lead-in[fx]: Function Color Set Mask","Syl",true,false,"#FFFFFF","#0B2442","#000000","25","25","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","color.set(var.line.times, table.set(var.line.colors), '\\\\1vc'), '\\\\fad(300,0)'","times = {'0:00:46.066', '0:00:48.300', '0:00:50.535', '0:00:54.306', '0:01:02.200', '0:01:05.116', '0:00:53.066'}, colors = color.masktable({'&HB82AFB&', '&HFB7E35&', '&H4414FA&', '&HB82AFB&', '&H44AAFA&', '&HFB7E35&', '&HB82AFB&', text.color1c})"); table.insert(leadin_fx_library, Function_Color_Set_Mask); table.insert(leadin_fx, "Function Color Set Mask")
	Function_Color_Set_Move_Mask = table.duplicate(PfxM_Box); table.inbox(Function_Color_Set_Move_Mask, "lead-in[fx]: Function Color Set Move Mask","Syl",true,false,"#EAEAEA","#EAEAEA","#EAEAEA","0","0","0","l.start_time","l.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","color.setmovemask(400, '\\\\1vc', var.line.times, var.line.colors)","times = {'0:00:06.066', '0:00:08.300', '0:00:10.535', '0:00:14.306', '0:00:20.200', '0:00:30.116', '0:00:43.066'}; colors = {'&HB82AFB&', '&HFB7E35&', '&H4414FA&', '&HB82AFB&', '&H44AAFA&', '&HFB7E35&', '&HB82AFB&'}","Lua",false); table.insert(leadin_fx_library, Function_Color_Set_Move_Mask); table.insert(leadin_fx, "Function Color Set Move Mask")
	Function_MoveVC_Demo_I = table.duplicate(PfxM_Box); table.inbox(Function_MoveVC_Demo_I, "lead-in[fx]: Function MoveVC Demo I","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 60*(syl.i - syl.n/2 - 1) - 700","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x - var.loop.dx, fx.pos_x","fx.pos_y - var.loop.dy, fx.pos_y","0, var.loop.delay + 70*j","1","","syl.text","shape.movevc(shape.multi1('default', 5), 'tag'), '\\\\fad(300,0)'","delay = 600, dx = R(-25, 25)*ratio, dy = R(-25, 25)*ratio"); table.insert(leadin_fx_library, Function_MoveVC_Demo_I); table.insert(leadin_fx, "Function MoveVC Demo I")
	Function_MoveVC_Demo_II = table.duplicate(PfxM_Box); table.inbox(Function_MoveVC_Demo_II, "lead-in[fx]: Function MoveVC Demo II","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 50*(char.i - char.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","shape.movevc(shape.multi1('default', 5), 'tag', 0, 0, fx.pos_x - var.loop.dx, fx.pos_y - var.loop.dy, var.loop.dx, var.loop.dy, 0, var.loop.delay + 70*j), '\\\\fad(300,0)'","delay = 600, dx = R(-25, 25)*ratio, dy = R(-25, 25)*ratio"); table.insert(leadin_fx_library, Function_MoveVC_Demo_II); table.insert(leadin_fx, "Function MoveVC Demo II")
	Function_Oscill_Color_And_Blur = table.duplicate(PfxM_Box); table.inbox(Function_Oscill_Color_And_Blur, "lead-in[fx]: Function Oscill Color And Blur","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\bord3\\\\fad(300,0)%s%s', tag.oscill(fx.dur, 300, table.concat1(color.vc({'&HFF8D00&', '&HFF00FF&', '&H00FF00&'}), '\\\\3vc')), tag.oscill(fx.dur, 300, '\\\\blur4', '\\\\blur1'))",""); table.insert(leadin_fx_library, Function_Oscill_Color_And_Blur); table.insert(leadin_fx, "Function Oscill Color And Blur")
	Function_Oscill_Snake_Move = table.duplicate(PfxM_Box); table.inbox(Function_Oscill_Snake_Move, "lead-in[fx]: Function Oscill Snake Move","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\fad(300,0)%s\\\\t(%s,%s,\\\\fsvp0)', tag.oscill(var.syl.delay, 140, '\\\\fsvp'..var.syl.height, '\\\\fsvp'..-var.syl.height), var.syl.delay, var.syl.delay + 1)","height = 5*ratio, delay = 800"); table.insert(leadin_fx_library, Function_Oscill_Snake_Move); table.insert(leadin_fx, "Function Oscill Snake Move")
	Ghost_Line_line = table.duplicate(PfxM_Box); table.inbox(Ghost_Line_line, "lead-in[fx]: Ghost Line line","Line",true,false,"#6E6E6E","#ADC4D6","#6A8DD6","0","0","0","l.start_time + R(line.dur - 600)","fx.start_time + 600","","","","","line.center","line.middle","","","5","0","fx.pos_x","fx.pos_y","","(line.dur - 600)/920","","line.text_stripped","shape.Rmove(15*ratio, 15*ratio), format(\"\\\\bord0\\\\shad0\\\\blur0.4\\\\t(\\\\blur4)\\\\1c%s\", color1)","color1 = shape.color1","Lua",false); table.insert(leadin_fx_library, Ghost_Line_line); table.insert(leadin_fx, "Ghost Line line")
	Ghost_Shake_leadin = table.duplicate(PfxM_Box); table.inbox(Ghost_Shake_leadin, "lead-in[fx]: Ghost Shake leadin","Syl",true,false,"#2991FF","#FFFFFF","#6A8DD6","0","0","0","l.start_time","l.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","mi_leadin( ), \"\\\\fad(120,0)\"","color1 = shape.color1; color2 = shape.color3;\nmi_leadin = function( )\n	maxloop( 4 )\n	if j < maxj then\n		retime( \"preline\", 40*(syl.i - 1) - 400, 40*(syl.i - 1) + 40 )\n		relayer( 1 )\n		return format(\"%s\\\\bord0\\\\shad0\\\\blur0.8\\\\1c%s\", shape.Rmove(15*ratio, 15*ratio, 0, 440), color.module( color1, color2 ))\n	end\n	retime( \"start2syl\", 40*(syl.i - 1) - 200, 0 )\n	relayer( 0 )\n	return \"\"\nend","Lua",false); table.insert(leadin_fx_library, Ghost_Shake_leadin); table.insert(leadin_fx, "Ghost Shake leadin")
	Ghost_Shake_simple = table.duplicate(PfxM_Box); table.inbox(Ghost_Shake_simple, "lead-in[fx]: Ghost Shake simple","Syl",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time + time_li(50) - delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","shape.Rmove( 20, 20, 0, delay, 1, {200} ), \"\\\\fad(800,0)\"","delay = 800","Lua",false); table.insert(leadin_fx_library, Ghost_Shake_simple); table.insert(leadin_fx, "Ghost Shake simple")
	Helical_Char = table.duplicate(PfxM_Box); table.inbox(Helical_Char, "lead-in[fx]: Helical Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 - 1) - 300","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + var.char.d*(-1)^j + (2*var.char.d*(-1)^(j+1))*(char.i-1)/char.n, fx.pos_y","0, 1.5*var.char.delay","2","","char.text","format('\\\\org(%s,%s)\\\\frx180\\\\t(0,%s,0.8,\\\\frx0)\\\\t(%s,%s,\\\\1va%s\\\\3va%s\\\\4va%s)\\\\fad(300,0)',fx.pos_x, fx.pos_y, var.char.delay, var.char.delay + 300, var.char.delay + 301, var.loop.a1, var.loop.a3, var.loop.a4)","delay = 450, d = 70*ratio, a1 = tag.only(j==1, alpha.va('&HFF&'), text.alpha1), a3 = tag.only(j==1, alpha.va('&HFF&'), text.alpha3), a4 = tag.only(j==1, alpha.va('&HFF&'), text.alpha4)"); table.insert(leadin_fx_library, Helical_Char); table.insert(leadin_fx, "Helical Char")
	Helical_Char_buttLine = table.duplicate(PfxM_Box); table.inbox(Helical_Char_buttLine, "lead-in[fx]: Helical Char buttLine","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + time_mid2(70) - 120","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + var.char.d*(-1)^j + (2*var.char.d*(-1)^(j+1))*(char.i-1)/char.n, fx.pos_y","0, 1.5*var.char.delay","2","","char.text","format('\\\\org(%s,%s)\\\\frx180\\\\t(0,%s,0.8,\\\\frx0)\\\\t(%s,%s,\\\\1va%s\\\\3va%s\\\\4va%s)\\\\fad(300,0)',fx.pos_x, fx.pos_y, var.char.delay, var.char.delay + 300, var.char.delay + 301, var.loop.a1, var.loop.a3, var.loop.a4)","delay = 450, d = 70*ratio, a1 = tag.only(j==1, alpha.va('&HFF&'), text.alpha1), a3 = tag.only(j==1, alpha.va('&HFF&'), text.alpha3), a4 = tag.only(j==1, alpha.va('&HFF&'), text.alpha4)"); table.insert(leadin_fx_library, Helical_Char_buttLine); table.insert(leadin_fx, "Helical Char buttLine")
	Helical_Char_Inverse = table.duplicate(PfxM_Box); table.inbox(Helical_Char_Inverse, "lead-in[fx]: Helical Char Inverse","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - 30*(char.i - 1) - 750","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + var.char.d*(-1)^j + (2*var.char.d*(-1)^(j+1))*(char.i-1)/char.n, fx.pos_y","0, 1.5*var.char.delay","2","","char.text","format('\\\\org(%s,%s)\\\\frx180\\\\t(0,%s,0.8,\\\\frx0)\\\\t(%s,%s,\\\\1va%s\\\\3va%s\\\\4va%s)\\\\fad(300,0)',fx.pos_x, fx.pos_y, var.char.delay, var.char.delay + 300, var.char.delay + 301, var.loop.a1, var.loop.a3, var.loop.a4)","delay = 450, d = 70*ratio, a1 = tag.only(j==1, alpha.va('&HFF&'), text.alpha1), a3 = tag.only(j==1, alpha.va('&HFF&'), text.alpha3), a4 = tag.only(j==1, alpha.va('&HFF&'), text.alpha4)"); table.insert(leadin_fx_library, Helical_Char_Inverse); table.insert(leadin_fx, "Helical Char Inverse")
	Helical_Char_midLine = table.duplicate(PfxM_Box); table.inbox(Helical_Char_midLine, "lead-in[fx]: Helical Char midLine","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + time_mid1(70) - 120","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + var.char.d*(-1)^j + (2*var.char.d*(-1)^(j+1))*(char.i-1)/char.n, fx.pos_y","0, 1.5*var.char.delay","2","","char.text","format('\\\\org(%s,%s)\\\\frx180\\\\t(0,%s,0.8,\\\\frx0)\\\\t(%s,%s,\\\\1va%s\\\\3va%s\\\\4va%s)\\\\fad(300,0)',fx.pos_x, fx.pos_y, var.char.delay, var.char.delay + 300, var.char.delay + 301, var.loop.a1, var.loop.a3, var.loop.a4)","delay = 450, d = 70*ratio, a1 = tag.only(j==1, alpha.va('&HFF&'), text.alpha1), a3 = tag.only(j==1, alpha.va('&HFF&'), text.alpha3), a4 = tag.only(j==1, alpha.va('&HFF&'), text.alpha4)"); table.insert(leadin_fx_library, Helical_Char_midLine); table.insert(leadin_fx, "Helical Char midLine")
	Move_Char_I = table.duplicate(PfxM_Box); table.inbox(Move_Char_I, "lead-in[fx]: Move Char I","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, var.syl.delay","1","","char.text","'\\\\fad(200,0)'","delay = 450, dx = R(50, 100)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadin_fx_library, Move_Char_I); table.insert(leadin_fx, "Move Char I")
	Move_Char_Gyre = table.duplicate(PfxM_Box); table.inbox(Move_Char_Gyre, "lead-in[fx]: Move Char Gyre","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y + var.loop.dy, fx.pos_y","0, var.syl.delay","1","","char.text","format('\\\\frx%s\\\\fry%s\\\\frz%s\\\\t(0,%s,\\\\frx0\\\\fry0\\\\frz0)\\\\fad(200,0)', R(-360,360), R(-360,360), R(-360,360), var.syl.delay)","delay = 450, dx = R(40, 80)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadin_fx_library, Move_Char_Gyre); table.insert(leadin_fx, "Move Char Gyre")
	Move_Line_Bottom = table.duplicate(PfxM_Box); table.inbox(Move_Line_Bottom, "lead-in[fx]: Move Line Bottom","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.syl.delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + var.syl.d, fx.pos_y","0, var.syl.delay","1","","syl.text","format('\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3\\\\t(%s,%s,\\\\shad%s\\\\bord%s\\\\1vc%s\\\\3vc%s)', color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'), 3*var.syl.delay/4, var.syl.delay, l.shadow, l.outline, text.color1, text.color3)","d = l.height, delay = 260"); table.insert(leadin_fx_library, Move_Line_Bottom); table.insert(leadin_fx, "Move Line Bottom")
	Move_Line_Center_Clip_I = table.duplicate(PfxM_Box); table.inbox(Move_Line_Center_Clip_I, "lead-in[fx]: Move Line Center Clip I","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.loop.delay - 200","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + 0.5*l.width*(-1)^(j + 1), fx.pos_x","fx.pos_y, fx.pos_y","0, var.loop.delay","1, 2","","syl.text","tag.clip(l.left, l.top, l.width, l.height)","delay = 450"); table.insert(leadin_fx_library, Move_Line_Center_Clip_I); table.insert(leadin_fx, "Move Line Center Clip I")
	Move_Line_Center_Clip_II = table.duplicate(PfxM_Box); table.inbox(Move_Line_Center_Clip_II, "lead-in[fx]: Move Line Center Clip II","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.loop.delay - 200","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + 0.5*l.width*(-1)^j, fx.pos_x","fx.pos_y, fx.pos_y","0, var.loop.delay","1, 2","","syl.text","tag.clip(l.left, l.top, l.width, l.height)","delay = 450"); table.insert(leadin_fx_library, Move_Line_Center_Clip_II); table.insert(leadin_fx, "Move Line Center Clip II")
	Move_Line_Center_Clip_Sequence = table.duplicate(PfxM_Box); table.inbox(Move_Line_Center_Clip_Sequence, "lead-in[fx]: Move Line Center Clip Sequence","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.loop.delay - 200","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + 0.5*l.width*(-1)^(j + line.i), fx.pos_x","fx.pos_y, fx.pos_y","0, var.loop.delay","1, 2","","syl.text","tag.clip(l.left, l.top, l.width, l.height)","delay = 450"); table.insert(leadin_fx_library, Move_Line_Center_Clip_Sequence); table.insert(leadin_fx, "Move Line Center Clip Sequence")
	Move_Line_Left = table.duplicate(PfxM_Box); table.inbox(Move_Line_Left, "lead-in[fx]: Move Line Left","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.syl.delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x - var.syl.d, fx.pos_x","fx.pos_y, fx.pos_y","0, var.syl.delay","1","","syl.text","format('\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3\\\\t(%s,%s,\\\\shad%s\\\\bord%s\\\\1vc%s\\\\3vc%s)', color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'), 3*var.syl.delay/4, var.syl.delay, l.shadow, l.outline, text.color1, text.color3)","d = 300*ratio, delay = 260"); table.insert(leadin_fx_library, Move_Line_Left); table.insert(leadin_fx, "Move Line Left")
	Move_Line_Left_Right = table.duplicate(PfxM_Box); table.inbox(Move_Line_Left_Right, "lead-in[fx]: Move Line Left Right","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.syl.delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.syl.d*(-1)^line.i, fx.pos_x","fx.pos_y, fx.pos_y","0, var.syl.delay","1","","syl.text","format('\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3\\\\t(%s,%s,\\\\shad%s\\\\bord%s\\\\1vc%s\\\\3vc%s)', color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'), 3*var.syl.delay/4, var.syl.delay, l.shadow, l.outline, text.color1, text.color3)","d = 300*ratio, delay = 260"); table.insert(leadin_fx_library, Move_Line_Left_Right); table.insert(leadin_fx, "Move Line Left Right")
	Move_Line_Right = table.duplicate(PfxM_Box); table.inbox(Move_Line_Right, "lead-in[fx]: Move Line Right","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.syl.delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + var.syl.d, fx.pos_x","fx.pos_y, fx.pos_y","0, var.syl.delay","1","","syl.text","format('\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3\\\\t(%s,%s,\\\\shad%s\\\\bord%s\\\\1vc%s\\\\3vc%s)', color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'), 3*var.syl.delay/4, var.syl.delay, l.shadow, l.outline, text.color1, text.color3)","d = 300*ratio, delay = 260"); table.insert(leadin_fx_library, Move_Line_Right); table.insert(leadin_fx, "Move Line Right")
	Move_Line_Top = table.duplicate(PfxM_Box); table.inbox(Move_Line_Top, "lead-in[fx]: Move Line Top","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.syl.delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y - var.syl.d, fx.pos_y","0, var.syl.delay","1","","syl.text","format('\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3\\\\t(%s,%s,\\\\shad%s\\\\bord%s\\\\1vc%s\\\\3vc%s)', color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'), 3*var.syl.delay/4, var.syl.delay, l.shadow, l.outline, text.color1, text.color3)","d = l.height, delay = 260"); table.insert(leadin_fx_library, Move_Line_Top); table.insert(leadin_fx, "Move Line Top")
	Move_Line_Top_Bottom = table.duplicate(PfxM_Box); table.inbox(Move_Line_Top_Bottom, "lead-in[fx]: Move Line Top Bottom","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.syl.delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + var.syl.d*(-1)^line.i, fx.pos_y","0, var.syl.delay","1","","syl.text","format('\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3\\\\t(%s,%s,\\\\shad%s\\\\bord%s\\\\1vc%s\\\\3vc%s)', color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'), 3*var.syl.delay/4, var.syl.delay, l.shadow, l.outline, text.color1, text.color3)","d = l.height, delay = 260"); table.insert(leadin_fx_library, Move_Line_Top_Bottom); table.insert(leadin_fx, "Move Line Top Bottom")
	Move_Syl_from_Center_Line = table.duplicate(PfxM_Box); table.inbox(Move_Syl_from_Center_Line, "lead-in[fx]: Move Syl from Center Line","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","l.center, fx.pos_x","fx.pos_y, fx.pos_y","0, var.syl.delay","1","","syl.text","'\\\\fad(300,0)'","delay = 460"); table.insert(leadin_fx_library, Move_Syl_from_Center_Line); table.insert(leadin_fx, "Move Syl from Center Line")
	Palpitations_Char = table.duplicate(PfxM_Box); table.inbox(Palpitations_Char, "lead-in[fx]: Palpitations Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 30*(char.i - char.n - 1)","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","var.once.Tag()","Tag = function() return format('\\\\fad(200,0)\\\\fscx0\\\\fscy0\\\\t(0,250,\\\\fscx%s\\\\fscy%s)\\\\t(250,350,\\\\fscx%s\\\\fscy%s)\\\\t(350,550,\\\\fscx%s\\\\fscy%s)\\\\t(550,650,\\\\fscx%s\\\\fscy%s)\\\\t(650,750,\\\\fscx%s\\\\fscy%s)\\\\t(750,850,\\\\fscx%s\\\\fscy%s)', 1.8*l.scale_x, 1.8*l.scale_y, 0.8*l.scale_x, 0.8*l.scale_y, 1.2*l.scale_x, 1.2*l.scale_y, 1.5*l.scale_x, 1.5*l.scale_y, 1.2*l.scale_x, 1.2*l.scale_y, l.scale_x, l.scale_y) end"); table.insert(leadin_fx_library, Palpitations_Char); table.insert(leadin_fx, "Palpitations Char")
	Phantom_Syl_moves4_presyl = table.duplicate(PfxM_Box); table.inbox(Phantom_Syl_moves4_presyl, "lead-in[fx]: Phantom Syl moves4 presyl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time - 2000 + 300*module","l.start_time + syl.start_time + 300*module","","","","","syl.center","syl.middle","","","5","maxj - j + 1","fx.pos_x + var.syl.dx1, fx.pos_x + var.syl.dx2, fx.pos_x + var.syl.dx3, fx.pos_x","fx.pos_y + var.syl.dy1, fx.pos_y + var.syl.dy2, fx.pos_y + var.syl.dy3, fx.pos_y","0, fx.dur - 300","10","","syl.text","format('\\\\3vc%s\\\\blur%s\\\\fad(300,0)', color.vc(interpolate_color(module, text.color3, text.color1)), 4*module)","dx1 =  R(-100,100)*ratio, dx2 =  R(-100,100)*ratio, dx3 =  R(-100,100)*ratio, dy1 =  R(-100,100)*ratio, dy2 =  R(-100,100)*ratio, dy3 =  R(-100,100)*ratio"); table.insert(leadin_fx_library, Phantom_Syl_moves4_presyl); table.insert(leadin_fx, "Phantom Syl moves4 presyl")
	Screw_Char = table.duplicate(PfxM_Box); table.inbox(Screw_Char, "lead-in[fx]: Screw Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 - 1) - 200","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","'\\\\frx180\\\\t(0,440,0.8,\\\\frx0)\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Screw_Char); table.insert(leadin_fx, "Screw Char")
	Screw_Char_buttLine = table.duplicate(PfxM_Box); table.inbox(Screw_Char_buttLine, "lead-in[fx]: Screw Char buttLine","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + time_mid2(40) - 120","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","'\\\\frx180\\\\t(0,440,0.8,\\\\frx0)\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Screw_Char_buttLine); table.insert(leadin_fx, "Screw Char buttLine")
	Screw_Char_midLine = table.duplicate(PfxM_Box); table.inbox(Screw_Char_midLine, "lead-in[fx]: Screw Char midLine","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + time_mid1(40) - 120","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","'\\\\frx180\\\\t(0,440,0.8,\\\\frx0)\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Screw_Char_midLine); table.insert(leadin_fx, "Screw Char midLine")
	Screw_Char_Inverse = table.duplicate(PfxM_Box); table.inbox(Screw_Char_Inverse, "lead-in[fx]: Screw Char Inverse","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - 30*(char.i - 1) - 600","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","'\\\\frx180\\\\t(0,440,0.8,\\\\frx0)\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Screw_Char_Inverse); table.insert(leadin_fx, "Screw Char Inverse")
	Simple_Moves3_Char = table.duplicate(PfxM_Box); table.inbox(Simple_Moves3_Char, "lead-in[fx]: Simple Moves3 Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 - 1) - 200","l.start_time + char.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x - var.syl.dx, fx.pos_x","fx.pos_y, fx.pos_y, fx.pos_y","0, var.syl.delay","1","","char.text","'\\\\fad(300,0)'","dx = 70*ratio, delay = 460"); table.insert(leadin_fx_library, Simple_Moves3_Char); table.insert(leadin_fx, "Simple Moves3 Char")
	Snake_Char_I = table.duplicate(PfxM_Box); table.inbox(Snake_Char_I, "lead-in[fx]: Snake Char I","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x + var.syl.d, fx.pos_x","fx.pos_y, fx.pos_y","0, 4*var.syl.delay","1","","char.text","format('%s\\\\t(%s,%s,\\\\fsvp0)\\\\fad(300,0)', tag.oscill(4*var.syl.delay, var.syl.delay, '\\\\fsvp'..var.syl.height, '\\\\fsvp'..-var.syl.height), 4*var.syl.delay, 4*var.syl.delay + 1)","height = 7*ratio, delay = 180, d = 40*ratio"); table.insert(leadin_fx_library, Snake_Char_I); table.insert(leadin_fx, "Snake Char I")
	Snake_Char_II = table.duplicate(PfxM_Box); table.inbox(Snake_Char_II, "lead-in[fx]: Snake Char II","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x + var.syl.d, fx.pos_x","fx.pos_y, fx.pos_y","0, 4*var.syl.delay","1","","char.text","format('%s\\\\t(%s,%s,\\\\fsvp0)\\\\t(0,%s,0.8,\\\\frx360)\\\\fad(300,0)', tag.oscill(4*var.syl.delay, var.syl.delay, '\\\\fsvp'..var.syl.height, '\\\\fsvp'..-var.syl.height), 4*var.syl.delay, 4*var.syl.delay + 1, 5*var.syl.delay)","height = 24*ratio, delay = 180, d = 40*ratio"); table.insert(leadin_fx_library, Snake_Char_II); table.insert(leadin_fx, "Snake Char II")
	Spectrum_Move_Char = table.duplicate(PfxM_Box); table.inbox(Spectrum_Move_Char, "lead-in[fx]: Spectrum Move Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 25*char.i - var.char.delay","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\org(%s,%s)\\\\frx%s\\\\frz%s\\\\t(0,%s,0.7,\\\\frx0\\\\frz0)\\\\fad(300,0)', fx.pos_x, fx.pos_y - 20*ratio, 140 + 2*char.i, 40 + char.i, 700 + 8*char.i)","delay = 1200"); table.insert(leadin_fx_library, Spectrum_Move_Char); table.insert(leadin_fx, "Spectrum Move Char")
	Static_Clip_Ascend = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Ascend, "lead-in[fx]: Static Clip Ascend","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + syl.height, fx.pos_y","0, 400","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Ascend); table.insert(leadin_fx, "Static Clip Ascend")
	Static_Clip_Descend = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Descend, "lead-in[fx]: Static Clip Descend","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y - syl.height, fx.pos_y","0, 400","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Descend); table.insert(leadin_fx, "Static Clip Descend")
	Static_Clip_Left = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Left, "lead-in[fx]: Static Clip Left","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x - syl.width, fx.pos_x","fx.pos_y, fx.pos_y","0, 400","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Left); table.insert(leadin_fx, "Static Clip Left")
	Static_Clip_Left_Right = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Left_Right, "lead-in[fx]: Static Clip Left Right","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + syl.width*(-1)^syl.i, fx.pos_x","fx.pos_y, fx.pos_y","0, 400","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Left_Right); table.insert(leadin_fx, "Static Clip Left Right")
	Static_Clip_Right = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Right, "lead-in[fx]: Static Clip Right","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + syl.width, fx.pos_x","fx.pos_y, fx.pos_y","0, 400","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Right); table.insert(leadin_fx, "Static Clip Right")
	Static_Clip_Top_Bottom = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Top_Bottom, "lead-in[fx]: Static Clip Top Bottom","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + syl.height*(-1)^syl.i, fx.pos_y","0, 400","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Top_Bottom); table.insert(leadin_fx, "Static Clip Top Bottom")
	Static_Clip_Horizontal_Multi_I = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Horizontal_Multi_I, "lead-in[fx]: Static Clip Horizontal Multi I","Syl",true,false,"#FFFFFF","#0B2442","#000000","25","25","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + syl.width*(-1)^j, fx.pos_x","fx.pos_y, fx.pos_y","0, 460","5","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Horizontal_Multi_I); table.insert(leadin_fx, "Static Clip Horizontal Multi I")
	Static_Clip_Horizontal_Multi_II = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Horizontal_Multi_II, "lead-in[fx]: Static Clip Horizontal Multi II","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x + syl.width*(-1)^j, fx.pos_x","fx.pos_y, fx.pos_y","0, 400","6","","syl.text","tag.clip(fx.pos_l - syl.width, fx.pos_t, 3*syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Horizontal_Multi_II); table.insert(leadin_fx, "Static Clip Horizontal Multi II")
	Static_Clip_Vertical_Multi_I = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Vertical_Multi_I, "lead-in[fx]: Static Clip Vertical Multi I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + 70*(syl.i - syl.n/2 - 1) - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + 0.6*syl.height*(-1)^j, fx.pos_y","0, 450","1, ceil(syl.width/5)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Vertical_Multi_I); table.insert(leadin_fx, "Static Clip Vertical Multi I")
	Static_Clip_Vertical_Multi_II = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Vertical_Multi_II, "lead-in[fx]: Static Clip Vertical Multi II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time - 500","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y + 0.6*syl.height*(-1)^j, fx.pos_y","0, 400","1, ceil(syl.width/5)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)",""); table.insert(leadin_fx_library, Static_Clip_Vertical_Multi_II); table.insert(leadin_fx, "Static Clip Vertical Multi II")
	Stele_Move_Left = table.duplicate(PfxM_Box); table.inbox(Stele_Move_Left, "lead-in[fx]: Stele Move Left","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(syl.i - syl.n - 1) - var.loop.delay*module/3","l.start_time + syl.start_time","","","","0","syl.center","syl.middle","","","5","0","fx.pos_x + var.loop.dx, fx.pos_x","fx.pos_y, fx.pos_y","0, var.loop.delay + 50*module","7","","syl.text","format('%s\\\\fad(300,0)', tag.only(j == 1, '', format('\\\\t(%s,%s,0.8,\\\\1va%s\\\\3va%s\\\\4va%s)', var.loop.delay, var.loop.delay + 50, alpha.va('&HFF&'), alpha.va('&HFF&'), alpha.va('&HFF&'))))","dx = 80*ratio, delay = 300"); table.insert(leadin_fx_library, Stele_Move_Left); table.insert(leadin_fx, "Stele Move Left")
	Template_Jitter_Char = table.duplicate(PfxM_Box); table.inbox(Template_Jitter_Char, "lead-in[fx]: Template Jitter Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\jitter(%s,%s,%s,%s,100,1000)', R(4)*(-1)^R(2), R(4)*(-1)^R(2), R(4)*(-1)^R(2), R(4)*(-1)^R(2))",""); table.insert(leadin_fx_library, Template_Jitter_Char); table.insert(leadin_fx, "Template Jitter Char")
	Template_Jitter_Line = table.duplicate(PfxM_Box); table.inbox(Template_Jitter_Line, "lead-in[fx]: Template Jitter Line","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\jitter(%s,%s,%s,%s,100,1000)', var.line.jt1, var.line.jt2, var.line.jt3, var.line.jt4)","jt1 = R(4)*(-1)^R(2), jt2 = R(4)*(-1)^R(2), jt3 = R(4)*(-1)^R(2), jt4 = R(4)*(-1)^R(2)"); table.insert(leadin_fx_library, Template_Jitter_Line); table.insert(leadin_fx, "Template Jitter Line")
	Template_Leadin_Flag_Line_Char = table.duplicate(PfxM_Box); table.inbox(Template_Leadin_Flag_Line_Char, "lead-in[fx]: Template Leadin Flag Line Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 30*(char.i - char.n/2 - 1) - 300","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","tag.oscill(fx.dur, 360, '\\\\fsvp2', '\\\\fsvp-2'), '\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Template_Leadin_Flag_Line_Char); table.insert(leadin_fx, "Template Leadin Flag Line Char")
	Template_Leadin_Char = table.duplicate(PfxM_Box); table.inbox(Template_Leadin_Char, "lead-in[fx]: Template Leadin Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 30*(char.i - char.n - 1)","l.start_time + char.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","'\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Template_Leadin_Char); table.insert(leadin_fx, "Template Leadin Char")
	Template_Leadin_Syl = table.duplicate(PfxM_Box); table.inbox(Template_Leadin_Syl, "lead-in[fx]: Template Leadin Syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(syl.i - syl.n/2 - 1)","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","'\\\\fad(300,0)'",""); table.insert(leadin_fx_library, Template_Leadin_Syl); table.insert(leadin_fx, "Template Leadin Syl")
	Template_line_Char = table.duplicate(PfxM_Box); table.inbox(Template_line_Char, "lead-in[fx]: Template line Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadin_fx_library, Template_line_Char); table.insert(leadin_fx, "Template line Char")
	Template_line_Char_without_syl = table.duplicate(PfxM_Box); table.inbox(Template_line_Char_without_syl, "lead-in[fx]: Template line Char without syl","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","without.syl",""); table.insert(leadin_fx_library, Template_line_Char_without_syl); table.insert(leadin_fx, "Template line Char without syl")
	Template_line_Char_without_sylchar = table.duplicate(PfxM_Box); table.inbox(Template_line_Char_without_sylchar, "lead-in[fx]: Template line Char without sylchar","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","without.char",""); table.insert(leadin_fx_library, Template_line_Char_without_sylchar); table.insert(leadin_fx, "Template line Char without sylchar")
	Template_line_Syl = table.duplicate(PfxM_Box); table.inbox(Template_line_Syl, "lead-in[fx]: Template line Syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","",""); table.insert(leadin_fx_library, Template_line_Syl); table.insert(leadin_fx, "Template line Syl")
	Template_line_Syl_without_syl = table.duplicate(PfxM_Box); table.inbox(Template_line_Syl_without_syl, "lead-in[fx]: Template line Syl without syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","without.syl",""); table.insert(leadin_fx_library, Template_line_Syl_without_syl); table.insert(leadin_fx, "Template line Syl without syl")
	Template_prechar = table.duplicate(PfxM_Box); table.inbox(Template_prechar, "lead-in[fx]: Template prechar","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + char.start_time","l.start_time + char.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadin_fx_library, Template_prechar); table.insert(leadin_fx, "Template prechar")
	Template_preline_Char = table.duplicate(PfxM_Box); table.inbox(Template_preline_Char, "lead-in[fx]: Template preline Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadin_fx_library, Template_preline_Char); table.insert(leadin_fx, "Template preline Char")
	Template_preline_Syl = table.duplicate(PfxM_Box); table.inbox(Template_preline_Syl, "lead-in[fx]: Template preline Syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","",""); table.insert(leadin_fx_library, Template_preline_Syl); table.insert(leadin_fx, "Template preline Syl")
	Template_presyl = table.duplicate(PfxM_Box); table.inbox(Template_presyl, "lead-in[fx]: Template presyl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","",""); table.insert(leadin_fx_library, Template_presyl); table.insert(leadin_fx, "Template presyl")
	Template_start2char = table.duplicate(PfxM_Box); table.inbox(Template_start2char, "lead-in[fx]: Template start2char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time + char.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadin_fx_library, Template_start2char); table.insert(leadin_fx, "Template start2char")
	Template_start2syl = table.duplicate(PfxM_Box); table.inbox(Template_start2syl, "lead-in[fx]: Template start2syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","",""); table.insert(leadin_fx_library, Template_start2syl); table.insert(leadin_fx, "Template start2syl")
	Template_start2syl_Char = table.duplicate(PfxM_Box); table.inbox(Template_start2syl_Char, "lead-in[fx]: Template start2syl Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadin_fx_library, Template_start2syl_Char); table.insert(leadin_fx, "Template start2syl Char")
	Template_Tremor_I = table.duplicate(PfxM_Box); table.inbox(Template_Tremor_I, "lead-in[fx]: Template Tremor I","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\rnd%s', var.syl.rndx), tag.oscill(fx.dur, R(20, 40)*10, '\\\\rnd'..2*var.syl.rndx,'\\\\rnd'..var.syl.rndx)","rndx = 7*ratio"); table.insert(leadin_fx_library, Template_Tremor_I); table.insert(leadin_fx, "Template Tremor I")
	Template_Tremor_II = table.duplicate(PfxM_Box); table.inbox(Template_Tremor_II, "lead-in[fx]: Template Tremor II","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\org(%s,%s)\\\\rnd%s', fx.pos_x, fx.pos_y - 10000*ratio, var.syl.rndx), tag.oscill(fx.dur, R(50, 80)*10, '\\\\rnd'..2*var.syl.rndx,'\\\\rnd'..var.syl.rndx)","rndx = ratio"); table.insert(leadin_fx_library, Template_Tremor_II); table.insert(leadin_fx, "Template Tremor II")
	Template_Tremor_III = table.duplicate(PfxM_Box); table.inbox(Template_Tremor_III, "lead-in[fx]: Template Tremor III","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\org(%s,%s)\\\\rnd%s', fx.pos_x - 10000*ratio, fx.pos_y, var.syl.rndx), tag.oscill(fx.dur, R(30, 60)*10, '\\\\rnd'..2*var.syl.rndx,'\\\\rnd'..var.syl.rndx)","rndx = 0.4*ratio"); table.insert(leadin_fx_library, Template_Tremor_III); table.insert(leadin_fx, "Template Tremor III")
	Wavelet_Char = table.duplicate(PfxM_Box); table.inbox(Wavelet_Char, "lead-in[fx]: Wavelet Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 45*(char.i -1) - var.syl.delay","l.start_time + syl.start_time","","","","","char.center","char.middle","","","5","0","fx.pos_x + var.syl.dx, fx.pos_x + var.syl.dx, fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + var.syl.dy*(-1)^j, fx.pos_y + var.syl.dy*(-1)^(j + 1), fx.pos_y","0, var.syl.delay2","2","","char.text","format('%s\\\\shad0\\\\fad(250,0)\\\\t(0,%s,\\\\frx360)', tag.only(j == 1, '\\\\1va(&HFF&,&HFF&,&HFF&,&HFF&)\\\\bord2', '\\\\bord0'), var.syl.delay2)","delay = 1500, delay2 = 1200, dx = 70*ratio, dy = 120*ratio"); table.insert(leadin_fx_library, Wavelet_Char); table.insert(leadin_fx, "Wavelet Char")

	
	--hi-light FX List
	ABC_Template_Hilight_Syl = table.duplicate(PfxM_Box); table.inbox(ABC_Template_Hilight_Syl, "hi-light[fx]: ABC Template Hilight Syl","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","",""); table.insert(hilight_fx_library, ABC_Template_Hilight_Syl); table.insert(hilight_fx, "ABC Template Hilight Syl")
	Char_Zoom_fscy = table.duplicate(PfxM_Box); table.inbox(Char_Zoom_fscy, "hi-light[fx]: Char Zoom fscy","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","char.center","char.bottom","","","2","1","fx.pos_x","fx.pos_y","","1","","char.text","format(\"\\\\t(%s,%s,\\\\fscy%s)\\\\t(%s,%s,\\\\fscy%s)\", char.syl_start, char.syl_start + frame_dur, 1.5*l.scale_y, char.syl_start + frame_dur, char.syl_end + delay, l.scale_y)","delay = 120","Lua",false); table.insert(hilight_fx_library, Char_Zoom_fscy); table.insert(hilight_fx, "Char Zoom fscy")
	Char_Zoom_fscy_move_left_I = table.duplicate(PfxM_Box); table.inbox(Char_Zoom_fscy_move_left_I, "hi-light[fx]: Char Zoom fscy move left I","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","char.center","char.bottom","","","2","1","fx.pos_x, fx.pos_x - Dx","fx.pos_y","char.syl_start, char.syl_end + delay","1","","char.text","format(\"\\\\t(%s,%s,\\\\fscy%s)\\\\t(%s,%s,\\\\fscy%s)\", char.syl_start, char.syl_start + char.dur/2, 1.5*l.scale_y, char.syl_start + char.dur/2, char.syl_end + delay, l.scale_y)","delay = 120; Dx = 14","Lua",false); table.insert(hilight_fx_library, Char_Zoom_fscy_move_left_I); table.insert(hilight_fx, "Char Zoom fscy move left I")
	Char_Zoom_fscy_move_left_II = table.duplicate(PfxM_Box); table.inbox(Char_Zoom_fscy_move_left_II, "hi-light[fx]: Char Zoom fscy move left II","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","char.center","char.top","","","8","1","fx.pos_x, fx.pos_x - Dx","fx.pos_y","char.syl_start, char.syl_end + delay","1","","char.text","format(\"\\\\t(%s,%s,\\\\fscy%s)\\\\t(%s,%s,\\\\fscy%s)\", char.syl_start, char.syl_start + char.dur/2, 1.5*l.scale_y, char.syl_start + char.dur/2, char.syl_end + delay, l.scale_y)","delay = 120; Dx = 14","Lua",false); table.insert(hilight_fx_library, Char_Zoom_fscy_move_left_II); table.insert(hilight_fx, "Char Zoom fscy move left II")
	Char_Zoom_fscy_move_left_III = table.duplicate(PfxM_Box); table.inbox(Char_Zoom_fscy_move_left_III, "hi-light[fx]: Char Zoom fscy move left III","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","char.center","char.middle + 0.5*l.height*(-1)^char.i","","","tag.only( char.i%2 == 1, 8, 2 )","1","fx.pos_x, fx.pos_x - Dx","fx.pos_y","char.syl_start, char.syl_end + delay","1","","char.text","format(\"\\\\t(%s,%s,\\\\fscy%s)\\\\t(%s,%s,\\\\fscy%s)\", char.syl_start, char.syl_start + char.dur/2, 1.5*l.scale_y, char.syl_start + char.dur/2, char.syl_end + delay, l.scale_y)","delay = 120; Dx = 14","Lua",false); table.insert(hilight_fx_library, Char_Zoom_fscy_move_left_III); table.insert(hilight_fx, "Char Zoom fscy move left III")
	Char_Zoom_move_left = table.duplicate(PfxM_Box); table.inbox(Char_Zoom_move_left, "hi-light[fx]: Char Zoom move left","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","char.center","char.middle","","","5","1","fx.pos_x, fx.pos_x - Dx","fx.pos_y","char.syl_start, char.syl_end + delay","1","","char.text","format(\"\\\\t(%s,%s,\\\\fscx%s\\\\fscy%s)\\\\t(%s,%s,\\\\fscx%s\\\\fscy%s)\", char.syl_start, char.syl_start + char.dur/2, 1.4*l.scale_x, 1.65*l.scale_y, char.syl_start + char.dur/2, char.syl_end + delay, l.scale_x, l.scale_y)","delay = 120; Dx = 14","Lua",false); table.insert(hilight_fx_library, Char_Zoom_move_left); table.insert(hilight_fx, "Char Zoom move left")
	Clip_Grip_Multi_Alpha = table.duplicate(PfxM_Box); table.inbox(Clip_Grip_Multi_Alpha, "hi-light[fx]: Clip Grip Multi Alpha","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","7, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), tag.oscill(fx.dur, R(60,150), '\\\\1va'..alpha.va('&HFF&'), '\\\\1va'..text.alpha1)",""); table.insert(hilight_fx_library, Clip_Grip_Multi_Alpha); table.insert(hilight_fx, "Clip Grip Multi Alpha")
	Clip_Grip_Multi_Color_Chameleon = table.duplicate(PfxM_Box); table.inbox(Clip_Grip_Multi_Color_Chameleon, "hi-light[fx]: Clip Grip Multi Color Chameleon","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","7, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), tag.oscill(fx.dur, R(60,150), '\\\\1vc'..random.colorvc(), '\\\\1vc'..random.colorvc())",""); table.insert(hilight_fx_library, Clip_Grip_Multi_Color_Chameleon); table.insert(hilight_fx, "Clip Grip Multi Color Chameleon")
	Clip_Grip_Multi_Distort = table.duplicate(PfxM_Box); table.inbox(Clip_Grip_Multi_Distort, "hi-light[fx]: Clip Grip Multi Distort","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","7, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), tag.oscill(fx.dur, R(50,120), '\\\\fsvp'..var.loop.hight*(-1)^j, '\\\\fsvp'..var.loop.hight*(-1)^(j + 1))","hight = 7"); table.insert(hilight_fx_library, Clip_Grip_Multi_Distort); table.insert(hilight_fx, "Clip Grip Multi Distort")
	Clip_Grip_Multi_Distort_ORG = table.duplicate(PfxM_Box); table.inbox(Clip_Grip_Multi_Distort_ORG, "hi-light[fx]: Clip Grip Multi Distort ORG","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","7, loop_h","","syl.text","tag.only((R(2) == 1), format('\\\\org(%s,%s)', fx.pos_x - 10000*ratio, fx.pos_y), format('\\\\org(%s,%s)', fx.pos_x, fx.pos_y - 10000*ratio)), tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), tag.oscill(fx.dur, R(100,200), '\\\\fr'..var.loop.angle*(-1)^j, '\\\\fr'..var.loop.angle*(-1)^(j + 1))"," angle = 0.18"); table.insert(hilight_fx_library, Clip_Grip_Multi_Distort_ORG); table.insert(hilight_fx, "Clip Grip Multi Distort ORG")
	Disolve_Clip = table.duplicate(PfxM_Box); table.inbox(Disolve_Clip, "hi-light[fx]: Disolve Clip","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + var.syl.delay1 - var.syl.delay2*(1-module)","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1, syl.width/2","","syl.text","tag.clip(fx.pos_l, fx.pos_t - var.syl.offsety, syl.width, syl.height + 2*var.syl.offsety), tag.oscill({600*module, fx.dur}, 260, '\\\\fsvp'..var.syl.px*(-1)^syl.i, '\\\\fsvp'..var.syl.px*(-1)^(syl.i+1)), '\\\\fad(0,300)'","delay1 = 700; delay2 = 300; offsety = 50; px = 6"); table.insert(hilight_fx_library, Disolve_Clip); table.insert(hilight_fx, "Disolve Clip")
	Distort_Horizontal_I = table.duplicate(PfxM_Box); table.inbox(Distort_Horizontal_I, "hi-light[fx]: Distort Horizontal I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 200","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","10","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), format('\\\\fry%s\\\\t(\\\\fry0)\\\\fad(0,200)', R(10, 40)*25*(-1)^R(2))",""); table.insert(hilight_fx_library, Distort_Horizontal_I); table.insert(hilight_fx, "Distort Horizontal I")
	Distort_Horizontal_II = table.duplicate(PfxM_Box); table.inbox(Distort_Horizontal_II, "hi-light[fx]: Distort Horizontal II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 200","","","","0","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","10","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), format('\\\\t(%s,%s,\\\\fry360)\\\\fad(0,200)', module*fx.dur/2, module*fx.dur/2 + fx.dur/2)",""); table.insert(hilight_fx_library, Distort_Horizontal_II); table.insert(hilight_fx, "Distort Horizontal II")
	Distort_Horizontal_III = table.duplicate(PfxM_Box); table.inbox(Distort_Horizontal_III, "hi-light[fx]: Distort Horizontal III","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 200","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","10","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), format('\\\\frx%s\\\\t(\\\\frx0)\\\\fad(0,200)', R(100,1000)*(-1)^R(2))",""); table.insert(hilight_fx_library, Distort_Horizontal_III); table.insert(hilight_fx, "Distort Horizontal III")
	Distort_Vertical_I = table.duplicate(PfxM_Box); table.inbox(Distort_Vertical_I, "hi-light[fx]: Distort Vertical I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 200","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1, ceil(syl.width/3)","l.scale_x, l.scale_y","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), format('\\\\fry%s\\\\t(\\\\fry0)\\\\fad(0,200)', R(10, 40)*25*(-1)^R(2))",""); table.insert(hilight_fx_library, Distort_Vertical_I); table.insert(hilight_fx, "Distort Vertical I")
	Distort_Vertical_II = table.duplicate(PfxM_Box); table.inbox(Distort_Vertical_II, "hi-light[fx]: Distort Vertical II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 200","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1, ceil(syl.width/3)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), format('\\\\t(%s,%s,\\\\fry360)\\\\fad(0,200)', module*fx.dur/2, module*fx.dur/2 + fx.dur/2)",""); table.insert(hilight_fx_library, Distort_Vertical_II); table.insert(hilight_fx, "Distort Vertical II")
	Distort_Vertical_III = table.duplicate(PfxM_Box); table.inbox(Distort_Vertical_III, "hi-light[fx]: Distort Vertical III","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 200","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1, ceil(syl.width/3)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), format('\\\\frx%s\\\\t(\\\\frx0)\\\\fad(0,200)', R(100,1000)*(-1)^R(2))",""); table.insert(hilight_fx_library, Distort_Vertical_III); table.insert(hilight_fx, "Distort Vertical III")
	Function_Oscill_Technicolor = table.duplicate(PfxM_Box); table.inbox(Function_Oscill_Technicolor, "hi-light[fx]: Function Oscill Technicolor","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","tag.oscill(fx.dur, 50, table.rmake('color', 6, R(5*syl.i, 10*syl.i), R(30*syl.i, 60*syl.i), '\\\\1vc'))",""); table.insert(hilight_fx_library, Function_Oscill_Technicolor); table.insert(hilight_fx, "Function Oscill Technicolor")
	Function_Oscill_MultiZoom = table.duplicate(PfxM_Box); table.inbox(Function_Oscill_MultiZoom, "hi-light[fx]: Function Oscill MultiZoom","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","tag.oscill(fx.dur, 50, format('\\\\fscx%s\\\\fscy%s', 1.25*fx.sizex, 1.25*fx.sizey), format('\\\\fscx%s\\\\fscy%s', fx.sizex, fx.sizey))",""); table.insert(hilight_fx_library, Function_Oscill_MultiZoom); table.insert(hilight_fx, "Function Oscill MultiZoom")
	Function_Oscill_MultiZoom_in_Y = table.duplicate(PfxM_Box); table.inbox(Function_Oscill_MultiZoom_in_Y, "hi-light[fx]: Function Oscill MultiZoom in Y","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","tag.oscill(fx.dur, 80, '\\\\fscy'..1.45*l.scale_y, '\\\\fscy'..l.scale_y)",""); table.insert(hilight_fx_library, Function_Oscill_MultiZoom_in_Y); table.insert(hilight_fx, "Function Oscill MultiZoom in Y")
	Function_Oscill_MultiZoom_in_X = table.duplicate(PfxM_Box); table.inbox(Function_Oscill_MultiZoom_in_X, "hi-light[fx]: Function Oscill MultiZoom in X","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","tag.oscill(fx.dur, 80, '\\\\fscx'..1.45*l.scale_x, '\\\\fscx'..l.scale_x)",""); table.insert(hilight_fx_library, Function_Oscill_MultiZoom_in_X); table.insert(hilight_fx, "Function Oscill MultiZoom in X")
	Function_Oscill_Vibration = table.duplicate(PfxM_Box); table.inbox(Function_Oscill_Vibration, "hi-light[fx]: Function Oscill Vibration","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\org(%s,%s)', -10000*ratio, fx.pos_y), tag.oscill(fx.dur, 60, format('\\\\fr%s', var.syl.angle), format('\\\\fr%s', -var.syl.angle))","angle = 0.05"); table.insert(hilight_fx_library, Function_Oscill_Vibration); table.insert(hilight_fx, "Function Oscill Vibration")
	Ghost_Shake_Halo_Border = table.duplicate(PfxM_Box); table.inbox(Ghost_Shake_Halo_Border, "hi-light[fx]: Ghost Shake Halo Border","Syl",true,false,"#0E72FF","#ADC4D6","#6A8DD6","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","shape.Rmove(10*ratio, 10*ratio), format('\\\\1a&HFF&\\\\bord%s\\\\shad0\\\\blur1.4\\\\3c%s', 3*ratio, shape.color1)","delay = 0","Lua",false); table.insert(hilight_fx_library, Ghost_Shake_Halo_Border); table.insert(hilight_fx, "Ghost Shake Halo Border")
	Ghost_Shake_I = table.duplicate(PfxM_Box); table.inbox(Ghost_Shake_I, "hi-light[fx]: Ghost Shake I","Syl",true,false,"#CE04D9","#ADC4D6","#6A8DD6","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","shape.Rmove(10*ratio, 10*ratio), format('\\\\bord0\\\\shad0\\\\blur1.4\\\\1c%s', shape.color1)","delay = 0","Lua",false); table.insert(hilight_fx_library, Ghost_Shake_I); table.insert(hilight_fx, "Ghost Shake I")
	Ghost_Shake_II = table.duplicate(PfxM_Box); table.inbox(Ghost_Shake_II, "hi-light[fx]: Ghost Shake II","Syl",true,false,"#FD9601","#ADC4D6","#6A8DD6","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","shape.Rmove(10*ratio, 10*ratio, 0, fx.dur, 1, -2*frame_dur), format('\\\\bord0\\\\shad0\\\\blur1.4\\\\1c%s', shape.color1)","delay = 0","Lua",false); table.insert(hilight_fx_library, Ghost_Shake_II); table.insert(hilight_fx, "Ghost Shake II")
	Ghost_Shake_Multi = table.duplicate(PfxM_Box); table.inbox(Ghost_Shake_Multi, "hi-light[fx]: Ghost Shake Multi","Syl",true,false,"#E508DC","#FFFFFF","#6A8DD6","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","3","","syl.text","shape.Rmove(10*ratio, 10*ratio), format('\\\\bord0\\\\shad0\\\\blur0.8\\\\1c%s', color.module( color1, color2 ))","delay = 0; color1 = shape.color1; color2 = shape.color3","Lua",false); table.insert(hilight_fx_library, Ghost_Shake_Multi); table.insert(hilight_fx, "Ghost Shake Multi")
	Hidden_Clip_Left_Right = table.duplicate(PfxM_Box); table.inbox(Hidden_Clip_Left_Right, "hi-light[fx]: Hidden Clip Left Right","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","format('%s\\\\t(%s))', tag.clip(fx.pos_l, fx.pos_t, syl.widtht, syl.height), tag.clip(fx.pos_l + syl.widtht, fx.pos_t, 0, syl.height))","delay = 300"); table.insert(hilight_fx_library, Hidden_Clip_Left_Right); table.insert(hilight_fx, "Hidden Clip Left Right")
	Hidden_Clip_Top_Bottom = table.duplicate(PfxM_Box); table.inbox(Hidden_Clip_Top_Bottom, "hi-light[fx]: Hidden Clip Top Bottom","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","format('%s\\\\t(%s))', tag.clip(fx.pos_l, fx.pos_t, syl.widtht, syl.height), tag.clip(fx.pos_l, fx.pos_b, syl.widtht, 0))","delay = 300"); table.insert(hilight_fx_library, Hidden_Clip_Top_Bottom); table.insert(hilight_fx, "Hidden Clip Top Bottom")
	Halo_Border_Shine = table.duplicate(PfxM_Box); table.inbox(Halo_Border_Shine, "hi-light[fx]: Halo Border Shine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 300","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\shad0\\\\bord%s\\\\3c&HFFFFFF&\\\\1a&HFF&\\\\blur1\\\\t(\\\\blur4\\\\3a&HFF&\\\\fscx%s\\\\fscy%s)', 3*ratio, 1.8*l.scale_x, 1.8*l.scale_y)","","Lua",false); table.insert(hilight_fx_library, Halo_Border_Shine); table.insert(hilight_fx, "Halo Border Shine")
	Halo_Border_Shine_Multi = table.duplicate(PfxM_Box); table.inbox(Halo_Border_Shine_Multi, "hi-light[fx]: Halo Border Shine Multi","Syl",true,false,"#8AB9FC","#3F3C3C","#FFFFFF","100","0","0","l.start_time + syl.start_time + 1.2*syl.dur*module","fx.start_time + 350","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","syl.dur/100","","syl.text","format('\\\\fad(0,100)\\\\bord3\\\\blur1\\\\1a&HFF&\\\\3c%s\\\\3a%s\\\\t(\\\\fscx%s\\\\fscy%s\\\\blur4)', shape.color1, shape.alpha1, 2*l.scale_x, 2*l.scale_y)","","Lua",false); table.insert(hilight_fx_library, Halo_Border_Shine_Multi); table.insert(hilight_fx, "Halo Border Shine Multi")
	Halo_Border_Shine_Vertical = table.duplicate(PfxM_Box); table.inbox(Halo_Border_Shine_Vertical, "hi-light[fx]: Halo Border Shine Vertical","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","fx.start_time + syl.dur/2","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\shad0\\\\bord%s\\\\3c&HFFFFFF&\\\\1a&HFF&\\\\blur1\\\\t(\\\\blur4\\\\3a&HFF&\\\\fscx0\\\\fscy%s)', 2*ratio, 2.8*l.scale_y)","","Lua",false); table.insert(hilight_fx_library, Halo_Border_Shine_Vertical); table.insert(hilight_fx, "Halo Border Shine Vertical")
	Jitter_ShadOscill_Darkara = table.duplicate(PfxM_Box); table.inbox(Jitter_ShadOscill_Darkara, "hi-light[fx]: Jitter ShadOscill Darkara","Syl",true,false,"#AA32AB","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time + (j-1)*(dark_ciclo)","fx.start_time + dark_ciclo + tag.only(j == maxj, 0, var.loop.delay)","","","","","syl.center","syl.middle","","","5","1","fx.pos_x + var.loop.Dx, fx.pos_x","fx.pos_y + var.loop.Dy, fx.pos_y","","dark_loop","","syl.text","format(\"\\\\1c%s\\\\4c%s\\\\fscx%s\\\\fscy%s\\\\bord0\\\\blur1)\", color.module(shape.color1, shape.color4), color.module(shape.color4, shape.color1), 140 - 40*module, 140 - 40*module), tag.oscill(fx.dur, 80, \"\\\\xshad1.2\", \"\\\\xshad-1.2\")","dark_loop = syl.dur*0.01; dark_ciclo = syl.dur/dark_loop; delay=R(20,50); Dx=R(-5,5); Dy= R(-5,5)","Lua",false); table.insert(hilight_fx_library, Jitter_ShadOscill_Darkara); table.insert(hilight_fx, "Jitter ShadOscill Darkara")
	Jump_Alternate = table.duplicate(PfxM_Box); table.inbox(Jump_Alternate, "hi-light[fx]: Jump Alternate","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","shape.Lmove2( {fx.pos_x, fx.pos_y, fx.pos_x, fx.pos_y + jump*(-1)^syl.i, fx.pos_x, fx.pos_y}, {0, 80, 80, fx.dur} )","jump = 20","Lua",false); table.insert(hilight_fx_library, Jump_Alternate); table.insert(hilight_fx, "Jump Alternate")
	Jump_Gyre = table.duplicate(PfxM_Box); table.inbox(Jump_Gyre, "hi-light[fx]: Jump Gyre","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","shape.Lmove2( {fx.pos_x, fx.pos_y, fx.pos_x, fx.pos_y - jump, fx.pos_x, fx.pos_y}, {0, 80, 80, fx.dur} ), format(\"\\\\org(%s,%s)\\\\t(80,%s,\\\\fry360)\", fx.pos_x, fx.pos_y, fx.dur)","jump = 20","Lua",false); table.insert(hilight_fx_library, Jump_Gyre); table.insert(hilight_fx, "Jump Gyre")
	Jump_Multi = table.duplicate(PfxM_Box); table.inbox(Jump_Multi, "hi-light[fx]: Jump Multi","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","format(\"\\\\org(%s,%s)\", fx.pos_x - 10000, fx.pos_y), tag.oscill( fx.dur, 70, \"\\\\frz(0.12*(-1)^i)\" )","","Lua",false); table.insert(hilight_fx_library, Jump_Multi); table.insert(hilight_fx, "Jump Multi")
	Jump_Shine = table.duplicate(PfxM_Box); table.inbox(Jump_Shine, "hi-light[fx]: Jump Shine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","shape.Lmove2( {fx.pos_x, fx.pos_y, fx.pos_x, fx.pos_y - jump, fx.pos_x, fx.pos_y}, {0, 80, 80, fx.dur} ), format(\"\\\\shad0\\\\1c&HFFFFFF&\\\\3c&HFFFFFF&\\\\bord3\\\\blur4\\\\t(80,%s,\\\\1c%s\\\\3c%s\\\\bord%s\\\\blur0)\", fx.dur, text.color1, text.color3, l.outline)","jump = 20","Lua",false); table.insert(hilight_fx_library, Jump_Shine); table.insert(hilight_fx, "Jump Shine")
	Jump_Shine_II = table.duplicate(PfxM_Box); table.inbox(Jump_Shine_II, "hi-light[fx]: Jump Shine II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","2","","syl.text","format(\"\\\\org(%s,%s)\\\\t(0,80,\\\\fscx%s\\\\fscy%s\\\\frz0.1)\\\\t(120,%s,\\\\fscx%s\\\\fscy%s\\\\frz0)\", fx.pos_x - 10000, fx.pos_y, (1.1 + 0.4*(j - 1))*l.scale_x, (1.1 + 0.4*(j - 1))*l.scale_y, fx.dur, l.scale_x, l.scale_y ), tag.only( j == 2, \"\\\\1a&HFF&\\\\shad0\\\\3c&HFFFFFF&\\\\blur3\" )","","Lua",false); table.insert(hilight_fx_library, Jump_Shine_II); table.insert(hilight_fx, "Jump Shine II")
	Jump_Shine_II_an1 = table.duplicate(PfxM_Box); table.inbox(Jump_Shine_II_an1, "hi-light[fx]: Jump Shine II an1","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","1","1","fx.pos_l","fx.pos_b","","2","","syl.text","format(\"\\\\t(0,80,\\\\fscx%s\\\\fscy%s)\\\\t(120,%s,\\\\fscx%s\\\\fscy%s)\", (1.2 + 0.4*(j - 1))*l.scale_x, (1.2 + 0.4*(j - 1))*l.scale_y, fx.dur, l.scale_x, l.scale_y ), tag.only( j == 2, \"\\\\1a&HFF&\\\\shad0\\\\3c&HFFFFFF&\\\\blur3\" )","","Lua",false); table.insert(hilight_fx_library, Jump_Shine_II_an1); table.insert(hilight_fx, "Jump Shine II an1")
	Jump_Simple = table.duplicate(PfxM_Box); table.inbox(Jump_Simple, "hi-light[fx]: Jump Simple","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","shape.Lmove2( {fx.pos_x, fx.pos_y, fx.pos_x, fx.pos_y - jump, fx.pos_x, fx.pos_y}, {0, 80, 80, fx.dur} )","jump = 20","Lua",false); table.insert(hilight_fx_library, Jump_Simple); table.insert(hilight_fx, "Jump Simple")
	Move_Double_Syl_prehilight_Vertical = table.duplicate(PfxM_Box); table.inbox(Move_Double_Syl_prehilight_Vertical, "hi-light[fx]: Move Double Syl prehilight Vertical","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time - delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","2","fx.pos_x","fx.pos_y + Dy*(-1)^j, fx.pos_y","","2","","syl.text","\\bord0\\shad0\\1c&HFFFFFF&\\blur1.6\\t(\\blur3.2)\\fad(100,0)","delay = 320; Dy = 0.6*l.height","Automation Auto-4",false); table.insert(hilight_fx_library, Move_Double_Syl_prehilight_Vertical); table.insert(hilight_fx, "Move Double Syl prehilight Vertical")
	Move_Double_Syl_prehilight_Horizontal = table.duplicate(PfxM_Box); table.inbox(Move_Double_Syl_prehilight_Horizontal, "hi-light[fx]: Move Double Syl prehilight Horizontal","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time - delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","2","fx.pos_x + Dx*(-1)^j, fx.pos_x","fx.pos_y","","2","","syl.text","\\bord0\\shad0\\1c&HFFFFFF&\\blur1.6\\t(\\blur3.2)\\fad(100,0)","delay = 320; Dx = 0.6*l.height","Automation Auto-4",false); table.insert(hilight_fx_library, Move_Double_Syl_prehilight_Horizontal); table.insert(hilight_fx, "Move Double Syl prehilight Horizontal")
	Move_Four_Syl_prehilight_I = table.duplicate(PfxM_Box); table.inbox(Move_Four_Syl_prehilight_I, "hi-light[fx]: Move Four Syl prehilight I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time - delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","2","fx.pos_x + (j%2)*Dx*(-1)^ceil(j/2), fx.pos_x","fx.pos_y + ((j + 1)%2)*Dy*(-1)^ceil(j/2), fx.pos_y","","4","","syl.text","\\bord0\\shad0\\1c&HFFFFFF&\\blur1.6\\t(\\blur3.2)\\fad(100,0)","delay = 320; Dx = 0.6*l.height; Dy = 0.6*l.height","Automation Auto-4",false); table.insert(hilight_fx_library, Move_Four_Syl_prehilight_I); table.insert(hilight_fx, "Move Four Syl prehilight I")
	Move_Four_Syl_prehilight_II = table.duplicate(PfxM_Box); table.inbox(Move_Four_Syl_prehilight_II, "hi-light[fx]: Move Four Syl prehilight II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time - delay","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","2","fx.pos_x +Dx*(-1)^ceil(j/2), fx.pos_x","fx.pos_y + Dy*(-1)^j, fx.pos_y","","4","","syl.text","\\bord0\\shad0\\1c&HFFFFFF&\\blur1.6\\t(\\blur3.2)\\1a40\\fad(100,0)","delay = 320; Dx = 0.6*l.height; Dy = 0.6*l.height","Automation Auto-4",false); table.insert(hilight_fx_library, Move_Four_Syl_prehilight_II); table.insert(hilight_fx, "Move Four Syl prehilight II")
	Shineline_Clip_Move_Left_Right = table.duplicate(PfxM_Box); table.inbox(Shineline_Clip_Move_Left_Right, "hi-light[fx]: Shineline Clip Move Left Right","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","2","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\shad0\\\\blur3\\\\1vc%s\\\\3vc%s\\\\ybord%s%s\\\\t(%s))', color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'), 8*ratio, tag.clip(fx.pos_l, fx.pos_t -  l.fontsize, 2*ratio, 3*l.fontsize), tag.clip(fx.pos_r, fx.pos_t -  l.fontsize, 2*ratio, 3*l.fontsize))",""); table.insert(hilight_fx_library, Shineline_Clip_Move_Left_Right); table.insert(hilight_fx, "Shineline Clip Move Left Right")
	Simple_Shine = table.duplicate(PfxM_Box); table.inbox(Simple_Shine, "hi-light[fx]: Simple Shine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","1.3*l.scale_x, 1.3*l.scale_y","syl.text","format('\\\\1c&HFFFFFF&\\\\3c&HFFFFFF&\\\\shad0\\\\blur3\\\\t(\\\\1c%s\\\\3c%s\\\\fscx%s\\\\fscy%s\\\\blur1)\\\\fad(0,%s)', text.color1, text.color3, l.scale_x, l.scale_y, delay)","delay = 300","Lua",false); table.insert(hilight_fx_library, Simple_Shine); table.insert(hilight_fx, "Simple Shine")
	Simple_Shine_Alternate_Angle = table.duplicate(PfxM_Box); table.inbox(Simple_Shine_Alternate_Angle, "hi-light[fx]: Simple Shine Alternate Angle","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","1.3*l.scale_x, 1.3*l.scale_y","syl.text","format('\\\\1c&HFFFFFF&\\\\3c&HFFFFFF&\\\\shad0\\\\blur3\\\\fr%s\\\\t(\\\\1c%s\\\\3c%s\\\\fscx%s\\\\fscy%s\\\\blur1\\\\fr0)\\\\fad(0,%s)', angle*(-1)^syl.i, text.color1, text.color3, l.scale_x, l.scale_y, delay)","delay = 300; angle = 15","Lua",false); table.insert(hilight_fx_library, Simple_Shine_Alternate_Angle); table.insert(hilight_fx, "Simple Shine Alternate Angle")
	Simple_Shine_Ascent_Descent_I = table.duplicate(PfxM_Box); table.inbox(Simple_Shine_Ascent_Descent_I, "hi-light[fx]: Simple Shine Ascent Descent I","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","1.3*l.scale_x, 1.3*l.scale_y","syl.text","format('\\\\1c&HFFFFFF&\\\\3c&HFFFFFF&\\\\shad0\\\\blur3\\\\org(%s,%s)\\\\t(0,80,\\\\fr%s)\\\\t(80,%s,\\\\1c%s\\\\3c%s\\\\fscx%s\\\\fscy%s\\\\blur1\\\\fr0)\\\\fad(0,%s)', fx.move_x1 - 10000, fx.move_y1, angle*(-1)^syl.i, fx.dur, text.color1, text.color3, l.scale_x, l.scale_y, delay)","delay = 300; angle = 0.12","Lua",false); table.insert(hilight_fx_library, Simple_Shine_Ascent_Descent_I); table.insert(hilight_fx, "Simple Shine Ascent Descent I")
	Simple_Shine_Ascent_Descent_II = table.duplicate(PfxM_Box); table.inbox(Simple_Shine_Ascent_Descent_II, "hi-light[fx]: Simple Shine Ascent Descent II","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","1.3*l.scale_x, 1.3*l.scale_y","syl.text","format('\\\\1c&HFFFFFF&\\\\3c&HFFFFFF&\\\\shad0\\\\blur3\\\\org(%s,%s)\\\\fr%s\\\\t(\\\\1c%s\\\\3c%s\\\\fscx%s\\\\fscy%s\\\\blur1\\\\fr0)\\\\fad(0,%s)', fx.move_x1 - 10000, fx.move_y1, angle*(-1)^syl.i, text.color1, text.color3, l.scale_x, l.scale_y, delay)","delay = 300; angle = 0.12","Lua",false); table.insert(hilight_fx_library, Simple_Shine_Ascent_Descent_II); table.insert(hilight_fx, "Simple Shine Ascent Descent II")
	Slider_Syl_Cut = table.duplicate(PfxM_Box); table.inbox(Slider_Syl_Cut, "hi-light[fx]: Slider Syl Cut","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 300","","","","","syl.center","syl.middle","","","5","1","fx.pos_x, fx.pos_x + math.polar(var.syl.theta + 180*(j-1), var.syl.D, 'x')","fx.pos_y, fx.pos_y + math.polar(var.syl.theta + 180*(j-1), var.syl.D, 'y')","","2","","syl.text","tag.movevc(var.syl.slider(var.syl.D*syl.width/4, var.syl.theta + 180*(j-1))), '\\\\fad(0,200)'","D = 12*ratio; theta = R(72)*5; slider = function(val, angle) Shape = format('m 0 %d l %d %d l %d 0 l 0 0 l 0 %d l %d %d l 0 %d ', val/2, val, val/2, val, val, val, val, val) return shape.origin(shape.rotate(Shape, angle)) end"); table.insert(hilight_fx_library, Slider_Syl_Cut); table.insert(hilight_fx, "Slider Syl Cut")
	Slider_Syl_Cut_moves4 = table.duplicate(PfxM_Box); table.inbox(Slider_Syl_Cut_moves4, "hi-light[fx]: Slider Syl Cut moves4","Syl",true,false,"#FF0000","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 300","","","","","syl.center","syl.middle","","","5","1","fx.pos_x, fx.pos_x + math.polar(var.syl.theta, var.syl.D, 'x')*(-1)^j, fx.pos_x - math.polar(var.syl.theta, var.syl.D, 'x')*(-1)^j, fx.pos_x","fx.pos_y, fx.pos_y + math.polar(var.syl.theta, var.syl.D, 'y')*(-1)^j, fx.pos_y - math.polar(var.syl.theta, var.syl.D, 'y')*(-1)^j, fx.pos_y","","2","","syl.text","tag.movevc(var.syl.slider(var.syl.D*syl.width/10, var.syl.theta)), format('\\\\t(\\\\1vc%s)\\\\fad(0,100)', shape.color1)","D = 45*ratio, theta = R(72)*5, slider = function(val, angle) Shape = format('m 0 0 l %d 0 m 0 %d l %d %d m 0 %d l 0 %d l %d %d l %d %d l 0 %d ', val, val, val, val, (val/maxj)*(j-1), (val/maxj)*j, val, (val/maxj)*j, val, (val/maxj)*(j-1), (val/maxj)*(j-1)) return shape.origin(shape.rotate(Shape, angle)) end"); table.insert(hilight_fx_library, Slider_Syl_Cut_moves4); table.insert(hilight_fx, "Slider Syl Cut moves4")
	Slider_Syl_Cut_Multi = table.duplicate(PfxM_Box); table.inbox(Slider_Syl_Cut_Multi, "hi-light[fx]: Slider Syl Cut Multi","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 300","","","","","syl.center","syl.middle","","","5","1","fx.pos_x, fx.pos_x + math.polar(var.syl.theta, var.syl.D, 'x')*(-1)^j","fx.pos_y, fx.pos_y + math.polar(var.syl.theta, var.syl.D, 'y')*(-1)^j","","ceil(syl.width/8)","","syl.text","tag.movevc(var.syl.slider(var.syl.D*syl.width/10, var.syl.theta)), '\\\\fad(0,200)'","D = 12*ratio, theta = R(72)*5, slider = function(val, angle) Shape = format('m 0 0 l %d 0 m 0 %d l %d %d m 0 %d l 0 %d l %d %d l %d %d l 0 %d ', val, val, val, val, (val/maxj)*(j-1), (val/maxj)*j, val, (val/maxj)*j, val, (val/maxj)*(j-1), (val/maxj)*(j-1)) return shape.origin(shape.rotate(Shape, angle)) end"); table.insert(hilight_fx_library, Slider_Syl_Cut_Multi); table.insert(hilight_fx, "Slider Syl Cut Multi")
	Spark_Shine_I = table.duplicate(PfxM_Box); table.inbox(Spark_Shine_I, "hi-light[fx]: Spark Shine I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + var.loop.delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","12","l.scale_x, 1.2*l.scale_y","syl.text","format('\\\\1vc%s\\\\shad0\\\\bord0\\\\blur2\\\\org(%s,%s)\\\\1va%s\\\\t(0,80,\\\\fr%s)\\\\t(80,%s,\\\\fr0)\\\\fad(0,%s)', color.vc('&HFFFFFF&'), -10000*ratio, fx.pos_y, alpha.va(interpolate_alpha(module, var.loop.alpha1, var.loop.alpha2)), math.round(var.loop.angle*module, 3), fx.dur, var.loop.delay)","angle = 0.24, delay = 300, alpha1 = ass_alpha(140), alpha2 = ass_alpha(230)"); table.insert(hilight_fx_library, Spark_Shine_I); table.insert(hilight_fx, "Spark Shine I")
	Spark_Shine_I_Left = table.duplicate(PfxM_Box); table.inbox(Spark_Shine_I_Left, "hi-light[fx]: Spark Shine I Left","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + var.loop.delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","12","l.scale_x, 1.2*l.scale_y","syl.text","format('\\\\1vc%s\\\\shad0\\\\bord0\\\\blur2\\\\org(%s,%s)\\\\1va%s\\\\t(0,80,\\\\fr%s)\\\\t(80,%s,\\\\fr0)\\\\fad(0,%s)', color.vc('&HFFFFFF&'), fx.pos_x, -10000*ratio, alpha.va(interpolate_alpha(module, var.loop.alpha1, var.loop.alpha2)), math.round(-var.loop.angle*module, 3), fx.dur, var.loop.delay)","angle = 0.24, delay = 300, alpha1 = ass_alpha(150), alpha2 = ass_alpha(230)"); table.insert(hilight_fx_library, Spark_Shine_I_Left); table.insert(hilight_fx, "Spark Shine I Left")
	Spark_Shine_I_Left_Right = table.duplicate(PfxM_Box); table.inbox(Spark_Shine_I_Left_Right, "hi-light[fx]: Spark Shine I Left Right","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time-50","l.start_time + syl.end_time+50","","","","0","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","10","l.scale_x, 1.2*l.scale_y","syl.text","format('\\\\1vc%s\\\\shad0\\\\bord0\\\\blur2\\\\fr%s\\\\org(%s,%s)\\\\1va%s\\\\t(\\\\fr%s)\\\\fad(50,50)', color.vc('&HFFFFFF&'), math.round(-var.loop.angle*module, 3), fx.pos_x, -10000*ratio, alpha.va(interpolate_alpha(module, var.loop.alpha1, var.loop.alpha2)), math.round(var.loop.angle*module, 3))","angle = 0.3, alpha1 = ass_alpha(150), alpha2 = ass_alpha(230)"); table.insert(hilight_fx_library, Spark_Shine_I_Left_Right); table.insert(hilight_fx, "Spark Shine I Left Right")
	Spark_Shine_I_Right = table.duplicate(PfxM_Box); table.inbox(Spark_Shine_I_Right, "hi-light[fx]: Spark Shine I Right","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + var.loop.delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","12","l.scale_x, 1.2*l.scale_y","syl.text","format('\\\\1vc%s\\\\shad0\\\\bord0\\\\blur2\\\\org(%s,%s)\\\\1va%s\\\\t(0,80,\\\\fr%s)\\\\t(80,%s,\\\\fr0)\\\\fad(0,%s)', color.vc('&HFFFFFF&'), fx.pos_x, -10000*ratio, alpha.va(interpolate_alpha(module, var.loop.alpha1, var.loop.alpha2)), math.round(var.loop.angle*module, 3), fx.dur, var.loop.delay)","angle = 0.24, delay = 300, alpha1 = ass_alpha(150), alpha2 = ass_alpha(230)"); table.insert(hilight_fx_library, Spark_Shine_I_Right); table.insert(hilight_fx, "Spark Shine I Right")
	Spark_Shine_II = table.duplicate(PfxM_Box); table.inbox(Spark_Shine_II, "hi-light[fx]: Spark Shine II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + var.loop.delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","12","","syl.text","format('\\\\1vc%s\\\\shad0\\\\bord0\\\\org(%s,%s)\\\\1va(%s,%s,%s,%s)\\\\t(0,80,\\\\fr%s\\\\blur1.5\\\\t(80,%s,\\\\fscx%s\\\\fscy%s\\\\blur3)\\\\be1\\\\fad(0,%s)', color.vc('&HFFFFFF&'), -10000*ratio, fx.pos_y, var.loop.a1, var.loop.a2, var.loop.a3, var.loop.a4, math.round(var.loop.angle*(2*module - 1), 3), fx.dur, 0.6*l.scale_x, 1.3*l.scale_y, var.loop.delay)","angle = 0.1, delay = 300, a1 = ass_alpha(R(100,250)), a2 = ass_alpha(R(100,250)), a3 = ass_alpha(R(100,250)), a4 = ass_alpha(R(100,250))"); table.insert(hilight_fx_library, Spark_Shine_II); table.insert(hilight_fx, "Spark Shine II")
	Spark_Shine_II_Horizontal = table.duplicate(PfxM_Box); table.inbox(Spark_Shine_II_Horizontal, "hi-light[fx]: Spark Shine II Horizontal","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time - var.loop.delay","l.start_time + syl.end_time + var.loop.delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","12","1.2*l.scale_x, 1.2*l.scale_y","syl.text","format('\\\\1vc%s\\\\shad0\\\\bord0\\\\org(%s,%s)\\\\1va(%s,%s,%s,%s)\\\\t(0,80,\\\\fr%s\\\\blur1.5\\\\t(80,%s,\\\\fscy%s\\\\blur2)\\\\be1\\\\fad(100,100)', color.vc('&HFFFFFF&'), fx.pos_x, -10000*ratio, var.loop.a1, var.loop.a2, var.loop.a3, var.loop.a4, math.round(var.loop.angle*(2*module - 1), 3), fx.dur, l.scale_y)","angle = 0.12, delay = 100, a1 = ass_alpha(R(100,250)), a2 = ass_alpha(R(100,250)), a3 = ass_alpha(R(100,250)), a4 = ass_alpha(R(100,250))"); table.insert(hilight_fx_library, Spark_Shine_II_Horizontal); table.insert(hilight_fx, "Spark Shine II Horizontal")
	Spark_Shine_III_Dance = table.duplicate(PfxM_Box); table.inbox(Spark_Shine_III_Dance, "hi-light[fx]: Spark Shine III Dance","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time + var.loop.delay1*module","l.start_time + syl.end_time + var.loop.delay2 - var.loop.delay1*module","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","12","l.scale_x, 1.2*l.scale_y","syl.text","format('\\\\shad0\\\\bord0\\\\1vc%s\\\\blur2\\\\fsvp%s\\\\1a%s\\\\org(%s,%s)%s\\\\fad(0,%s)', color.vc('&HFFFFFF&'), var.loop.height*module, interpolate_alpha(module, var.loop.a1, var.loop.a2), fx.pos_x, fx.pos_y - 10000*ratio, tag.oscill(fx.dur, 120, '\\\\fr-0.024', '\\\\fr0.024'), var.loop.delay1)","delay1 = 150, delay2 = 500, height = 28*ratio, a1 = ass_alpha(120), a2 = ass_alpha(240)"); table.insert(hilight_fx_library, Spark_Shine_III_Dance); table.insert(hilight_fx, "Spark Shine III Dance")
	Syl_Deformed_I = table.duplicate(PfxM_Box); table.inbox(Syl_Deformed_I, "hi-light[fx]: Syl Deformed I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","1.35*l.scale_x, 1.35*l.scale_y","syl.text","tag.oscill( fx.dur, 2*frame_dur, \"\\\\faxRc(-0.12,0.12)\\\\fayRc(-0.12,0.12)\\\\frxR(-8,8)\\\\fryR(-8,8)\\\\frzR(-8,8)\" ), format(\"\\\\t(\\\\fscx%s\\\\fscy%s)\", l.scale_x, l.scale_y)","","Lua",false); table.insert(hilight_fx_library, Syl_Deformed_I); table.insert(hilight_fx, "Syl Deformed I")
	Syl_Deformed_II = table.duplicate(PfxM_Box); table.inbox(Syl_Deformed_II, "hi-light[fx]: Syl Deformed II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","1.35*l.scale_x, 1.35*l.scale_y","syl.text","shape.Rmove( 10, 10, 0, fx.dur, 1, {2.6*frame_dur} ), tag.oscill( fx.dur, 2*frame_dur, \"\\\\faxRc(-0.15,0.15)\\\\fayRc(-0.15,0.15)\" ), format(\"\\\\t(\\\\fscx%s\\\\fscy%s)\", l.scale_x, l.scale_y)","","Lua",false); table.insert(hilight_fx_library, Syl_Deformed_II); table.insert(hilight_fx, "Syl Deformed II")
	Syl_Zomm_fry = table.duplicate(PfxM_Box); table.inbox(Syl_Zomm_fry, "hi-light[fx]: Syl Zomm fry","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\t(0,60,\\\\fscx%s\\\\fscy%s)\\\\t(%s,%s,\\\\fscx%s\\\\fscy%s\\\\fry360)', 1.2*l.scale_x, 1.2*l.scale_y, fx.dur - 120, fx.dur, l.scale_x, l.scale_y)",""); table.insert(hilight_fx_library, Syl_Zomm_fry); table.insert(hilight_fx, "Syl Zomm fry")
	
	
	--lead-out FX List
	Asault_Leadout = table.duplicate(PfxM_Box); table.inbox(Asault_Leadout, "lead-out[fx]: Asault Leadout","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.loop.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y - var.syl.dy","fx.dur - 400, fx.dur - 200","1","l.scale_x, l.scale_y","char.text","format('\\\\org(%s,%s)\\\\t(%s,%s,0.5,\\\\frx180\\\\fscx%s\\\\blur3)\\\\t(%s,%s,\\\\fscy%s)\\\\fad(0,150)', fx.pos_x, fx.pos_y, fx.dur - 400, fx.dur, 0.3*l.scale_x, fx.dur - 400, fx.dur, 3*l.scale_y)","delay = R(400, 800), dy = 100"); table.insert(leadout_fx_library, Asault_Leadout); table.insert(leadout_fx, "Asault Leadout")
	Asault_Line_Leadout = table.duplicate(PfxM_Box); table.inbox(Asault_Line_Leadout, "lead-out[fx]: Asault Line Leadout","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.syl.delay + 25*(syl.i - syl.n +1)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x - var.syl.d1","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","l.scale_x, l.scale_y","syl.text","format('\\\\org(%s,%s)\\\\t(%s,%s,\\\\frx180)\\\\fad(0,300)', fx.pos_x - var.syl.d2*(1 - 2*(syl.i - 1)/(syl.n - 2)), fx.pos_y + var.syl.d2/2, fx.dur - var.syl.delay, fx.dur)","delay = 500, d1 = 150*ratio*(1 - 2*(syl.i - 1)/(syl.n - 2)), d2 = 100*ratio"); table.insert(leadout_fx_library, Asault_Line_Leadout); table.insert(leadout_fx, "Asault Line Leadout")
	Distort_in_Line_I = table.duplicate(PfxM_Box); table.inbox(Distort_in_Line_I, "lead-out[fx]: Distort in Line I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + var.syl.delay1 + var.syl.delay2*j","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x - var.syl.dx","fx.pos_y, fx.pos_y","fx.dur - var.loop.delay1, fx.dur","3","","syl.text","tag.clip(0, fx.pos_t, meta.res_x, syl.height), format('\\\\t(%s,%s,0.7,\\\\frx360)\\\\fad(0,300)', fx.dur - var.loop.delay1, fx.dur)","delay1 = 500, delay2 = 100, dx = 180*ratio"); table.insert(leadout_fx_library, Distort_in_Line_I); table.insert(leadout_fx, "Distort in Line I")
	Distort_in_Syl_I = table.duplicate(PfxM_Box); table.inbox(Distort_in_Syl_I, "lead-out[fx]: Distort in Syl I","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\org(%s,%s)\\\\t(%s,%s,\\\\bord2\\\\shad0)\\\\t(%s,%s,0.8,\\\\rnd7\\\\blur10\\\\fscy%s)\\\\fad(0,250)', fx.pos_x, -10000*ratio, fx.dur - 501, fx.dur - 500, fx.dur - 500, fx.dur, 0.55*l.scale_y)",""); table.insert(leadout_fx_library, Distort_in_Syl_I); table.insert(leadout_fx, "Distort in Syl I")
	Distort_in_Syl_I_buttLine = table.duplicate(PfxM_Box); table.inbox(Distort_in_Syl_I_buttLine, "lead-out[fx]: Distort in Syl I buttLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid2(70) + 70*syl.n","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","0, fx.dur","1","","syl.text","format('\\\\org(%s,%s)\\\\t(%s,%s,\\\\bord2\\\\shad0)\\\\t(%s,%s,0.8,\\\\rnd6\\\\blur10\\\\fscy%s)\\\\fad(0,150)', fx.pos_x, -10000*ratio, fx.dur - 501, fx.dur - 500, fx.dur - 500, fx.dur, 0.55*l.scale_y)",""); table.insert(leadout_fx_library, Distort_in_Syl_I_buttLine); table.insert(leadout_fx, "Distort in Syl I buttLine")
	Distort_in_Syl_I_Inverse = table.duplicate(PfxM_Box); table.inbox(Distort_in_Syl_I_Inverse, "lead-out[fx]: Distort in Syl I Inverse","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","l.scale_x, l.scale_y","syl.text","format('\\\\org(%s,%s)\\\\t(%s,%s,\\\\bord2\\\\shad0)\\\\t(%s,%s,0.8,\\\\rnd6\\\\blur10\\\\fscy%s)\\\\fad(0,250)', fx.pos_x, -10000*ratio, fx.dur - 501, fx.dur - 500, fx.dur - 500, fx.dur, 0.55*l.scale_y)",""); table.insert(leadout_fx_library, Distort_in_Syl_I_Inverse); table.insert(leadout_fx, "Distort in Syl I Inverse")
	Distort_in_Syl_I_midLine = table.duplicate(PfxM_Box); table.inbox(Distort_in_Syl_I_midLine, "lead-out[fx]: Distort in Syl I midLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid1(70)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","0, fx.dur","1","","syl.text","format('\\\\org(%s,%s)\\\\t(%s,%s,\\\\bord2\\\\shad0)\\\\t(%s,%s,0.8,\\\\rnd6\\\\blur10\\\\fscy%s)\\\\fad(0,150)', fx.pos_x, -10000*ratio, fx.dur - 501, fx.dur - 500, fx.dur - 500, fx.dur, 0.55*l.scale_y)",""); table.insert(leadout_fx_library, Distort_in_Syl_I_midLine); table.insert(leadout_fx, "Distort in Syl I midLine")
	Emerge_Clip_Grip_I = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_I, "lead-out[fx]: Emerge Clip Grip I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 60*(syl.i - syl.n/2 - 1) + 100","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - 450, fx.dur","5, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Grip_I); table.insert(leadout_fx, "Emerge Clip Grip I")
	Emerge_Clip_Grip_I_buttLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_I_buttLine, "lead-out[fx]: Emerge Clip Grip I buttLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + time_mid2(70) + 70*syl.n","","","","0","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","6, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Grip_I_buttLine); table.insert(leadout_fx, "Emerge Clip Grip I buttLine")
	Emerge_Clip_Grip_I_Inverse = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_I_Inverse, "lead-out[fx]: Emerge Clip Grip I Inverse","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - 450, fx.dur","5, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Grip_I_Inverse); table.insert(leadout_fx, "Emerge Clip Grip I Inverse")
	Emerge_Clip_Grip_I_midLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_I_midLine, "lead-out[fx]: Emerge Clip Grip I midLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + time_mid1(70)","","","","0","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","6, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Grip_I_midLine); table.insert(leadout_fx, "Emerge Clip Grip I midLine")
	Emerge_Clip_Grip_II = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_II, "lead-out[fx]: Emerge Clip Grip II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 60*(syl.i - syl.n/2 - 1) + 100","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","5, loop_h","","syl.text","format('%s\\\\t(%s,%s,%s)\\\\fad(0,200)', tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), fx.dur - var.loop.delay, fx.dur, tag.clip(fx.pos_l + var.loop.dx, fx.pos_t + var.loop.dy, syl.width, syl.height))","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Grip_II); table.insert(leadout_fx, "Emerge Clip Grip II")
	Emerge_Clip_Grip_II_buttLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_II_buttLine, "lead-out[fx]: Emerge Clip Grip II buttLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + time_mid2(70) + 70*syl.n","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","5, loop_h","","syl.text","format('%s\\\\t(%s,%s,%s)\\\\fad(0,200)', tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), fx.dur - var.loop.delay, fx.dur, tag.clip(fx.pos_l + var.loop.dx, fx.pos_t + var.loop.dy, syl.width, syl.height))","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Grip_II_buttLine); table.insert(leadout_fx, "Emerge Clip Grip II buttLine")
	Emerge_Clip_Grip_II_Inverse = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_II_Inverse, "lead-out[fx]: Emerge Clip Grip II Inverse","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","5, loop_h","","syl.text","format('%s\\\\t(%s,%s,%s)\\\\fad(0,200)', tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), fx.dur - var.loop.delay, fx.dur, tag.clip(fx.pos_l + var.loop.dx, fx.pos_t + var.loop.dy, syl.width, syl.height))","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Grip_II_Inverse); table.insert(leadout_fx, "Emerge Clip Grip II Inverse")
	Emerge_Clip_Grip_II_midLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_II_midLine, "lead-out[fx]: Emerge Clip Grip II midLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + time_mid1(70)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","5, loop_h","","syl.text","format('%s\\\\t(%s,%s,%s)\\\\fad(0,200)', tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), fx.dur - var.loop.delay, fx.dur, tag.clip(fx.pos_l + var.loop.dx, fx.pos_t + var.loop.dy, syl.width, syl.height))","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Grip_II_midLine); table.insert(leadout_fx, "Emerge Clip Grip II midLine")
	Emerge_Clip_Grip_III = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Grip_III, "lead-out[fx]: Emerge Clip Grip III","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 70*(syl.i - syl.n + 1) + R(var.loop.d1 - var.loop.d2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","5, loop_h","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,150)'","d1 = 1000, d2 = 300"); table.insert(leadout_fx_library, Emerge_Clip_Grip_III); table.insert(leadout_fx, "Emerge Clip Grip III")
	Emerge_Clip_Horizontal_I = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Horizontal_I, "lead-out[fx]: Emerge Clip Horizontal I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 60*(syl.i - syl.n/2 - 1) + 100","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - 450, fx.dur","ceil(syl.height/5)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Horizontal_I); table.insert(leadout_fx, "Emerge Clip Horizontal I")
	Emerge_Clip_Horizontal_I_buttLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Horizontal_I_buttLine, "lead-out[fx]: Emerge Clip Horizontal I buttLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + time_mid2(70) + 70*syl.n","","","","0","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","ceil(syl.height/5)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Horizontal_I_buttLine); table.insert(leadout_fx, "Emerge Clip Horizontal I buttLine")
	Emerge_Clip_Horizontal_I_Inverse = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Horizontal_I_Inverse, "lead-out[fx]: Emerge Clip Horizontal I Inverse","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - 450, fx.dur","ceil(syl.height/5)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Horizontal_I_Inverse); table.insert(leadout_fx, "Emerge Clip Horizontal I Inverse")
	Emerge_Clip_Horizontal_I_mid_line = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Horizontal_I_mid_line, "lead-out[fx]: Emerge Clip Horizontal I mid line","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + time_mid1(70)","","","","0","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","ceil(syl.height/5)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Horizontal_I_mid_line); table.insert(leadout_fx, "Emerge Clip Horizontal I mid line")
	Emerge_Clip_Vertical_I = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Vertical_I, "lead-out[fx]: Emerge Clip Vertical I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 60*(syl.i - syl.n/2 - 1) + 100","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - 450, fx.dur","1, ceil(syl.width/6)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Vertical_I); table.insert(leadout_fx, "Emerge Clip Vertical I")
	Emerge_Clip_Vertical_I_buttLine = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Vertical_I_buttLine, "lead-out[fx]: Emerge Clip Vertical I buttLine","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + time_mid2(70) + 70*syl.n","","","","0","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","1, ceil(syl.width/6)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Vertical_I_buttLine); table.insert(leadout_fx, "Emerge Clip Vertical I buttLine")
	Emerge_Clip_Vertical_I_Inverse = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Vertical_I_Inverse, "lead-out[fx]: Emerge Clip Vertical I Inverse","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - 450, fx.dur","1, ceil(syl.width/6)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Vertical_I_Inverse); table.insert(leadout_fx, "Emerge Clip Vertical I Inverse")
	Emerge_Clip_Vertical_I_mid_line = table.duplicate(PfxM_Box); table.inbox(Emerge_Clip_Vertical_I_mid_line, "lead-out[fx]: Emerge Clip Vertical I mid line","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + time_mid1(70)","","","","0","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay, fx.dur","1, ceil(syl.width/6)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height), '\\\\fad(0,300)'","delay = 450, dx = R(-30, 30)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Emerge_Clip_Vertical_I_mid_line); table.insert(leadout_fx, "Emerge Clip Vertical I mid line")
	Function_Alpha_Delay = table.duplicate(PfxM_Box); table.inbox(Function_Alpha_Delay, "lead-out[fx]: Function Alpha Delay","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 60*(syl.i - syl.n + 8) + var.loop.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","alpha.delay(fx.dur - 1000, 250, '&H00&', '&HFF&', '\\\\1va', '\\\\3va'), '\\\\fad(0,120)'","delay = 600 - R(0, 20)*10"); table.insert(leadout_fx_library, Function_Alpha_Delay); table.insert(leadout_fx, "Function Alpha Delay")
	Function_Alpha_Mask = table.duplicate(PfxM_Box); table.inbox(Function_Alpha_Mask, "lead-out[fx]: Function Alpha Mask","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","alpha.mask('\\\\1va', text.alpha1a), '\\\\fad(0,300)'",""); table.insert(leadout_fx_library, Function_Alpha_Mask); table.insert(leadout_fx, "Function Alpha Mask")
	Function_Alpha_Move_Mask = table.duplicate(PfxM_Box); table.inbox(Function_Alpha_Move_Mask, "lead-out[fx]: Function Alpha Move Mask","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","alpha.movemask(fx.dur, 300, '\\\\1va', text.alpha1a), '\\\\fad(0,300)'",""); table.insert(leadout_fx_library, Function_Alpha_Move_Mask); table.insert(leadout_fx, "Function Alpha Move Mask")
	Function_Color_Gradient_Vertical = table.duplicate(PfxM_Box); table.inbox(Function_Color_Gradient_Vertical, "lead-out[fx]: Function Color Gradient Vertical","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\1vc%s\\\\fad(0,300)', color.gradientv('&HFFFFFF&', '&HFE8D00&'))",""); table.insert(leadout_fx_library, Function_Color_Gradient_Vertical); table.insert(leadout_fx, "Function Color Gradient Vertical")
	Function_Color_Gradient_Horizontal = table.duplicate(PfxM_Box); table.inbox(Function_Color_Gradient_Horizontal, "lead-out[fx]: Function Color Gradient Horizontal","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\1vc%s\\\\fad(0,300)', color.gradienth('&HFFFFFF&', '&HFE8D00&'))",""); table.insert(leadout_fx_library, Function_Color_Gradient_Horizontal); table.insert(leadout_fx, "Function Color Gradient Horizontal")
	Function_Color_Grandient_Horizontal_II = table.duplicate(PfxM_Box); table.inbox(Function_Color_Grandient_Horizontal_II, "lead-out[fx]: Function Color Grandient Horizontal II","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\1vc%s\\\\fad(0,300)', color.gradienth('&HFFFFFF&', '&HFE8D00&', '1 - abs(2*%s - 1)'))",""); table.insert(leadout_fx_library, Function_Color_Grandient_Horizontal_II); table.insert(leadout_fx, "Function Color Grandient Horizontal II")
	Function_Color_Mask = table.duplicate(PfxM_Box); table.inbox(Function_Color_Mask, "lead-out[fx]: Function Color Mask","Syl",true,false,"#FFFFFF","#67D7FE","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","color.mask('\\\\1vc', '&HFED767&'), '\\\\bord0\\\\fad(0,300)'",""); table.insert(leadout_fx_library, Function_Color_Mask); table.insert(leadout_fx, "Function Color Mask")
	Function_Color_Move_Mask = table.duplicate(PfxM_Box); table.inbox(Function_Color_Move_Mask, "lead-out[fx]: Function Color Move Mask","Syl",true,false,"#FFFFFF","#67D7FE","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","color.movemask(fx.dur, 320, '\\\\1vc', '&HFED767&', '&H433E30&'), '\\\\bord0\\\\fad(0,300)'",""); table.insert(leadout_fx_library, Function_Color_Move_Mask); table.insert(leadout_fx, "Function Color Move Mask")
	Function_Color_Move_Mask_Vertical = table.duplicate(PfxM_Box); table.inbox(Function_Color_Move_Mask_Vertical, "lead-out[fx]: Function Color Move Mask Vertical","Syl",true,false,"#FFFFFF","#67D7FE","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","color.movemaskv(fx.dur, 320, '\\\\1vc', '&HFF10B5&'), '\\\\bord0\\\\fad(0,300)'",""); table.insert(leadout_fx_library, Function_Color_Move_Mask_Vertical); table.insert(leadout_fx, "Function Color Move Mask Vertical")
	Function_Color_Set = table.duplicate(PfxM_Box); table.inbox(Function_Color_Set, "lead-out[fx]: Function Color Set","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","'\\\\fad(0,300)', color.set(var.syl.times, var.syl.colors, '\\\\1vc')","times = {'0:00:46.066','0:00:47.300','0:00:48.535','0:00:49.306','0:00:50.200','0:00:51.116','0:00:53.066','0:00:54.005'}, colors = {'&HB82AFB&','&HFB7E35&','&H4414FA&','&HB82AFB&','&H44AAFA&','&HFB7E35&','&HB82AFB&','&HBFFAFB&'}"); table.insert(leadout_fx_library, Function_Color_Set); table.insert(leadout_fx, "Function Color Set")
	Function_MoveVC = table.duplicate(PfxM_Box); table.inbox(Function_MoveVC, "lead-out[fx]: Function MoveVC","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.loop.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.dx","fx.pos_y, fx.pos_y + var.loop.dy","fx.dur - var.loop.delay + 70*j, fx.dur","1, shape.movevc(shape.multi1('default', 4), 'loops')","","syl.text","shape.movevc(shape.multi1('default', 4), 'tag'), '\\\\fad(0,200)'","delay = 600, dx = R(-25, 25)*ratio, dy = R(-25, 25)*ratio"); table.insert(leadout_fx_library, Function_MoveVC); table.insert(leadout_fx, "Function MoveVC")
	Function_Oscill_Color_and_Blur_Char = table.duplicate(PfxM_Box); table.inbox(Function_Oscill_Color_and_Blur_Char, "lead-out[fx]: Function Oscill Color and Blur Char","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + 300","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","tag.oscill(fx.dur, 300, '\\\\3vc'..color.vc('&HFF8D00&'), '\\\\3vc'..color.vc('&HFF00FF&'), '\\\\3vc'..color.vc('&H00FF00&'), tag.oscill(fx.dur, 300, '\\\\blur4', '\\\\blur1'), '\\\\bord3\\\\fad(0,300)'",""); table.insert(leadout_fx_library, Function_Oscill_Color_and_Blur_Char); table.insert(leadout_fx, "Function Oscill Color and Blur Char")
	Function_Oscill_Snake_Move_Char = table.duplicate(PfxM_Box); table.inbox(Function_Oscill_Snake_Move_Char, "lead-out[fx]: Function Oscill Snake Move Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + 300","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","tag.oscill({fx.dur - var.syl.delay, fx.dur}, 120, '\\\\fsvp'..var.syl.height, '\\\\fsvp'..-var.syl.height), '\\\\fad(0,300)'","height = 4*ratio, delay = 800"); table.insert(leadout_fx_library, Function_Oscill_Snake_Move_Char); table.insert(leadout_fx, "Function Oscill Snake Move Char")
	Flashing_Outro_Aux = table.duplicate(PfxM_Box); table.inbox(Flashing_Outro_Aux, "lead-out[fx]: Flashing Outro Aux","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.end_time","l.end_time + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","16","","syl.text","format('\\\\org(%s,%s)\\\\bord0\\\\shad0\\\\blur3\\\\1va%s\\\\t(%s,%s,0.8,\\\\fr%s)', var.syl.orgx, var.syl.orgy, alpha.va('&HDD&'), fx.dur - var.syl.delay, fx.dur, 2*var.syl.a*module - var.syl.a)","delay = 400, orgx = syl.center - 10000*ratio, orgy = syl.middle, a = 0.2"); table.insert(leadout_fx_library, Flashing_Outro_Aux); table.insert(leadout_fx, "Flashing Outro Aux")
	Helical_Char_Leadout = table.duplicate(PfxM_Box); table.inbox(Helical_Char_Leadout, "lead-out[fx]: Helical Char Leadout","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + 1.5*var.char.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + var.char.d*(-1)^j + (2*var.char.d*(-1)^(j+1))*(char.i-1)/char.n","fx.dur - 1.5*var.char.delay, fx.dur","2","","char.text","format('\\\\fad(0,300)\\\\org(%s,%s)\\\\1va%s\\\\3va%s\\\\4va%s\\\\t(%s,%s,0.8,\\\\frx180)\\\\t(%s,%s,\\\\1va%s\\\\3va%s\\\\4va%s)',fx.pos_x, fx.pos_y, alpha.va(var.loop.a1),  alpha.va(var.loop.a3),  alpha.va(var.loop.a4), fx.dur - var.char.delay, fx.dur, fx.dur - var.char.delay - 301, fx.dur - var.char.delay - 300, text.alpha1, text.alpha3, text.alpha4)","delay = 450, d = 70*ratio, a1 = tag.only(j==1, '&HFF&', text.alpha1a), a3 = tag.only(j==1, '&HFF&', text.alpha3a), a4 = tag.only(j==1, '&HFF&', text.alpha4a)"); table.insert(leadout_fx_library, Helical_Char_Leadout); table.insert(leadout_fx, "Helical Char Leadout")
	Helical_Char_Leadout_buttLine = table.duplicate(PfxM_Box); table.inbox(Helical_Char_Leadout_buttLine, "lead-out[fx]: Helical Char Leadout buttLine","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid2(35) + 35*char.n","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + var.char.d*(-1)^j + (2*var.char.d*(-1)^(j+1))*(char.i-1)/char.n","fx.dur - 1.5*var.char.delay, fx.dur","2","","char.text","format('\\\\fad(0,300)\\\\org(%s,%s)\\\\1va%s\\\\3va%s\\\\4va%s\\\\t(%s,%s,0.8,\\\\frx180)\\\\t(%s,%s,\\\\1va%s\\\\3va%s\\\\4va%s)',fx.pos_x, fx.pos_y, alpha.va(var.loop.a1),  alpha.va(var.loop.a3),  alpha.va(var.loop.a4), fx.dur - var.char.delay, fx.dur, fx.dur - var.char.delay - 301, fx.dur - var.char.delay - 300, text.alpha1, text.alpha3, text.alpha4)","delay = 450, d = 70*ratio, a1 = tag.only(j==1, '&HFF&', text.alpha1a), a3 = tag.only(j==1, '&HFF&', text.alpha3a), a4 = tag.only(j==1, '&HFF&', text.alpha4a)"); table.insert(leadout_fx_library, Helical_Char_Leadout_buttLine); table.insert(leadout_fx, "Helical Char Leadout buttLine")
	Helical_Char_Leadout_Inverse = table.duplicate(PfxM_Box); table.inbox(Helical_Char_Leadout_Inverse, "lead-out[fx]: Helical Char Leadout Inverse","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + var.char.d*(-1)^j + (2*var.char.d*(-1)^(j+1))*(char.i-1)/char.n","fx.dur - 1.5*var.char.delay, fx.dur","2","","char.text","format('\\\\fad(0,300)\\\\org(%s,%s)\\\\1va%s\\\\3va%s\\\\4va%s\\\\t(%s,%s,0.8,\\\\frx180)\\\\t(%s,%s,\\\\1va%s\\\\3va%s\\\\4va%s)',fx.pos_x, fx.pos_y, alpha.va(var.loop.a1),  alpha.va(var.loop.a3),  alpha.va(var.loop.a4), fx.dur - var.char.delay, fx.dur, fx.dur - var.char.delay - 301, fx.dur - var.char.delay - 300, text.alpha1, text.alpha3, text.alpha4)","delay = 450, d = 70*ratio, a1 = tag.only(j==1, '&HFF&', text.alpha1a), a3 = tag.only(j==1, '&HFF&', text.alpha3a), a4 = tag.only(j==1, '&HFF&', text.alpha4a)"); table.insert(leadout_fx_library, Helical_Char_Leadout_Inverse); table.insert(leadout_fx, "Helical Char Leadout Inverse")
	Helical_Char_Leadout_midLine = table.duplicate(PfxM_Box); table.inbox(Helical_Char_Leadout_midLine, "lead-out[fx]: Helical Char Leadout midLine","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid1(35)","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + var.char.d*(-1)^j + (2*var.char.d*(-1)^(j+1))*(char.i-1)/char.n","fx.dur - 1.5*var.char.delay, fx.dur","2","","char.text","format('\\\\fad(0,300)\\\\org(%s,%s)\\\\1va%s\\\\3va%s\\\\4va%s\\\\t(%s,%s,0.8,\\\\frx180)\\\\t(%s,%s,\\\\1va%s\\\\3va%s\\\\4va%s)',fx.pos_x, fx.pos_y, alpha.va(var.loop.a1),  alpha.va(var.loop.a3),  alpha.va(var.loop.a4), fx.dur - var.char.delay, fx.dur, fx.dur - var.char.delay - 301, fx.dur - var.char.delay - 300, text.alpha1, text.alpha3, text.alpha4)","delay = 450, d = 70*ratio, a1 = tag.only(j==1, '&HFF&', text.alpha1a), a3 = tag.only(j==1, '&HFF&', text.alpha3a), a4 = tag.only(j==1, '&HFF&', text.alpha4a)"); table.insert(leadout_fx_library, Helical_Char_Leadout_midLine); table.insert(leadout_fx, "Helical Char Leadout midLine")
	Move_Char_I = table.duplicate(PfxM_Box); table.inbox(Move_Char_I, "lead-out[fx]: Move Char I","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 30*(syl.i - syl.n + 1) + var.loop.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x - var.loop.dx","fx.pos_y, fx.pos_y - var.loop.dy","fx.dur - var.syl.delay, fx.dur","1","","char.text","'\\\\fad(0,200)'","delay = 450, dx = R(50, 100)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Move_Char_I); table.insert(leadout_fx, "Move Char I")
	Move_Char_II = table.duplicate(PfxM_Box); table.inbox(Move_Char_II, "lead-out[fx]: Move Char II","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time + 30*(syl.i - syl.n + 1) + var.loop.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x - var.loop.dx","fx.pos_y, fx.pos_y - var.loop.dy","fx.dur - var.syl.delay, fx.dur","1","","char.text","format('\\\\t(%s,%s,0.8,\\\\frx%s\\\\fry%s\\\\frz%s)\\\\fad(0,200)', fx.dur - var.syl.delay, fx.dur, R(-360,360), R(-360,360), R(-360,360))","delay = 450, dx = R(50, 100)*ratio, dy = R(-30, 30)*ratio"); table.insert(leadout_fx_library, Move_Char_II); table.insert(leadout_fx, "Move Char II")
	Move_Line_Bottom = table.duplicate(PfxM_Box); table.inbox(Move_Line_Bottom, "lead-out[fx]: Move Line Bottom","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + var.syl.d","fx.dur - var.syl.delay, fx.dur","1","","syl.text","format('\\\\t(%s,%s,\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3)', fx.dur - var.syl.delay, fx.dur - 3*var.syl.delay/4, color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'))","d = l.height, delay = 260"); table.insert(leadout_fx_library, Move_Line_Bottom); table.insert(leadout_fx, "Move Line Bottom")
	Move_Line_buttLine = table.duplicate(PfxM_Box); table.inbox(Move_Line_buttLine, "lead-out[fx]: Move Line buttLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.loop.delay + var.loop.delay2","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + l.width*(-1)^j","fx.pos_y, fx.pos_y","fx.dur - var.loop.delay, fx.dur","1, 2","","syl.text","tag.clip(l.left, l.top, l.width, l.height)","delay = 450, delay2 = 150"); table.insert(leadout_fx_library, Move_Line_buttLine); table.insert(leadout_fx, "Move Line buttLine")
	Move_Line_Left = table.duplicate(PfxM_Box); table.inbox(Move_Line_Left, "lead-out[fx]: Move Line Left","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x - var.syl.d","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","format('\\\\t(%s,%s,\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3)', fx.dur - var.syl.delay, fx.dur - 3*var.syl.delay/4, color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'))","d = 300*ratio, delay = 260"); table.insert(leadout_fx_library, Move_Line_Left); table.insert(leadout_fx, "Move Line Left")
	Move_Line_Left_Right = table.duplicate(PfxM_Box); table.inbox(Move_Line_Left_Right, "lead-out[fx]: Move Line Left Right","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.syl.d*(-1)^line.i","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","format('\\\\t(%s,%s,\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3)', fx.dur - var.syl.delay, fx.dur - 3*var.syl.delay/4, color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'))","d = 300*ratio, delay = 260"); table.insert(leadout_fx_library, Move_Line_Left_Right); table.insert(leadout_fx, "Move Line Left Right")
	Move_Line_Interlaced = table.duplicate(PfxM_Box); table.inbox(Move_Line_Interlaced, "lead-out[fx]: Move Line Interlaced","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.loop.delay + var.loop.delay2","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x - 0.5*l.width*(-1)^(j + 1)","fx.pos_y, fx.pos_y","fx.dur - var.loop.delay, fx.dur","1, 2","","syl.text","tag.clip(l.left, l.top, l.width, l.height)","delay = 450, delay2 = 150"); table.insert(leadout_fx_library, Move_Line_Interlaced); table.insert(leadout_fx, "Move Line Interlaced")
	Move_Line_midLine = table.duplicate(PfxM_Box); table.inbox(Move_Line_midLine, "lead-out[fx]: Move Line midLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.loop.delay + var.loop.delay2","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + 0.5*l.width*(-1)^(j + 1)","fx.pos_y, fx.pos_y","fx.dur - var.loop.delay, fx.dur","1, 2","","syl.text","tag.clip(l.left, l.top, l.width, l.height)","delay = 450, delay2 = 150"); table.insert(leadout_fx_library, Move_Line_midLine); table.insert(leadout_fx, "Move Line midLine")
	Move_Line_Right = table.duplicate(PfxM_Box); table.inbox(Move_Line_Right, "lead-out[fx]: Move Line Right","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.syl.d","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","format('\\\\t(%s,%s,\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3)', fx.dur - var.syl.delay, fx.dur - 3*var.syl.delay/4, color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'))","d = 300*ratio, delay = 260"); table.insert(leadout_fx_library, Move_Line_Right); table.insert(leadout_fx, "Move Line Right")
	Move_Line_Sequence_LBRT = table.duplicate(PfxM_Box); table.inbox(Move_Line_Sequence_LBRT, "lead-out[fx]: Move Line Sequence LBRT","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.syl.dx*var.syl.fX[(line.i - 1)%4 + 1]","fx.pos_y, fx.pos_y + var.syl.dy*var.syl.fY[(line.i - 1)%4 + 1]","fx.dur - var.syl.delay, fx.dur","1","","syl.text","format('\\\\t(%s,%s,\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3)', fx.dur - var.syl.delay, fx.dur - 3*var.syl.delay/4, color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'))","delay = 260, dx = 300*ratio, dy = l.height, fX = {-1, 0, 1, 0}, fY = {0, 1, 0, -1}"); table.insert(leadout_fx_library, Move_Line_Sequence_LBRT); table.insert(leadout_fx, "Move Line Sequence LBRT")
	Move_Line_Top = table.duplicate(PfxM_Box); table.inbox(Move_Line_Top, "lead-out[fx]: Move Line Top","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y - var.syl.d","fx.dur - var.syl.delay, fx.dur","1","","syl.text","format('\\\\t(%s,%s,\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3)', fx.dur - var.syl.delay, fx.dur - 3*var.syl.delay/4, color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'))","d = l.height, delay = 260"); table.insert(leadout_fx_library, Move_Line_Top); table.insert(leadout_fx, "Move Line Top")
	Move_Line_Top_Bottom = table.duplicate(PfxM_Box); table.inbox(Move_Line_Top_Bottom, "lead-out[fx]: Move Line Top Bottom","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + var.syl.d*(-1)^line.i","fx.dur - var.syl.delay, fx.dur","1","","syl.text","format('\\\\t(%s,%s,\\\\shad0\\\\bord2\\\\1vc%s\\\\3vc%s\\\\blur3)', fx.dur - var.syl.delay, fx.dur - 3*var.syl.delay/4, color.vc('&HFFFFFF&'), color.vc('&HFFFFFF&'))","d = l.height, delay = 260"); table.insert(leadout_fx_library, Move_Line_Top_Bottom); table.insert(leadout_fx, "Move Line Top Bottom")
	Move_Syl_From_Center_Line = table.duplicate(PfxM_Box); table.inbox(Move_Syl_From_Center_Line, "lead-out[fx]: Move Syl From Center Line","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.loop.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, l.center","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","'\\\\fad(0,300)'","delay = 460"); table.insert(leadout_fx_library, Move_Syl_From_Center_Line); table.insert(leadout_fx, "Move Syl From Center Line")
	Screw_Char = table.duplicate(PfxM_Box); table.inbox(Screw_Char, "lead-out[fx]: Screw Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + var.loop.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","fx.dur - var.char.delay, fx.dur","1","","char.text","format('\\\\t(%s,%s,0.8,\\\\frx180)\\\\fad(0,300)', fx.dur - var.char.delay, fx.dur)","delay = 440"); table.insert(leadout_fx_library, Screw_Char); table.insert(leadout_fx, "Screw Char")
	Screw_Char_buttLine = table.duplicate(PfxM_Box); table.inbox(Screw_Char_buttLine, "lead-out[fx]: Screw Char buttLine","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid2(40) + 40*char.n","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","fx.dur - var.char.delay, fx.dur","1","","char.text","format('\\\\t(%s,%s,0.8,\\\\frx180)\\\\fad(0,300)', fx.dur - var.char.delay, fx.dur)","delay = 440"); table.insert(leadout_fx_library, Screw_Char_buttLine); table.insert(leadout_fx, "Screw Char buttLine")
	Screw_Char_Inverse = table.duplicate(PfxM_Box); table.inbox(Screw_Char_Inverse, "lead-out[fx]: Screw Char Inverse","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","fx.dur - var.char.delay, fx.dur","1","","char.text","format('\\\\t(%s,%s,0.8,\\\\frx180)\\\\fad(0,300)', fx.dur - var.char.delay, fx.dur)","delay = 440"); table.insert(leadout_fx_library, Screw_Char_Inverse); table.insert(leadout_fx, "Screw Char Inverse")
	Screw_Char_midLine = table.duplicate(PfxM_Box); table.inbox(Screw_Char_midLine, "lead-out[fx]: Screw Char midLine","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid1(40)","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","fx.dur - var.char.delay, fx.dur","1","","char.text","format('\\\\t(%s,%s,0.8,\\\\frx180)\\\\fad(0,300)', fx.dur - var.char.delay, fx.dur)","delay = 440"); table.insert(leadout_fx_library, Screw_Char_midLine); table.insert(leadout_fx, "Screw Char midLine")
	Simple_Moves3_Char_I = table.duplicate(PfxM_Box); table.inbox(Simple_Moves3_Char_I, "lead-out[fx]: Simple Moves3 Char I","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + var.loop.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x - var.char.dx, fx.pos_x","fx.pos_y, fx.pos_y, fx.pos_y","fx.dur - var.char.delay, fx.dur","1","","char.text","'\\\\fad(0,300)'","dx = 70*ratio, delay = 460"); table.insert(leadout_fx_library, Simple_Moves3_Char_I); table.insert(leadout_fx, "Simple Moves3 Char I")
	Simple_Moves3_Char_II = table.duplicate(PfxM_Box); table.inbox(Simple_Moves3_Char_II, "lead-out[fx]: Simple Moves3 Char II","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + var.loop.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x - var.char.dx, fx.pos_x","fx.pos_y, fx.pos_y - syl.height*(1 - 2*module1), fx.pos_y","fx.dur - var.char.delay, fx.dur","1","","char.text","'\\\\fad(0,300)'","dx = 70*ratio, delay = 460"); table.insert(leadout_fx_library, Simple_Moves3_Char_II); table.insert(leadout_fx, "Simple Moves3 Char II")
	Snake_Move_Char_I = table.duplicate(PfxM_Box); table.inbox(Snake_Move_Char_I, "lead-out[fx]: Snake Move Char I","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + 4*var.loop.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x - var.char.dx","fx.pos_y, fx.pos_y","fx.dur - 4*var.char.delay, fx.dur","1","","char.text","tag.oscill({fx.dur - 4*var.char.delay, fx.dur}, var.syl.delay, '\\\\fsvp'..var.char.height, '\\\\fsvp'..-var.char.height), '\\\\fad(0,300)'","height = 7*ratio, delay = 180, dx = 40*ratio"); table.insert(leadout_fx_library, Snake_Move_Char_I); table.insert(leadout_fx, "Snake Move Char I")
	Snake_Move_Char_II = table.duplicate(PfxM_Box); table.inbox(Snake_Move_Char_II, "lead-out[fx]: Snake Move Char II","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + 5*var.loop.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x - var.char.dx","fx.pos_y, fx.pos_y","fx.dur - 4*var.char.delay, fx.dur","1","","char.text","tag.oscill({fx.dur - 4*var.char.delay, fx.dur}, var.char.delay, '\\\\fsvp'..var.char.height, '\\\\fsvp'..-var.char.height), format('\\\\fad(0,300)\\\\t(%s,%s,0.8,\\\\frx270)', fx.dur - 5*var.char.delay, fx.dur)","height = 20*ratio, delay = 180, dx = 40*ratio"); table.insert(leadout_fx_library, Snake_Move_Char_II); table.insert(leadout_fx, "Snake Move Char II")
	Spectrum_Move_Char = table.duplicate(PfxM_Box); table.inbox(Spectrum_Move_Char, "lead-out[fx]: Spectrum Move Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 25*(char.i - char.n + 1) + var.char.delay","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\org(%s,%s)\\\\t(%s,%s,0.7,\\\\frx%s\\\\frz%s)\\\\fad(0,300)', fx.pos_x, fx.pos_y - 20*ratio, fx.dur - 700 - 8*char.i, fx.dur, -140 - 2*char.i, -40 - char.i)","delay = 1200"); table.insert(leadout_fx_library, Spectrum_Move_Char); table.insert(leadout_fx, "Spectrum Move Char")
	Static_Clip_Ascend = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Ascend, "lead-out[fx]: Static Clip Ascend","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y - syl.height","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Ascend); table.insert(leadout_fx, "Static Clip Ascend")
	Static_Clip_Ascend_buttLine = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Ascend_buttLine, "lead-out[fx]: Static Clip Ascend buttLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid2(60) + 60*syl.n","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y - syl.height","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Ascend_buttLine); table.insert(leadout_fx, "Static Clip Ascend buttLine")
	Static_Clip_Ascend_Inverse = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Ascend_Inverse, "lead-out[fx]: Static Clip Ascend Inverse","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y - syl.height","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Ascend_Inverse); table.insert(leadout_fx, "Static Clip Ascend Inverse")
	Static_Clip_Ascend_midLine = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Ascend_midLine, "lead-out[fx]: Static Clip Ascend midLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid1(60)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y - syl.height","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Ascend_midLine); table.insert(leadout_fx, "Static Clip Ascend midLine")
	Static_Clip_Ascend_Descend_in_Line = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Ascend_Descend_in_Line, "lead-out[fx]: Static Clip Ascend Descend in Line","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + syl.height*(-1)^line.i","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Ascend_Descend_in_Line); table.insert(leadout_fx, "Static Clip Ascend Descend in Line")
	Static_Clip_Ascend_Descend_in_Syl = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Ascend_Descend_in_Syl, "lead-out[fx]: Static Clip Ascend Descend in Syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + syl.height*(-1)^syl.i","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Ascend_Descend_in_Syl); table.insert(leadout_fx, "Static Clip Ascend Descend in Syl")
	Static_Clip_Descend = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Descend, "lead-out[fx]: Static Clip Descend","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + syl.height","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Descend); table.insert(leadout_fx, "Static Clip Descend")
	Static_Clip_Descend_buttLine = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Descend_buttLine, "lead-out[fx]: Static Clip Descend buttLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid2(60) + 60*syl.n","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + syl.height","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.widtht, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Descend_buttLine); table.insert(leadout_fx, "Static Clip Descend buttLine")
	Static_Clip_Descend_Inverse = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Descend_Inverse, "lead-out[fx]: Static Clip Descend Inverse","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + syl.height","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Descend_Inverse); table.insert(leadout_fx, "Static Clip Descend Inverse")
	Static_Clip_Descend_midLine = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Descend_midLine, "lead-out[fx]: Static Clip Descend midLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid1(60)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + syl.height","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Descend_midLine); table.insert(leadout_fx, "Static Clip Descend midLine")
	Static_Clip_Left = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Left, "lead-out[fx]: Static Clip Left","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.loop.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x - syl.width","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Left); table.insert(leadout_fx, "Static Clip Left")
	Static_Clip_Left_buttLine = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Left_buttLine, "lead-out[fx]: Static Clip Left buttLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid2(60) + 60*syl.n","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x - syl.width","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Left_buttLine); table.insert(leadout_fx, "Static Clip Left buttLine")
	Static_Clip_Left_Inverse = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Left_Inverse, "lead-out[fx]: Static Clip Left Inverse","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x - syl.width","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Left_Inverse); table.insert(leadout_fx, "Static Clip Left Inverse")
	Static_Clip_Left_midLine = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Left_midLine, "lead-out[fx]: Static Clip Left midLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid1(60)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x - syl.width","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Left_midLine); table.insert(leadout_fx, "Static Clip Left midLine")
	Static_Clip_Left_Right_in_Line = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Left_Right_in_Line, "lead-out[fx]: Static Clip Left Right in Line","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.line.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + syl.width*(-1)^line.i","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Left_Right_in_Line); table.insert(leadout_fx, "Static Clip Left Right in Line")
	Static_Clip_Left_Right_in_Syl = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Left_Right_in_Syl, "lead-out[fx]: Static Clip Left Right in Syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.line.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + syl.width*(-1)^syl.i","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Left_Right_in_Syl); table.insert(leadout_fx, "Static Clip Left Right in Syl")
	Static_Clip_Right = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Right, "lead-out[fx]: Static Clip Right","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.loop.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + syl.width","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Right); table.insert(leadout_fx, "Static Clip Right")
	Static_Clip_Right_buttLine = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Right_buttLine, "lead-out[fx]: Static Clip Right buttLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid2(60) + 60*syl.n","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + syl.width","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Right_buttLine); table.insert(leadout_fx, "Static Clip Right buttLine")
	Static_Clip_Right_Inverse = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Right_Inverse, "lead-out[fx]: Static Clip Right Inverse","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.n - syl.i/2 + 2)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + syl.width","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Right_Inverse); table.insert(leadout_fx, "Static Clip Right Inverse")
	Static_Clip_Right_midLine = table.duplicate(PfxM_Box); table.inbox(Static_Clip_Right_midLine, "lead-out[fx]: Static Clip Right midLine","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + time_mid1(60)","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + syl.width","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","1","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_Right_midLine); table.insert(leadout_fx, "Static Clip Right midLine")
	Static_Clip_H_Multi = table.duplicate(PfxM_Box); table.inbox(Static_Clip_H_Multi, "lead-out[fx]: Static Clip H Multi","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.loop.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + syl.width*(-1)^j","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","5","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_H_Multi); table.insert(leadout_fx, "Static Clip H Multi")
	Static_Clip_H_Multi_II = table.duplicate(PfxM_Box); table.inbox(Static_Clip_H_Multi_II, "lead-out[fx]: Static Clip H Multi II","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.loop.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x + var.loop.w*(-1)^j","fx.pos_y, fx.pos_y","fx.dur - var.syl.delay, fx.dur","6","","syl.text","tag.clip(fx.pos_l - var.syl.w, fx.pos_t, syl.width + 2*var.syl.w, syl.height)","delay = 400, w = 50*ratio"); table.insert(leadout_fx_library, Static_Clip_H_Multi_II); table.insert(leadout_fx, "Static Clip H Multi II")
	Static_Clip_V_Multi = table.duplicate(PfxM_Box); table.inbox(Static_Clip_V_Multi, "lead-out[fx]: Static Clip V Multi","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + var.loop.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + syl.height*(-1)^j","fx.dur - var.syl.delay, fx.dur","1, ceil(syl.width/7)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_V_Multi); table.insert(leadout_fx, "Static Clip V Multi")
	Static_Clip_V_Multi_II = table.duplicate(PfxM_Box); table.inbox(Static_Clip_V_Multi_II, "lead-out[fx]: Static Clip V Multi II","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + var.loop.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y + syl.height*(-1)^j","fx.dur - var.syl.delay, fx.dur","1, ceil(syl.width/7)","","syl.text","tag.clip(fx.pos_l, fx.pos_t, syl.width, syl.height)","delay = 400"); table.insert(leadout_fx_library, Static_Clip_V_Multi_II); table.insert(leadout_fx, "Static Clip V Multi II")
	Stele_Move_Left = table.duplicate(PfxM_Box); table.inbox(Stele_Move_Left, "lead-out[fx]: Stele Move Left","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 6) + var.loop.delay*module/3","","","","","syl.center","syl.middle","","","5","0","fx.pos_x, fx.pos_x - var.loop.dx","fx.pos_y, fx.pos_y","fx.dur - var.loop.delay - 50*module, fx.dur","7","","syl.text","format('%s\\\\fad(0,300)\\\\t(%s,%s,0.8,\\\\1va%s\\\\3va%s\\\\4va%s)', tag.only(j ~= 1, format('\\\\1va%s\\\\3va%s\\\\4va%s', alpha.va('&HFF&'), alpha.va('&HFF&'), alpha.va('&HFF&'))), fx.dur - var.loop.delay - 51, fx.dur - var.loop.delay - 50, text.alpha1, text.alpha3, text.alpha4)","dx = 80*ratio, delay = 300"); table.insert(leadout_fx_library, Stele_Move_Left); table.insert(leadout_fx, "Stele Move Left")
	Template_char2end = table.duplicate(PfxM_Box); table.inbox(Template_char2end, "lead-out[fx]: Template char2end","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + char.end_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadout_fx_library, Template_char2end); table.insert(leadout_fx, "Template char2end")
	Template_Jitter_Char = table.duplicate(PfxM_Box); table.inbox(Template_Jitter_Char, "lead-out[fx]: Template Jitter Char","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.end_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\jitter(%s,%s,%s,%s,60,1000)', R(4)*(-1)^R(2), R(4)*(-1)^R(2), R(4)*(-1)^R(2), R(4)*(-1)^R(2))",""); table.insert(leadout_fx_library, Template_Jitter_Char); table.insert(leadout_fx, "Template Jitter Char")
	Template_Jitter_Line = table.duplicate(PfxM_Box); table.inbox(Template_Jitter_Line, "lead-out[fx]: Template Jitter Line","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\jitter(%s,%s,%s,%s,80,1000)', var.line.jt1, var.line.jt2, var.line.jt3, var.line.jt4)","jt1 = R(4)*(-1)^R(2), jt2 = R(4)*(-1)^R(2), jt3 = R(4)*(-1)^R(2), jt4 = R(4)*(-1)^R(2)"); table.insert(leadout_fx_library, Template_Jitter_Line); table.insert(leadout_fx, "Template Jitter Line")
	Template_Leadout_Char_Flag_Line = table.duplicate(PfxM_Box); table.inbox(Template_Leadout_Char_Flag_Line, "lead-out[fx]: Template Leadout Char Flag Line","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + 300","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","tag.oscill(fx.dur, 360, '\\\\fsvp2', '\\\\fsvp-2'), '\\\\fad(0,300)'",""); table.insert(leadout_fx_library, Template_Leadout_Char_Flag_Line); table.insert(leadout_fx, "Template Leadout Char Flag Line")
	Template_Leadout_Char = table.duplicate(PfxM_Box); table.inbox(Template_Leadout_Char, "lead-out[fx]: Template Leadout Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 30*(char.i - char.n + 1) + 300","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","'\\\\fad(0,300)'",""); table.insert(leadout_fx_library, Template_Leadout_Char); table.insert(leadout_fx, "Template Leadout Char")
	Template_Leadout_Syl = table.duplicate(PfxM_Box); table.inbox(Template_Leadout_Syl, "lead-out[fx]: Template Leadout Syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time + 50*(syl.i - syl.n + 1) + 300","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","'\\\\fad(0,300)'",""); table.insert(leadout_fx_library, Template_Leadout_Syl); table.insert(leadout_fx, "Template Leadout Syl")
	Template_postchar = table.duplicate(PfxM_Box); table.inbox(Template_postchar, "lead-out[fx]: Template postchar","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + char.end_time","l.start_time + char.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadout_fx_library, Template_postchar); table.insert(leadout_fx, "Template postchar")
	Template_postline_Char = table.duplicate(PfxM_Box); table.inbox(Template_postline_Char, "lead-out[fx]: Template postline Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.end_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadout_fx_library, Template_postline_Char); table.insert(leadout_fx, "Template postline Char")
	Template_postline_Syl = table.duplicate(PfxM_Box); table.inbox(Template_postline_Syl, "lead-out[fx]: Template postline Syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.end_time","l.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","",""); table.insert(leadout_fx_library, Template_postline_Syl); table.insert(leadout_fx, "Template postline Syl")
	Template_postsyl = table.duplicate(PfxM_Box); table.inbox(Template_postsyl, "lead-out[fx]: Template postsyl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","",""); table.insert(leadout_fx_library, Template_postsyl); table.insert(leadout_fx, "Template postsyl")
	Template_postsyl_Char = table.duplicate(PfxM_Box); table.inbox(Template_postsyl_Char, "lead-out[fx]: Template postsyl Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.start_time + syl.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadout_fx_library, Template_postsyl_Char); table.insert(leadout_fx, "Template postsyl Char")
	Template_syl2end = table.duplicate(PfxM_Box); table.inbox(Template_syl2end, "lead-out[fx]: Template syl2end","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","",""); table.insert(leadout_fx_library, Template_syl2end); table.insert(leadout_fx, "Template syl2end")
	Template_syl2end_Char = table.duplicate(PfxM_Box); table.inbox(Template_syl2end_Char, "lead-out[fx]: Template syl2end Char","Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","",""); table.insert(leadout_fx_library, Template_syl2end_Char); table.insert(leadout_fx, "Template syl2end Char")
	Template_Tremor_I = table.duplicate(PfxM_Box); table.inbox(Template_Tremor_I, "lead-out[fx]: Template Tremor I","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\rnd%s', var.syl.rndx), tag.oscill(fx.dur, R(20, 40)*10, '\\\\rnd'..2*var.syl.rndx,'\\\\rnd'..var.syl.rndx)","rndx = 7*ratio"); table.insert(leadout_fx_library, Template_Tremor_I); table.insert(leadout_fx, "Template Tremor I")
	Template_Tremor_II = table.duplicate(PfxM_Box); table.inbox(Template_Tremor_II, "lead-out[fx]: Template Tremor II","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\org(%s,%s)\\\\rnd%s', fx.pos_x, fx.pos_y - 10000*ratio, var.syl.rndx), tag.oscill(fx.dur, R(50, 80)*10, '\\\\rnd'..2*var.syl.rndx,'\\\\rnd'..var.syl.rndx)","rndx = ratio"); table.insert(leadout_fx_library, Template_Tremor_II); table.insert(leadout_fx, "Template Tremor II")
	Template_Tremor_III = table.duplicate(PfxM_Box); table.inbox(Template_Tremor_III, "lead-out[fx]: Template Tremor III","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.end_time","l.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","syl.text","format('\\\\org(%s,%s)\\\\rnd%s', fx.pos_x - 10000*ratio, fx.pos_y, var.syl.rndx), tag.oscill(fx.dur, R(30, 60)*10, '\\\\rnd'..2*var.syl.rndx,'\\\\rnd'..var.syl.rndx)","rndx = 0.4*ratio"); table.insert(leadout_fx_library, Template_Tremor_III); table.insert(leadout_fx, "Template Tremor III")

	--shape FX List
	Circle_Multi_Shape_Hilight = table.duplicate(Shape_Box); table.inbox(Circle_Multi_Shape_Hilight, "shape[fx]: Circle Multi Shape Hilight","Syl",true,false,"#FFFFFF","#3AA6FD","#000000","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 300","cos(s)","sin(s)","0","2*pi","syl.center","syl.middle + l.descent/4","math.distance(0,0, syl.width, syl.height)/2.2","math.distance(0,0, syl.width, syl.height)/2.2","5","0","fx.pos_x, fx.pos_x + R(-10,10)","fx.pos_y, fx.pos_y + R(-10,10)","100, fx.dur","math.distance(0, 0, syl.width, syl.height)","8*ratio","shape.shine2t","'\\\\bord0.5\\\\blur4\\\\fad(0,200)', tag.glitter(fx.dur, '\\\\3vc'..color.vc('&HFFFFFF&'), '\\\\3vc'..shape.color3)",""); table.insert(shape_fx_library, Circle_Multi_Shape_Hilight); table.insert(shape_fx, "Circle Multi Shape Hilight")
	Circle_Zoom = table.duplicate(Shape_Box); table.inbox(Circle_Zoom, "shape[fx]: Circle Zoom","Syl",true,false,"#FFFFFF","#5398FA","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle + l.descent/4","","","5","2","fx.pos_x, fx.pos_x + var.syl.dx","fx.pos_y, fx.pos_y","fx.dur - 50, fx.dur","1","math.round((syl.width^2 + l.height^2)^0.5)*1.2","var.syl.Shape","format('\\\\bord1.5\\\\blur3\\\\shad0\\\\fr%s\\\\t(\\\\fr%s)', -0.56*syl.start_time, -0.56*syl.end_time), tag.oscill(fx.dur, 80, '\\\\bord3\\\\3vc'..color.vc('&HFFFFFF&'), '\\\\bord1.5\\\\3vc'..color.vc('&HFA9853&'))","dx= (syl.i ~= syl.n) and line.left + line.kara[syl.i+1].center - line.kara[syl.i].center or 0, Shape = 'm 50 0 b 22 0 0 22 0 50 b 0 78 22 100 50 100 b 78 100 100 78 100 50 b 100 22 78 0 50 0 m 97 50 b 97 76 76 97 50 97 b 24 97 3 76 3 50 b 3 25 24 3 50 3 l 50 8 b 65 8 80 17 87 31 l 91 28 b 94 32 97 38 97 50 m 9 87 l 11 89 l 20 80 l 18 78 l 9 87 '"); table.insert(shape_fx_library, Circle_Zoom); table.insert(shape_fx, "Circle Zoom")
	Circle_Zoom_Intro = table.duplicate(Shape_Box); table.inbox(Circle_Zoom_Intro, "shape[fx]: Circle Zoom Intro","Syl",true,false,"#FFFFFF","#5398FA","#FFFFFF","0","0","0","l.start_time + syl.start_time - 400","l.start_time + syl.start_time","","","","","syl.center","syl.middle + l.descent/4","","","5","2","fx.pos_x - 120, fx.pos_x","fx.pos_y, fx.pos_y","","1","math.round((syl.width^2 + l.height^2)^0.5)*0.6","(syl.i == 1) and var.syl.Shape or nil","format('\\\\bord1.5\\\\blur3\\\\shad0\\\\fad(100,0)\\\\fr360\\\\t(\\\\fr0\\\\fscx%s\\\\fscy%s)', math.round((syl.width^2 + l.height^2)^0.5)*1.2, math.round((syl.width^2 + l.height^2)^0.5)*1.2), tag.oscill(fx.dur, 80, '\\\\bord3\\\\3vc'..color.vc('&HFFFFFF&'), '\\\\bord1.5\\\\3vc'..color.vc('&HFA9853&'))","Shape = 'm 50 0 b 22 0 0 22 0 50 b 0 78 22 100 50 100 b 78 100 100 78 100 50 b 100 22 78 0 50 0 m 97 50 b 97 76 76 97 50 97 b 24 97 3 76 3 50 b 3 25 24 3 50 3 l 50 8 b 65 8 80 17 87 31 l 91 28 b 94 32 97 38 97 50 m 9 87 l 11 89 l 20 80 l 18 78 l 9 87 '"); table.insert(shape_fx_library, Circle_Zoom_Intro); table.insert(shape_fx, "Circle Zoom Intro")
	Circle_Zoom_Outro = table.duplicate(Shape_Box); table.inbox(Circle_Zoom_Outro, "shape[fx]: Circle Zoom Outro","Syl",true,false,"#FFFFFF","#5398FA","#FFFFFF","0","0","0","l.start_time + syl.end_time","l.start_time + syl.end_time + 400","","","","","syl.center","syl.middle + l.descent/4","","","5","2","fx.pos_x, fx.pos_x + 120","fx.pos_y, fx.pos_y","","1","math.round((syl.width^2 + l.height^2)^0.5)*1.2","(syl.i == syl.n) and var.syl.Shape or nil","format('\\\\bord1.5\\\\blur3\\\\shad0\\\\fad(0,100)\\\\fr%s\\\\t(\\\\fr%s\\\\fscx%s\\\\fscy%s)', -0.56*syl.end_time, -0.56*syl.end_time-360, math.round((syl.width^2 + l.height^2)^0.5)*0.6, math.round((syl.width^2 + l.height^2)^0.5)*0.6), tag.oscill(fx.dur, 80, '\\\\bord3\\\\3vc'..color.vc('&HFFFFFF&'), '\\\\bord1.5\\\\3vc'..color.vc('&HFA9853&'))","Shape = 'm 50 0 b 22 0 0 22 0 50 b 0 78 22 100 50 100 b 78 100 100 78 100 50 b 100 22 78 0 50 0 m 97 50 b 97 76 76 97 50 97 b 24 97 3 76 3 50 b 3 25 24 3 50 3 l 50 8 b 65 8 80 17 87 31 l 91 28 b 94 32 97 38 97 50 m 9 87 l 11 89 l 20 80 l 18 78 l 9 87 '"); table.insert(shape_fx_library, Circle_Zoom_Outro); table.insert(shape_fx, "Circle Zoom Outro")
	Cristal_Syl_postline = table.duplicate(Shape_Box); table.inbox(Cristal_Syl_postline, "shape[fx]: Cristal Syl postline","Syl",true,false,"#6D95FF","#3F3C3C","#FFFFFF","20","40","0","l.end_time + 50*(syl.i - syl.n + 1) + R(-100,0)","l.end_time + 50*(syl.i - syl.n + 1) + R(800,2200)","","","","","syl.center","syl.middle","","","5","R(0, 2)","fx.pos_x + var.loop.dx1, fx.pos_x + var.loop.dx2","fx.pos_y + var.loop.dy1, fx.pos_y + var.loop.dy2","","R(4, 8)","R(8, 15)*ratio","'m 0 0 l 0 100 l 60 25 '","format('\\\\bord0\\\\shad0\\\\blur1\\\\t(0.2,\\\\frx%s\\\\fry%s\\\\frz%s)\\\\fad(0,300)', R(-4600, 4600), R(-6000, 6000), R(-4600, 4600)), tag.glitter(fx.dur, '\\\\1vc'..color.vc('&HFFFFFF&'), '\\\\1vc'..text.color1)","dx1 = R(-syl.width/2, syl.width/2), dx2 = R(60, 500)*ratio, dy1 = R(-0.36*syl.height, 0.4*syl.height), dy2 = R(-120, -20)*ratio"); table.insert(shape_fx_library, Cristal_Syl_postline); table.insert(shape_fx, "Cristal Syl postline")
	Energy_Power = table.duplicate(Shape_Box); table.inbox(Energy_Power, "shape[fx]: Energy Power","Line",true,false,"#4CF300","#E1DEDE","#FFFFFF","0","0","0","l.start_time","l.end_time","","","","","line.center","line.middle","","","4","j - 1","fx.pos_x - line.width/2","fx.pos_b + fx.sizey","","2","0, 0.2*syl.height","shape.rectangle","tag.only((j == 1), format('\\\\bord1\\\\shad0\\\\1va%s\\\\fscx%s', alpha.va('&HFF&'), l.width), format('\\\\bord0\\\\shad0\\\\t(\\\\1vc(%s,&H0000FF&,%s,&H0000FF&)%s)', shape.color1c, shape.color1c, var.syl.energy()))","energy = function() Tag = '' for i = 1, #line.kara do Tag = Tag..format('\\\\t(%s,%s,\\\\fscx%s)', line.kara[i].start_time, line.kara[i].end_time, ((i == 1) and line.kara[i].right - l.left or line.kara[i].right)) end return Tag end"); table.insert(shape_fx_library, Energy_Power); table.insert(shape_fx, "Energy Power")
	Equalizer_Sound_I = table.duplicate(Shape_Box); table.inbox(Equalizer_Sound_I, "shape[fx]: Equalizer Sound I","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time + (syl.dur + var.loop.delay)*(j - 1)/maxj","l.start_time + syl.start_time + (syl.dur + var.loop.delay)*j/maxj","","","","","syl.center","syl.middle","","","2","0","fx.pos_x","fx.pos_b - l.descent","","ceil(syl.duration/100)","0.9*syl.width, 0","shape.rectangle","format('\\\\bord0\\\\1vc%s\\\\t(\\\\fscy%s)\\\\fad(0,%s)', color.vc(random.color()), R(60, 120)*ratio, var.loop.delay/2)","delay = 300"); table.insert(shape_fx_library, Equalizer_Sound_I); table.insert(shape_fx, "Equalizer Sound I")
	Equalizer_Sound_II = table.duplicate(Shape_Box); table.inbox(Equalizer_Sound_II, "shape[fx]: Equalizer Sound II","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time + (syl.dur + var.loop.delay)*(j - 1)/maxj","l.start_time + syl.start_time + (syl.dur + var.loop.delay)*j/maxj","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","ceil(syl.dur/100)","0.9*syl.width, 0","shape.rectangle","format('\\\\bord0\\\\1vc%s\\\\t(\\\\fscy%s)\\\\fad(0,%s)', color.vc(random.color()), R(80,150)*ratio, var.loop.delay/2)","delay = 300"); table.insert(shape_fx_library, Equalizer_Sound_II); table.insert(shape_fx, "Equalizer Sound II")
	Equalizer_Sound_III = table.duplicate(Shape_Box); table.inbox(Equalizer_Sound_III, "shape[fx]: Equalizer Sound III","Char",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time","l.end_time","","","","","char.center","char.middle","","","2","0","fx.pos_x","fx.pos_b - l.descent","","1","0.95*char.width, 0","shape.rectangle","format('\\\\bord0\\\\shad0\\\\1vc%s\\\\1va%s\\\\fad(0,%s)', color.gradienth(color.vc(var.line.colors[1]), color.vc(var.line.colors[2])), alpha.gradientv('&HAA&', text.alpha1a), var.syl.delay/2), var.syl.sound(40, 120)","delay = 300, colors = {random.color({0,180}), random.color({180,360})}, sound = function(min_y, max_y) Tag = '' i = 1 while i <= #line.kara do Tag = Tag..format('\\\\t(%s,%s,\\\\fscy%s)\\\\t(%d,%d,\\\\fscy%s)', line.kara[i].start_time, line.kara[i].start_time + 1, R(min_y, max_y)*ratio, line.kara[i].start_time +1, line.kara[i].end_time, R(min_y)*ratio) i = i +1 end return Tag end"); table.insert(shape_fx_library, Equalizer_Sound_III); table.insert(shape_fx, "Equalizer Sound III")
	Equalizer_Sound_Horizontal_Left = table.duplicate(Shape_Box); table.inbox(Equalizer_Sound_Horizontal_Left, "shape[fx]: Equalizer Sound Horizontal Left","Line",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time","l.end_time","","","","","line.center","line.middle","","","6","0","fx.pos_x - l.width/2","fx.pos_t + fx.sizey*(j + 0.5)","","10","0, l.height/maxj","shape.rectangle","format('\\\\bord0\\\\shad0\\\\1vc%s\\\\1va(&HAA&,%s,&HAA&,%s)\\\\fad(0,%s)', color.vc(var.line.colors), text.alpha1a, text.alpha1a, var.syl.delay/2), var.syl.soundX(40, 120)","delay = 300, colors = random.color(), soundX = function(min_y, max_y) Tag = '' i = 1 while i <= #line.kara do Tag = Tag..format('\\\\t(%s,%s,\\\\fscx%s)\\\\t(%d,%d,\\\\fscx%s)', line.kara[i].start_time, line.kara[i].start_time + 1, R(min_y, max_y)*ratio, line.kara[i].start_time +1, line.kara[i].end_time, R(min_y)*ratio) i = i +1 end return Tag end"); table.insert(shape_fx_library, Equalizer_Sound_Horizontal_Left); table.insert(shape_fx, "Equalizer Sound Horizontal Left")
	Equalizer_Sound_Horizontal_Left_Right = table.duplicate(Shape_Box); table.inbox(Equalizer_Sound_Horizontal_Left_Right, "shape[fx]: Equalizer Sound Horizontal Left Right","Line",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time","l.end_time","","","","","line.center","line.middle","","","5 + (-1)^j","0","fx.pos_x - (line.width/2 + 12*ratio)*(-1)^j","fx.pos_t + fx.sizey/2 + (ceil(j/2) - 1)*fx.sizey","","24","0, 2*syl.height/maxj","shape.rectangle","format('\\\\bord0\\\\shad0\\\\1vc%s\\\\fad(0,%s)', color.vc(var.line.colors), var.syl.delay/2), tag.only((j%2 == 0), format('\\\\1va(&HAA&,%s,&HAA&,%s)', text.alpha1a, text.alpha1a), format('\\\\1va(%s,&HAA&,%s,&HAA&)', text.alpha1a, text.alpha1a)), var.syl.soundX(40, 120)","delay = 300, colors = random.color(), soundX = function(min_y, max_y) Tag = '' i = 1 while i <= #line.kara do Tag = Tag..format('\\\\t(%s,%s,\\\\fscx%s)\\\\t(%d,%d,\\\\fscx%s)', line.kara[i].start_time, line.kara[i].start_time + 1, R(min_y, max_y)*ratio, line.kara[i].start_time +1, line.kara[i].end_time, R(min_y)*ratio) i = i +1 end return Tag end"); table.insert(shape_fx_library, Equalizer_Sound_Horizontal_Left_Right); table.insert(shape_fx, "Equalizer Sound Horizontal Left Right")
	Equalizer_Sound_Horizontal_Right = table.duplicate(Shape_Box); table.inbox(Equalizer_Sound_Horizontal_Right, "shape[fx]: Equalizer Sound Horizontal Right","Line",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time","l.end_time","","","","","line.center","line.middle","","","4","0","fx.pos_x + l.width/2","fx.pos_t + fx.sizey*(j + 0.5)","","10","0, l.height/maxj","shape.rectangle","format('\\\\bord0\\\\shad0\\\\1vc%s\\\\1va(%s,&HAA&,%s,&HAA&)\\\\fad(0,%s)', color.vc(var.line.colors), text.alpha1a, text.alpha1a, var.syl.delay/2), var.syl.soundX(40, 120)","delay = 300, colors = random.color(), soundX = function(min_y, max_y) Tag = '' i = 1 while i <= #line.kara do Tag = Tag..format('\\\\t(%s,%s,\\\\fscx%s)\\\\t(%d,%d,\\\\fscx%s)', line.kara[i].start_time, line.kara[i].start_time + 1, R(min_y, max_y)*ratio, line.kara[i].start_time +1, line.kara[i].end_time, R(min_y)*ratio) i = i +1 end return Tag end"); table.insert(shape_fx_library, Equalizer_Sound_Horizontal_Right); table.insert(shape_fx, "Equalizer Sound Horizontal Right")
	Jump_Clasic_Shape_preHilight_I = table.duplicate(Shape_Box); table.inbox(Jump_Clasic_Shape_preHilight_I, "shape[fx]: Jump Clasic Shape preHilight I","Syl",false,false,"#FFFFFF","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time + ((syl.i == 1) and -500 or -line.kara[syl.i-1].duration)","l.start_time + syl.start_time","","","","","syl.center","syl.middle - 1.25*l.descent","","","5","1","fx.pos_x - var.syl.dx, fx.pos_x - var.syl.dx, fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y - 0.75*var.syl.dx, fx.pos_y - 0.75*var.syl.dx, fx.pos_y","","1","20","shape.star","format('\\\\3vc%s\\\\bord0.8\\\\shad0\\\\blur3\\\\t(\\\\fr-72)', color.vc(var.line.hue)), tag.only((syl.i == 1), '\\\\fad(150,0)', '')","hue = random.color(), dx = (syl.i == 1) and syl.height or line.kara[syl.i].center - line.kara[syl.i-1].center"); table.insert(shape_fx_library, Jump_Clasic_Shape_preHilight_I); table.insert(shape_fx, "Jump Clasic Shape preHilight I")
	Jump_Clasic_Shape_preHilight_II = table.duplicate(Shape_Box); table.inbox(Jump_Clasic_Shape_preHilight_II, "shape[fx]: Jump Clasic Shape preHilight II","Syl",false,false,"#FFFFFF","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time + ((syl.i == 1) and -500 or -line.kara[syl.i-1].duration)","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x - var.syl.dx, fx.pos_x - var.syl.dx, fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y - 0.75*var.syl.dx*(-1)^(syl.i + line.i), fx.pos_y - 0.75*var.syl.dx*(-1)^(syl.i + line.i), fx.pos_y","","1","25","shape.star","format('\\\\3vc%s\\\\bord2\\\\shad0\\\\blur4\\\\t(\\\\frx180)', color.vc(var.line.hue)), tag.only((syl.i == 1), '\\\\fad(150,0)', '')","hue = random.color(), dx = (syl.i == 1) and syl.height or line.kara[syl.i].center - line.kara[syl.i-1].center"); table.insert(shape_fx_library, Jump_Clasic_Shape_preHilight_II); table.insert(shape_fx, "Jump Clasic Shape preHilight II")
	Jump_Clasic_Shape_preHilight_II_Double = table.duplicate(Shape_Box); table.inbox(Jump_Clasic_Shape_preHilight_II_Double, "shape[fx]: Jump Clasic Shape preHilight II Double","Syl",false,false,"#FFFFFF","#3F3C3C","#FFFFFF","20","40","0","l.start_time + syl.start_time + ((syl.i == 1) and -500 or -line.kara[syl.i-1].duration)","l.start_time + syl.start_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x - var.syl.dx, fx.pos_x - var.syl.dx, fx.pos_x, fx.pos_x","fx.pos_y, fx.pos_y - var.syl.dx*(-1)^(syl.i + j), fx.pos_y - var.syl.dx*(-1)^(syl.i + j), fx.pos_y","","2","25","shape.star","format('\\\\3vc%s\\\\bord2\\\\shad0\\\\blur4\\\\t(\\\\frx180)', color.vc(var.line.hue)), tag.only((syl.i == 1), '\\\\fad(150,0)', '')","hue = random.color(), dx = (syl.i == 1) and syl.height or line.kara[syl.i].center - line.kara[syl.i-1].center"); table.insert(shape_fx_library, Jump_Clasic_Shape_preHilight_II_Double); table.insert(shape_fx, "Jump Clasic Shape preHilight II Double")
	Motor_Gear = table.duplicate(Shape_Box); table.inbox(Motor_Gear, "shape[fx]: Motor Gear","Syl",false,false,"#CEB618","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_l - var.line.Size/2, fx.pos_l - var.line.Size/2 + syl.widtht","fx.pos_y, fx.pos_y","","1","","shape.size(shape.gear, var.line.Size)","format('\\\\bord0\\\\fr%s\\\\t(\\\\fr%s)', -0.32*syl.start_time, -0.32*syl.end_time)","Size = 80*ratio"); table.insert(shape_fx_library, Motor_Gear); table.insert(shape_fx, "Motor Gear")
	Motor_Gear_Intro = table.duplicate(Shape_Box); table.inbox(Motor_Gear_Intro, "shape[fx]: Motor Gear Intro","Syl",false,false,"#CEB618","#3F3C3C","#FFFFFF","0","0","0","l.start_time - 400","l.start_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_l - var.line.Size/2 - 120*ratio, fx.pos_l - var.line.Size/2","fx.pos_y, fx.pos_y","","1","","(syl.i == 1) and shape.size(shape.gear, var.line.Size) or nil","format('\\\\fad(200,0)\\\\bord0\\\\fr%s\\\\t(\\\\fr0)', 0.32*fx.dur)","Size = 80*ratio"); table.insert(shape_fx_library, Motor_Gear_Intro); table.insert(shape_fx, "Motor Gear Intro")
	Motor_Gear_Outro = table.duplicate(Shape_Box); table.inbox(Motor_Gear_Outro, "shape[fx]: Motor Gear Outro","Syl",false,false,"#CEB618","#3F3C3C","#FFFFFF","0","0","0","l.end_time","l.end_time + 400","","","","","syl.center","syl.middle","","","5","1","fx.pos_l - var.line.Size/2 + syl.widtht, fx.pos_l - var.line.Size/2 + syl.widtht + 120*ratio","fx.pos_y, fx.pos_y","","1","","(syl.i == syl.n) and shape.size(shape.gear, var.line.Size) or nil","format('\\\\fad(0,200)\\\\bord0\\\\fr%s\\\\t(\\\\fr%s)', -0.32*syl.end_time, 0.32*(syl.end_time + syl.dur))","Size = 80*ratio"); table.insert(shape_fx_library, Motor_Gear_Outro); table.insert(shape_fx, "Motor Gear Outro")
	Parametric_Curve_I = table.duplicate(Shape_Box); table.inbox(Parametric_Curve_I, "shape[fx]: Parametric Curve I","Syl",true,false,"#67D7FE","#8702AC","#000000","25","35","60","l.start_time + syl.start_time - 800*module^var.syl.accel","fx.start_time + 300","(cos(3*s))*var.syl.sign_x","(sin(2*s) + cos(s))*var.syl.sign_y","pi/2","-pi/2","syl.center","syl.middle","R(30, 50)*ratio","R(20, 40)*ratio","5","2","fx.pos_x","fx.pos_y","","140","4*ratio","shape.circle","format('\\\\fad(20,200)\\\\bord0\\\\shad0\\\\blur1\\\\org(%s,%s)\\\\fr%s\\\\1vc%s', fx.center_x, fx.center_y, var.syl.angle, color.module(var.syl.color1, var.syl.color2))","angle = R(36)*10, sign_x = (-1)^R(2), sign_y = (-1)^R(4), accel = R(160, 260)/100, color1 = random.color(), color2 = random.color()"); table.insert(shape_fx_library, Parametric_Curve_I); table.insert(shape_fx, "Parametric Curve I")
	Parametric_Curve_Leadin_Line_I = table.duplicate(Shape_Box); table.inbox(Parametric_Curve_Leadin_Line_I, "shape[fx]: Parametric Curve Leadin Line I","Line",true,false,"#FFFFFF","#3F3C3C","#FFFFFF","0","0","0","l.start_time - 50*syl.n*(1 - module)","l.start_time - 50*syl.n*(1 - module) + var.loop.delay*module + 800","cos(s/2) - s^0.6 + sin(s/3) - 1","var.line.sign*sin(3*s/4)/2","16","0","l.right + 50*ratio","syl.middle","l.right/7","syl.height","5","1","fx.pos_x, fx.pos_x + R(-50, 20)*ratio","fx.pos_y, fx.pos_y + R(-20, 20)*ratio","","R(150, 200)","R(7,12)*ratio","shape.shine2t","format('\\\\bord0.5\\\\3vc%s\\\\blur4\\\\t(\\\\fr%s)\\\\fad(50,300)', color.module, var.syl.colors[1], var.syl.colors[2]), R(-180, 180)), tag.glitter()","delay = 600, colors = {random.color(), random.color()}, sign = (-1)^R(2)"); table.insert(shape_fx_library, Parametric_Curve_Leadin_Line_I); table.insert(shape_fx, "Parametric Curve Leadin Line I")
	Parametric_Curve_Leadin_Line_II = table.duplicate(Shape_Box); table.inbox(Parametric_Curve_Leadin_Line_II, "shape[fx]: Parametric Curve Leadin Line II","Line",true,false,"#FFFFFF","#3F3C3C","#FFFFFF","0","0","0","l.start_time - 50*syl.n*(1 - module^1.5) + 1000","fx.start_time + var.loop.delay*module + 1200","cos(8*s + 3) + s^2 + 1","-sin(2*s)*cos(5*s)","0","2.84","50*ratio","syl.middle","l.right/10","syl.height","5","1","fx.pos_x, fx.pos_x + R(-50, 20)*ratio","fx.pos_y, fx.pos_y + R(-20, 20)*ratio","","R(180,220)","R(6,12)*ratio","shape.shine2t","format('\\\\bord0.5\\\\3vc%s\\\\blur4\\\\t(\\\\fr%s)\\\\fad(50,400)', color.module(var.syl.colors[1], var.syl.colors[2]), R(-180, 180)), tag.glitter()","delay = 1200, colors = {random.color(), random.color()}, sign = (-1)^R(2)"); table.insert(shape_fx_library, Parametric_Curve_Leadin_Line_II); table.insert(shape_fx, "Parametric Curve Leadin Line II")
	Parametric_Silkworm_preHilight_I = table.duplicate(Shape_Box); table.inbox(Parametric_Silkworm_preHilight_I, "shape[fx]: Parametric Silkworm preHilight I","Syl",false,false,"#FFFFFF","#FDB901","#FFFFFF","0","0","0","l.start_time + syl.start_time + ((syl.i == 1) and -500 or -line.kara[syl.i-1].duration)*(1 - module)","fx.start_time + var.syl.delay","cos(s)/2 - 1/2","-sin(s)/2","pi","0","syl.center","syl.middle - l.descent","(syl.i == 1) and syl.height or line.kara[syl.i].center-line.kara[syl.i-1].center","1.2*((syl.i == 1) and syl.height or line.kara[syl.i].center-line.kara[syl.i-1].center)","5","1","fx.pos_x","fx.pos_y","","0.8*var.syl.loops","4*ratio","shape.circle","format('\\\\3vc%s\\\\bord0.4\\\\shad0\\\\blur3\\\\fad(50,300)', color.module1(var.line.colors[1], var.line.colors[2]))","delay = 600, colors = {random.color(), random.color()}, loops = (syl.i == 1) and syl.height or line.kara[syl.i].center - line.kara[syl.i-1].center"); table.insert(shape_fx_library, Parametric_Silkworm_preHilight_I); table.insert(shape_fx, "Parametric Silkworm preHilight I")
	Parametric_Silkworm_preHilight_II = table.duplicate(Shape_Box); table.inbox(Parametric_Silkworm_preHilight_II, "shape[fx]: Parametric Silkworm preHilight II","Syl",false,false,"#FFFFFF","#FDB901","#FFFFFF","0","0","0","l.start_time + syl.start_time + ((syl.i == 1) and -500 or -line.kara[syl.i-1].duration)*(1 - module)","fx.start_time + var.syl.delay","cos(s)/2 - 1/2","-sin(s)/2","pi","0","syl.center","syl.middle - l.descent","(syl.i == 1) and syl.height or line.kara[syl.i].center-line.kara[syl.i-1].center","1.2*((syl.i == 1) and syl.height or line.kara[syl.i].center-line.kara[syl.i-1].center)","5","1","fx.pos_x, fx.pos_x + R(-15, 15)*ratio","fx.pos_y, fx.pos_y + R(-10, 10)*ratio","fx.dur/6, fx.dur","0.6*var.syl.loops","18*ratio","shape.shine1t","format('\\\\3vc%s\\\\bord0.4\\\\shad0\\\\blur3\\\\fr%s\\\\t(\\\\fr%s)\\\\fad(50,300)', color.module1(var.line.colors[1], var.line.colors[2]), R(-180, 180), R(-180, 180))","delay = 600, colors = {random.color(), random.color()}, loops = (syl.i == 1) and syl.height or line.kara[syl.i].center - line.kara[syl.i-1].center"); table.insert(shape_fx_library, Parametric_Silkworm_preHilight_II); table.insert(shape_fx, "Parametric Silkworm preHilight II")
	Parametric_Silkworm_preHilight_II_Alternated = table.duplicate(Shape_Box); table.inbox(Parametric_Silkworm_preHilight_II_Alternated, "shape[fx]: Parametric Silkworm preHilight II Alternated","Syl",false,false,"#FFFFFF","#FDB901","#FFFFFF","0","0","0","l.start_time + syl.start_time + ((syl.i == 1) and -500 or -line.kara[syl.i-1].duration)*(1 - module)","fx.start_time + var.syl.delay","cos(s)/2 - 1/2","((-1)^syl.i)*sin(s)/2","pi","0","syl.center","syl.middle","(syl.i == 1) and syl.height or line.kara[syl.i].center-line.kara[syl.i-1].center","1.2*((syl.i == 1) and syl.height or line.kara[syl.i].center-line.kara[syl.i-1].center)","5","1","fx.pos_x, fx.pos_x + R(-15, 15)*ratio","fx.pos_y, fx.pos_y + R(-10, 10)*ratio","fx.dur/6, fx.dur","0.6*var.syl.loops","18*ratio","shape.shine1t","format('\\\\3vc%s\\\\bord0.4\\\\shad0\\\\blur3\\\\fr%s\\\\t(\\\\fr%s)\\\\fad(50,300)', color.module1(var.line.colors[1], var.line.colors[2]), R(-180, 180), R(-180, 180))","delay = 600, colors = {random.color(), random.color()}, loops = (syl.i == 1) and syl.height or line.kara[syl.i].center - line.kara[syl.i-1].center"); table.insert(shape_fx_library, Parametric_Silkworm_preHilight_II_Alternated); table.insert(shape_fx, "Parametric Silkworm preHilight II Alternated")
	Parametric_Silkworm_preHilight_II_Double = table.duplicate(Shape_Box); table.inbox(Parametric_Silkworm_preHilight_II_Double, "shape[fx]: Parametric Silkworm preHilight II Double","Syl",false,false,"#FFFFFF","#FDB901","#FFFFFF","0","0","0","l.start_time + syl.start_time + ((syl.i == 1) and -500 or -line.kara[syl.i-1].duration)*(1 - module)","fx.start_time + var.syl.delay","cos(s)/2 - 1/2","((-1)^j)*sin(s)/2","pi","0","syl.center","syl.middle +  l.descent*(-1)^j","(syl.i == 1) and syl.height or line.kara[syl.i].center-line.kara[syl.i-1].center","1.2*((syl.i == 1) and syl.height or line.kara[syl.i].center-line.kara[syl.i-1].center)","5","1","fx.pos_x, fx.pos_x + R(-15, 15)*ratio","fx.pos_y, fx.pos_y + R(-10, 10)*ratio","fx.dur/6, fx.dur","var.syl.loops","18*ratio","shape.shine1t","format('\\\\3vc%s\\\\bord0.4\\\\shad0\\\\blur3\\\\fr%s\\\\t(\\\\fr%s)\\\\fad(50,300)', color.module1(var.line.colors[1], var.line.colors[2]), R(-180, 180), R(-180, 180))","delay = 600, colors = {random.color(), random.color()}, loops = (syl.i == 1) and syl.height or line.kara[syl.i].center - line.kara[syl.i-1].center"); table.insert(shape_fx_library, Parametric_Silkworm_preHilight_II_Double); table.insert(shape_fx, "Parametric Silkworm preHilight II Double")
	Power_Ball = table.duplicate(Shape_Box); table.inbox(Power_Ball, "shape[fx]: Power Ball","Syl",false,false,"#3661AD","#3F3C3C","#FFFFFF","80","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.left","syl.middle","","","5","1","fx.pos_x - shape.config(var.syl.S, 'width')/2, fx.pos_x - shape.config(var.syl.S, 'width')/2 + syl.width + syl.postspacewidth","fx.pos_y, fx.pos_y","","12","(1 - 0.8*module)*l.scale_x","var.syl.S","format('\\\\bord0\\\\shad0\\\\blur2\\\\1vc%s', color.module(shape.color1c, '&HFFFFFF&'))","S = shape.size(shape.circle, 80*ratio)"); table.insert(shape_fx_library, Power_Ball); table.insert(shape_fx, "Power Ball")
	Power_Ball_Intro = table.duplicate(Shape_Box); table.inbox(Power_Ball_Intro, "shape[fx]: Power Ball Intro","Syl",false,false,"#3661AD","#3F3C3C","#FFFFFF","80","0","0","l.start_time + syl.start_time - 400","l.start_time + syl.start_time","","","","","syl.left","syl.middle","","","5","1","fx.pos_x - 1.5*shape.config(var.syl.S, 'width'), fx.pos_x - shape.config(var.syl.S, 'width')/2","fx.pos_y, fx.pos_y","","12","(1 - 0.8*module)*l.scale_x","(syl.i == 1) and var.syl.S or nil","format('\\\\bord0\\\\shad0\\\\blur2\\\\fad(200,0)\\\\1vc%s', color.module(shape.color1c, '&HFFFFFF&'))","S = shape.size(shape.circle, 80*ratio)"); table.insert(shape_fx_library, Power_Ball_Intro); table.insert(shape_fx, "Power Ball Intro")
	Power_Ball_Outro = table.duplicate(Shape_Box); table.inbox(Power_Ball_Outro, "shape[fx]: Power Ball Outro","Line",false,false,"#3661AD","#3F3C3C","#FFFFFF","80","0","0","l.end_time","l.end_time + 400","","","","","syl.right","syl.middle","","","5","1","fx.pos_x - shape.config(var.syl.S, 'width')/2, fx.pos_x + shape.config(var.syl.S, 'width')/2","fx.pos_y, fx.pos_y","","12","(1 - 0.7*module)*l.scale_x","(syl.i == syl.n) and var.syl.S or nil","format('\\\\bord0\\\\shad0\\\\blur2\\\\fad(0,200)\\\\1vc%s', color.module(shape.color1c, '&HFFFFFF&'))","S = shape.size(shape.circle, 100*ratio)"); table.insert(shape_fx_library, Power_Ball_Outro); table.insert(shape_fx, "Power Ball Outro")
	Quadrilateral_Hilight_I = table.duplicate(Shape_Box); table.inbox(Quadrilateral_Hilight_I, "shape[fx]: Quadrilateral Hilight I","Syl",true,false,"#E2EAFD","#FFFFFF","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 300","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","0.7*math.distance(0, 0, syl.width, syl.height)","shape.rectangle","format('\\\\1va%s\\\\3vc%s\\\\bord%s\\\\shad0\\\\fry90\\\\t(0,150,\\\\fry0)\\\\fad(0,300)', alpha.va('&HFF&'), color.vc('&HFFFFFF&'), var.syl.bord)","bord = 2*ratio"); table.insert(shape_fx_library, Quadrilateral_Hilight_I); table.insert(shape_fx, "Quadrilateral Hilight I")
	Quadrilateral_Hilight_II = table.duplicate(Shape_Box); table.inbox(Quadrilateral_Hilight_II, "shape[fx]: Quadrilateral Hilight II","Syl",true,false,"#E2EAFD","#FFFFFF","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time + 300","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","1","0.7*math.distance(0, 0, syl.width, syl.height)","shape.rectangle","format('\\\\1va%s\\\\3vc%s\\\\bord%s\\\\shad0\\\\fry90\\\\t(0,150,\\\\fry0)\\\\t(%s,%s,\\\\fr90\\\\fscx%s\\\\fscy%s)\\\\fad(0,300)', alpha.va('&HFF&'), color.vc('&HFFFFFF&'), var.syl.bord, fx.dur - 150, fx.dur, fx.sizex/2, fx.sizex/2)","bord = 2*ratio"); table.insert(shape_fx_library, Quadrilateral_Hilight_II); table.insert(shape_fx, "Quadrilateral Hilight II")
	Quadrilateral_Hilight_III = table.duplicate(Shape_Box); table.inbox(Quadrilateral_Hilight_III, "shape[fx]: Quadrilateral Hilight III","Syl",false,false,"#FFFFFF","#6CAFFD","#FFFFFF","255","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x - (fx.sizex + syl.width)/2, fx.pos_x - (fx.sizex - syl.width)/2","fx.pos_y, fx.pos_y","","1","60*ratio","shape.rectangle","'\\\\bord2\\\\shad0'",""); table.insert(shape_fx_library, Quadrilateral_Hilight_III); table.insert(shape_fx, "Quadrilateral Hilight III")
	Quadrilateral_Hilight_IV = table.duplicate(Shape_Box); table.inbox(Quadrilateral_Hilight_IV, "shape[fx]: Quadrilateral Hilight IV","Syl",false,false,"#FFFFFF","#6CAFFD","#FFFFFF","255","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x - (fx.sizex + syl.width)/2, fx.pos_x - (fx.sizex - syl.width)/2","fx.pos_y, fx.pos_y","","1","60*ratio","shape.rectangle","'\\\\bord2\\\\shad0\\\\t(\\\\fr-90)'",""); table.insert(shape_fx_library, Quadrilateral_Hilight_IV); table.insert(shape_fx, "Quadrilateral Hilight IV")
	Quadrilateral_Hilight_V = table.duplicate(Shape_Box); table.inbox(Quadrilateral_Hilight_V, "shape[fx]: Quadrilateral Hilight V","Syl",false,false,"#FFFFFF","#6CAFFD","#FFFFFF","255","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x - (fx.sizex + syl.width)/2, fx.pos_x - (fx.sizex - syl.width)/2","fx.pos_y, fx.pos_y","","1","60*ratio","shape.rectangle","format('\\\\fscx%s\\\\fscy%s\\\\t(\\\\fr-90\\\\fscx%s\\\\fscy%s)', fx.sizex*(1 + 0.25*(-1)^syl.i), fx.sizex*(1 + 0.25*(-1)^syl.i), fx.sizex*(1 + 0.25*(-1)^(syl.i + 1)), fx.sizex*(1 + 0.25*(-1)^(syl.i + 1)))",""); table.insert(shape_fx_library, Quadrilateral_Hilight_V); table.insert(shape_fx, "Quadrilateral Hilight V")
	Reverberation = table.duplicate(Shape_Box); table.inbox(Reverberation, "shape[fx]: Reverberation","Syl",true,false,"#E2EAFD","#82957E","#FFFFFF","0","0","0","l.start_time + syl.start_time + syl.dur*module","l.start_time + syl.start_time + syl.dur*module + var.syl.delay","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","ceil((syl.dur + var.syl.delay)/90)","0","shape.circle","format('\\\\shad0\\\\1va%s\\\\t(\\\\fscx%s\\\\fscy%s)\\\\3vc%s\\\\fad(0,%s)', alpha.va('&HFF&'), var.syl.sizexy, var.syl.sizexy, table.make('color', maxj, var.syl.color1, var.syl.color2)[j], var.syl.delay/2)","delay = 300, sizexy = 90*ratio, color1 = random.color(), color2 = random.color()"); table.insert(shape_fx_library, Reverberation); table.insert(shape_fx, "Reverberation")
	Shine_Circle_Shape = table.duplicate(Shape_Box); table.inbox(Shine_Circle_Shape, "shape[fx]: Shine Circle Shape","Syl",true,false,"#E2EAFD","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_y","","1","math.distance(0, 0, syl.width, syl.height)","shape.circle","format('\\\\bord0\\\\shad0\\\\blur%s\\\\1vc%s\\\\fad(100,100)', var.syl.blurfx, color.vc(random.color()))","blurfx = math.round((syl.width < l.fontsize/2) and 15 or syl.width/3, 2)"); table.insert(shape_fx_library, Shine_Circle_Shape); table.insert(shape_fx, "Shine Circle Shape")
	Shine_Circle_Shape_Multi = table.duplicate(Shape_Box); table.inbox(Shine_Circle_Shape_Multi, "shape[fx]: Shine Circle Shape Multi","Syl",true,false,"#FFFFFF","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","5","1","fx.pos_x","fx.pos_y","","var.syl.loopfx","8*ratio","shape.shine2t","format('\\\\bord0.4\\\\blur4\\\\shad0\\\\fsvp%s\\\\frz%s\\\\t(\\\\frz%s)\\\\3vc%s', (syl.width < l.fontsize) and 40*ratio or syl.width/1.5, 360*j/maxj, 360*j/maxj + 0.1*fx.dur, random.colorvc()), tag.glitter(fx.dur, '\\\\3vc'..color.vc('&HFFFFFF&'), '\\\\3vc'..random.colorvc())","loopfx = math.distance(0, 0, syl.width, syl.height)/6"); table.insert(shape_fx_library, Shine_Circle_Shape_Multi); table.insert(shape_fx, "Shine Circle Shape Multi")
	Shine_Fake_I = table.duplicate(Shape_Box); table.inbox(Shine_Fake_I, "shape[fx]: Shine Fake I","Syl",true,false,"#FFFFFF","#3F3C3C","#FFFFFF","0","0","0","l.start_time + syl.start_time","l.start_time + syl.end_time","","","","","syl.center","syl.middle","","","2","0","fx.pos_l + fx.sizex/2 + (j - 1)*fx.sizex","fx.pos_b - l.descent","","ceil(syl.width/var.syl.pixel)","var.syl.pixel, 0","shape.rectangle","var.syl.shine_shape(fx.dur, 40, 100), format('\\\\bord0\\\\shad0\\\\1va%s', alpha.gradientv('&HFF&', text.alpha1a))","pixel = 7*ratio, shine_shape = function(dur, min_y, max_y) return format('\\\\t(0,1,\\\\blur1\\\\fscy%s)\\\\t(1,%d,\\\\blur0\\\\fscy%s)', R(min_y, max_y)*ratio, dur, R(min_y)*ratio) end"); table.insert(shape_fx_library, Shine_Fake_I); table.insert(shape_fx, "Shine Fake I")
	Snake_in_Line_Duration = table.duplicate(Shape_Box); table.inbox(Snake_in_Line_Duration, "shape[fx]: Snake in Line Duration","Line",true,false,"#FFFFFF","#FB3EFC","#000000","0","0","0","l.start_time + line.duration*module","fx.start_time + line.duration/3.6","s","sin(s)","-var.syl.D*pi","var.syl.D*pi","line.center","line.middle","(0.5*l.height + l.width)/(2*var.syl.D*pi)","l.height/2","5","0","fx.pos_x","fx.pos_y","","0.55*l.width","3*ratio","shape.circle","'\\\\bord0.2\\\\blur4\\\\fad(50,200)'","D = ceil(l.width/520)"); table.insert(shape_fx_library, Snake_in_Line_Duration); table.insert(shape_fx, "Snake in Line Duration")
	Snake_Star_Hilight = table.duplicate(Shape_Box); table.inbox(Snake_Star_Hilight, "shape[fx]: Snake Star Hilight","Syl",true,false,"#FFFFFF","#FF6A69","#000000","0","40","0","l.start_time + syl.start_time + syl.dur*module","fx.start_time + R(20)*50 + 600","","","","","syl.center","syl.middle","","","5","R(2)","fx.pos_l + syl.width*module, fx.pos_l - R(20,70) - 45*module","fx.pos_y + var.loop.Dy1, fx.pos_y + var.loop.Dy2","","syl.dur/20","12","var.loop.S[R(2)]","tag.glitter(fx.dur, '\\\\3vc'..color.vc('&HFFFFFF&'), '\\\\3vc'..shape.color3), '\\\\bord0.4\\\\blur4\\\\fad(0,200)'","Dy1 = R(-0.3*l.fontsize, 0.3*l.fontsize), Dy2 = R(-0.3*l.fontsize, 0.3*l.fontsize), S = {shape.shine1t, shape.size(shape.circle, 10)}"); table.insert(shape_fx_library, Snake_Star_Hilight); table.insert(shape_fx, "Snake Star Hilight")
	Stars_Rain_postline = table.duplicate(Shape_Box); table.inbox(Stars_Rain_postline, "shape[fx]: Stars Rain postline","Syl",true,false,"#FFFFFF","#008DFF","#FFFFFF","20","40","0","l.end_time + 50*(syl.i - syl.n + 1) + R(-200,0)","l.end_time + 50*(syl.i - syl.n + 1) + R(800,1600)","","","","","syl.center","syl.middle","","","5","R(0, 2)","fx.pos_x + var.loop.dx1, fx.pos_x - var.loop.dx2","fx.pos_y + var.loop.dy1, fx.pos_y - var.loop.dy1","","R(8,16)","R(10,15)","shape.shine2t","'\\\\bord0.4\\\\shad0\\\\blur4\\\\fad(20,200)', tag.glitter(fx.dur, '\\\\3vc'..color.vc('&HFFFFFF&'), '\\\\3vc'..shape.color3)","dx1 = R(-syl.width/2, syl.width/2), dx2 = R(60, 500)*ratio, dy1 = R(-0.36*syl.height, 0.4*syl.height)"); table.insert(shape_fx_library, Stars_Rain_postline); table.insert(shape_fx, "Stars Rain postline")
	Stars_Rain_presyl = table.duplicate(Shape_Box); table.inbox(Stars_Rain_presyl, "shape[fx]: Stars Rain presyl","Syl",true,false,"#FFFFFF","#008DFF","#FFFFFF","20","40","0","l.start_time + 50*(syl.i - syl.n - 1) + R(-200,0) + 200*module","fx.start_time + R(600,800)","","","","","syl.center","syl.middle","","","5","R(0,2)","fx.pos_x + var.loop.dx1, fx.pos_x - var.loop.dx2","fx.pos_y, fx.pos_y + R(-40,40)","","R(8,16)","R(10,15)","shape.shine2t","'\\\\bord0.4\\\\shad0\\\\blur4\\\\fad(20,200)', tag.glitter(fx.dur, '\\\\3vc'..color.vc('&HFFFFFF&'), '\\\\3vc'..shape.color3)","dx1 = R(-syl.width/2, syl.width/2), dx2 = R(100, 200)*ratio, dy1 = R(-0.4*syl.height, 0.4*syl.height)"); table.insert(shape_fx_library, Stars_Rain_presyl); table.insert(shape_fx, "Stars Rain presyl")
	Steam_Hilight = table.duplicate(Shape_Box); table.inbox(Steam_Hilight, "shape[fx]: Steam Hilight","Syl",true,false,"#41FF95","#3F3C3C","#FFFFFF","80","0","0","l.start_time + syl.start_time + R(syl.dur)","fx.start_time + 800 + R(400)","","","","","syl.center","syl.middle","","","5","1","fx.pos_x + var.loop.dx1, fx.pos_x + var.loop.dx2, fx.pos_x + var.loop.dx1","fx.pos_y + var.loop.dy1, fx.pos_y - var.loop.dy2/2,  fx.pos_y - var.loop.dy2","","syl.dur/15","var.syl.size, 2*var.syl.size","shape.diamond","'\\\\bord0\\\\shad0\\\\fad(0,200)\\\\blur2'","size = 5*ratio, dx1 = R(-syl.width/2, syl.width/2), dy1 = R(-0.2*syl.height, 0.2*syl.height), dx2 = R(-syl.width/2, syl.width/2), dy2 = R(0.5*syl.height, 1.5*syl.height)"); table.insert(shape_fx_library, Steam_Hilight); table.insert(shape_fx, "Steam Hilight")
	Steam_Hilight_II = table.duplicate(Shape_Box); table.inbox(Steam_Hilight_II, "shape[fx]: Steam Hilight II","Syl",true,false,"#0365FD","#3F3C3C","#FFFFFF","90","0","0","l.start_time + syl.start_time + syl.dur*module","fx.start_time + 800","","","","","syl.center","syl.middle","","","5","1","fx.pos_l + syl.width*module + R(-10, 10)*ratio, fx.pos_l + syl.width*module + var.loop.dx1","fx.pos_b - l.descent - R(-3, 12)*ratio, fx.pos_b - l.descent - var.loop.dy1","","syl.dur/8","var.syl.size, 2*var.syl.size","shape.diamond","'\\\\bord0\\\\shad0\\\\fad(80,200)\\\\blur3'","size = 8*ratio, dx1 = R(-syl.width/4, 40), dy1 = R(syl.height/2, syl.height)"); table.insert(shape_fx_library, Steam_Hilight_II); table.insert(shape_fx, "Steam Hilight II")
	Thunder_Line = table.duplicate(Shape_Box); table.inbox(Thunder_Line, "shape[fx]: Thunder Line","Line",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","line.center","line.middle","","","5","0","fx.pos_x","fx.pos_y","","3","","shape.origin(var.loop.thunder(20, 15, l.width))","format('\\\\3vc%s\\\\blur3\\\\t(\\\\frx%s)', shape.color3, R(1.5*fx.dur, 2*fx.dur)*(-1)^R(2))","thunder = function(max_x, max_y, max_x2) i, X, Y = 1, {}, {} DX = 0 Tag = 'm 0 0 l ' while DX < max_x2 do dx = R(8, max_x) dy = R(-max_y, max_y) X[i] = DX + dx Y[i] = dy Tag = Tag..format('%s %s l ', X[i], Y[i]) DX = DX + dx; i = i + 1 end Tag = Tag:sub(1, -3) for i = 1, #X do Tag = Tag..format('%s %s l ', X[#X - i + 1], Y[#Y - i + 1] + R(0,2)) end Tag = Tag:sub(1, -3) return Tag end"); table.insert(shape_fx_library, Thunder_Line); table.insert(shape_fx, "Thunder Line")
	Thunder_Syl = table.duplicate(Shape_Box); table.inbox(Thunder_Syl, "shape[fx]: Thunder Syl","Syl",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + syl.start_time - 100 + syl.dur*module","fx.start_time + 400","","","","","syl.center","syl.middle","","","2","0","fx.pos_l, fx.pos_l + 1.25*syl.width*module","fx.pos_t + l.descent, fx.pos_t + l.descent","","ceil(syl.dur/50)","","shape.origin(shape.rotate(var.loop.thunder(20, 15, 80), R(80, 100)))","format('\\\\3vc%s\\\\fr%s\\\\blur3\\\\t(\\\\fry%s)\\\\fad(200,200)', shape.color3, R(-20,20), R(1.5*fx.dur, 2*fx.dur)*(-1)^R(2))","thunder = function(max_x, max_y, max_x2) i, X, Y = 1, {}, {} DX = 0 Tag = 'm 0 0 l ' while DX < max_x2 do dx = R(8, max_x) dy = R(-max_y, max_y) X[i] = DX + dx Y[i] = dy Tag = Tag..format('%s %s l ', X[i], Y[i]) DX = DX + dx; i = i + 1 end Tag = Tag:sub(1, -3) for i = 1, #X do Tag = Tag..format('%s %s l ', X[#X - i + 1], Y[#Y - i + 1] + R(0,2)) end Tag = Tag:sub(1, -3) return Tag end"); table.insert(shape_fx_library, Thunder_Syl); table.insert(shape_fx, "Thunder Syl")
	Water_Waves = table.duplicate(Shape_Box); table.inbox(Water_Waves, "shape[fx]: Water Waves","Syl",true,false,"#FFFFFF","#FFFFFF","#FFFFFF","0","0","0","l.start_time + syl.start_time + syl.dur*module","fx.start_time + var.syl.delay","","","","","syl.center","syl.middle","","","5","0","fx.pos_x","fx.pos_b - 0.8*l.descent","","ceil((syl.dur + var.syl.delay)/400)","0","shape.circle","format('\\\\shad0\\\\bord2\\\\1va%s\\\\t(\\\\fscx%s\\\\fscy%s)\\\\fad(60,%s)', alpha.va('&HFF&'), 1.2*var.syl.sizexy, var.syl.sizexy/4, var.syl.delay)","delay = 500, sizexy = 100*ratio"); table.insert(shape_fx_library, Water_Waves); table.insert(shape_fx, "Water Waves")
	
	--translation FX List
	Agitation_Char = table.duplicate(Trans_Box); table.inbox(Agitation_Char, "translation[fx]: Agitation Char","Translation Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(char.i - char.n/2 + 8)","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x - char.height, fx.pos_x","fx.pos_y, fx.pos_y","0, 400","1","","char.text","tag.oscill(450, 150, '\\\\fsvp'..var.char.dy, '\\\\fsvp'..-var.char.dy, '\\\\fsvp0'), '\\\\fad(200,300)'","dy = 7*ratio"); table.insert(transla_fx_library, Agitation_Char); table.insert(transla_fx, "Agitation Char")
	Agitation_Char_VSFilter = table.duplicate(Trans_Box); table.inbox(Agitation_Char_VSFilter, "translation[fx]: Agitation Char VSFilter","Translation Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + time_li(30) + 100","l.end_time + time_lo(30) - 100","","","","","char.center","char.middle","","","5","0","fx.pos_x - char.height, fx.pos_x","fx.pos_y, fx.pos_y","0, 400","1","","char.text","format('\\\\org(%s,%s)\\\\fad(200,200)', fx.move_x1 - 10000*ratio, fx.move_y1), tag.oscill(450, 150, '\\\\fr'..angle, '\\\\fr'..-angle, '\\\\fr0')","angle = 0.04*ratio","Lua"); table.insert(transla_fx_library, Agitation_Char_VSFilter); table.insert(transla_fx, "Agitation Char VSFilter")
	Asault_Translation = table.duplicate(Trans_Box); table.inbox(Asault_Translation, "translation[fx]: Asault Translation","Translation Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time - var.loop.delay","l.end_time - 300","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x","fx.pos_y - var.syl.d, fx.pos_y","200, 400","1","","char.text","format('\\\\org(%s,%s)\\\\frx180\\\\fscx%s\\\\fscy%s\\\\blur3\\\\t(0,400,0.5,\\\\frx0\\\\fscx%s\\\\blur0)\\\\t(0,400,\\\\fscy%s)\\\\fad(150,300)', fx.pos_x, fx.pos_y, 0.3*l.scale_x, 3*l.scale_y, l.scale_x, l.scale_y)","delay = R(400, 800), d = 100"); table.insert(transla_fx_library, Asault_Translation); table.insert(transla_fx, "Asault Translation")
	Blur_Line = table.duplicate(Trans_Box); table.inbox(Blur_Line, "translation[fx]: Blur Line","Translation Line",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","l.center","l.middle","","","5","0","fx.pos_x","fx.pos_y","","1","l.scale_x, l.scale_y","line.text_stripped","format('\\\\bord0\\\\fscy%s\\\\blur12\\\\t(0,300,\\\\fscy%s\\\\blur0)\\\\t(299,300,\\\\bord%s)\\\\t(%s,%s,\\\\bord0)\\\\t(%s,%s,\\\\fscy%s\\\\blur12)', 2.6*l.scale_y, l.scale_y, l.outline, fx.dur - 301, fx.dur - 300, fx.dur - 300, fx.dur, 2.6*l.scale_y)","","Lua"); table.insert(transla_fx_library, Blur_Line); table.insert(transla_fx, "Blur Line")
	Char_Dancing_I = table.duplicate(Trans_Box); table.inbox(Char_Dancing_I, "translation[fx]: Char Dancing I","Translation Char",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time + time_li(25)","l.end_time + time_lo(25)","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","tag.oscill( fx.dur, 360, format(\"\\\\fr%s\", -Angle*(-1)^char.i), format(\"\\\\fr%s\", Angle*(-1)^char.i) ), \"\\\\fad(200,200)\"","Angle = 8","Lua"); table.insert(transla_fx_library, Char_Dancing_I); table.insert(transla_fx, "Char Dancing I")
	Char_Dancing_II = table.duplicate(Trans_Box); table.inbox(Char_Dancing_II, "translation[fx]: Char Dancing II","Translation Char",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time + time_li(25)","l.end_time + time_lo(25)","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format(\"\\\\org(%s,%s)\\\\fad(200,200)\", fx.move_x1 - 10000, fx.move_y1), tag.oscill( fx.dur, 360, format(\"\\\\fr%s\", -Angle*(-1)^char.i), format(\"\\\\fr%s\", Angle*(-1)^char.i) )","Angle = 0.02","Lua"); table.insert(transla_fx_library, Char_Dancing_II); table.insert(transla_fx, "Char Dancing II")
	Char_Move_Wind = table.duplicate(Trans_Box); table.inbox(Char_Move_Wind, "translation[fx]: Char Move Wind","Translation Char",true,false,"#CE04D9","#ADC4D6","#6A8DD6","0","0","0","l.start_time + time_li(20)","l.end_time + time_lo(20) - 200","","","","","char.center","char.middle","","","5","","fx.pos_x","fx.pos_y","","1","","char.text","'\\\\fad(200,200)', shape.Smove(var.line.random_move)","random_move = shape.ratio(shape.trajectory( ), 0.25)","Lua"); table.insert(transla_fx_library, Char_Move_Wind); table.insert(transla_fx, "Char Move Wind")
	Char_Random_LI = table.duplicate(Trans_Box); table.inbox(Char_Random_LI, "translation[fx]: Char Random LI","Translation Char",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time + time_li(30) + delay*(j - 1)","tag.only( j == maxj, l.end_time + time_lo(30), fx.start_time + delay)","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","5","","tag.only( j == maxj, char.text, string.char(R(56,99)))","tag.only(j ~= maxj, format('\\\\alpha%s\\\\t(\\\\alpha%s)', alpha.interpolate('&HFF&', '&H00&', (j-1)/maxj), alpha.interpolate('&HFF&', '&H00&', j/maxj)), '\\\\fad(0,200)')","delay = 80","Lua"); table.insert(transla_fx_library, Char_Random_LI); table.insert(transla_fx, "Char Random LI")
	Char_Random_LI_II = table.duplicate(Trans_Box); table.inbox(Char_Random_LI_II, "translation[fx]: Char Random LI II","Translation Char",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time + delay*(j - 1) + R(-200,200)","tag.only( j == maxj, l.end_time - 160, fx.start_time + delay)","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","5","","tag.only( j == maxj, char.text, string.char(R(56,99)))","tag.only(j ~= maxj, format('\\\\alpha%s\\\\t(\\\\alpha%s)', alpha.interpolate('&HFF&', '&H00&', (j-1)/maxj), alpha.interpolate('&HFF&', '&H00&', j/maxj)), '\\\\fad(0,200)')","delay = 2*frame_dur","Lua"); table.insert(transla_fx_library, Char_Random_LI_II); table.insert(transla_fx, "Char Random LI II")
	Char_Twister = table.duplicate(Trans_Box); table.inbox(Char_Twister, "translation[fx]: Char Twister","Translation Char",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time + char.i*20 -1250","l.end_time + time_lo(30)","","","","","char.center","char.middle","","","5","0","fx.pos_x + Dxy, fx.pos_x","fx.pos_y - Dxy, fx.pos_y","800, 1000","1","","char.text","format('\\\\org(%s,%s)\\\\alpha&HFF&\\\\frz180\\\\fscx%s\\\\fscy%s\\\\t(0,800,0.6,\\\\frz720\\\\fscx%s\\\\fscy%s\\\\3a&H00&)\\\\t(800,1000,\\\\alpha&H00&)\\\\fad(0,200)', fx.pos_x, fx.pos_y, 0.6*l.scale_x, 0.6*l.scale_y, l.scale_x, l.scale_y)","Dxy = 16*ratio","Lua"); table.insert(transla_fx_library, Char_Twister); table.insert(transla_fx, "Char Twister")
	Char_Twister_Double = table.duplicate(Trans_Box); table.inbox(Char_Twister_Double, "translation[fx]: Char Twister Double","Translation Char",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time + char.i*20 -1250","l.end_time + time_lo(30)","","","","","char.center","char.middle","","","5","0","fx.pos_x + Dxy*(-1)^j, fx.pos_x","fx.pos_y - Dxy*(-1)^j, fx.pos_y","800, 1000","2","","char.text","format('\\\\org(%s,%s)\\\\alpha&HFF&\\\\frz180\\\\fscx%s\\\\fscy%s\\\\t(0,800,0.6,\\\\frz720\\\\fscx%s\\\\fscy%s\\\\3a&H00&)\\\\t(800,1000,\\\\alpha&H00&)\\\\fad(0,200)', fx.pos_x, fx.pos_y, 0.6*l.scale_x, 0.6*l.scale_y, l.scale_x, l.scale_y), tag.only(j == 1, '\\\\t(1000,1001,\\\\alpha&HFF&)')","Dxy = 16*ratio","Lua"); table.insert(transla_fx_library, Char_Twister_Double); table.insert(transla_fx, "Char Twister Double")
	Clasic_Fade = table.duplicate(Trans_Box); table.inbox(Clasic_Fade, "translation[fx]: Clasic Fade","Translation Line",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","line.center","line.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","line.text_stripped","'\\\\fad(300,300)'",""); table.insert(transla_fx_library, Clasic_Fade); table.insert(transla_fx, "Clasic Fade")
	Crazy_Dancing_Char = table.duplicate(Trans_Box); table.inbox(Crazy_Dancing_Char, "translation[fx]: Crazy Dancing Char","Translation Char",true,false,"#CE04D9","#ADC4D6","#6A8DD6","0","0","0","l.start_time","l.end_time","","","","","char.center","char.middle","","","5","","fx.pos_x","fx.pos_y","","1","","char.text","shape.Rmove(5*ratio, 5*ratio, 0, fx.dur, 1, 200)","","Lua"); table.insert(transla_fx_library, Crazy_Dancing_Char); table.insert(transla_fx, "Crazy Dancing Char")
	Move_Char_I = table.duplicate(Trans_Box); table.inbox(Move_Char_I, "translation[fx]: Move Char I","Translation Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 30*(char.i - char.n/2 -1)","l.end_time + 30*(char.i - char.n/2 -1)","","","","","char.center","char.middle","","","5","0","fx.pos_x + R(-25, 25), fx.pos_x","fx.pos_y + R(-25, 25), fx.pos_y","0, 400","1","","char.text","'\\\\fad(300,300)'",""); table.insert(transla_fx_library, Move_Char_I); table.insert(transla_fx, "Move Char I")
	Move_Char_II = table.duplicate(Trans_Box); table.inbox(Move_Char_II, "translation[fx]: Move Char II","Translation Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x + R(-25, 25), fx.pos_x","fx.pos_y + R(-25, 25), fx.pos_y","0, 400","1","","char.text","'\\\\fad(300,300)'",""); table.insert(transla_fx_library, Move_Char_II); table.insert(transla_fx, "Move Char II")
	Move_Char_III_postline = table.duplicate(Trans_Box); table.inbox(Move_Char_III_postline, "translation[fx]: Move Char III postline","Translation Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x, fx.pos_x + R(-10, 10)*ratio","fx.pos_y, fx.pos_y + R(20, 30)*ratio","fx.dur - 400, fx.dur","1","","char.text","format('\\\\t(%s,%s,\\\\frx%s\\\\fry%s\\\\frz%s)\\\\fad(300,300)', fx.dur - 400, fx.dur, R(-360,360), R(-360,360), R(-360,360))",""); table.insert(transla_fx_library, Move_Char_III_postline); table.insert(transla_fx, "Move Char III postline")
	Move_Char_III_preline = table.duplicate(Trans_Box); table.inbox(Move_Char_III_preline, "translation[fx]: Move Char III preline","Translation Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x + R(-10, 10)*ratio, fx.pos_x","fx.pos_y - R(20, 30)*ratio, fx.pos_y","0, 400","1","","char.text","format('\\\\frx%s\\\\fry%s\\\\frz%s\\\\t(0,400,\\\\frx0\\\\fry0\\\\frz0)\\\\fad(300,300)', R(-360,360), R(-360,360), R(-360,360))",""); table.insert(transla_fx_library, Move_Char_III_preline); table.insert(transla_fx, "Move Char III preline")
	Move_ShineLine_LR = table.duplicate(Trans_Box); table.inbox(Move_ShineLine_LR, "translation[fx]: Move ShineLine LR","Translation Line",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time","l.end_time","","","","","line.center","line.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","line.text_stripped","shape.Lmove2({-l.width/2, fx.pos_y, fx.pos_x, fx.pos_y, xres + l.width/2, fx.pos_y}, {0, delay, fx.dur - delay, fx.dur}), format('\\\\bord5\\\\blur4\\\\1c&HFFFFFF&\\\\3c&HFFFFFF&\\\\t(%s,%s,\\\\bord%s\\\\blur0\\\\1c%s\\\\3c%s)\\\\t(%s,%s,\\\\bord5\\\\blur4\\\\1c&HFFFFFF&\\\\3c&HFFFFFF&)', delay, delay + 1, l.outline, text.color1, text.color3, fx.dur - delay, fx.dur - delay + 1)","delay = 260","Lua"); table.insert(transla_fx_library, Move_ShineLine_LR); table.insert(transla_fx, "Move ShineLine LR")
	Move_ShineLine_RL = table.duplicate(Trans_Box); table.inbox(Move_ShineLine_RL, "translation[fx]: Move ShineLine RL","Translation Line",true,false,"#F6F3F3","#ADC4D6","#6A8DD6","0","0","0","l.start_time","l.end_time","","","","","line.center","line.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","line.text_stripped","shape.Lmove2({xres + l.width/2, fx.pos_y, fx.pos_x, fx.pos_y, -l.width/2, fx.pos_y}, {0, delay, fx.dur - delay, fx.dur}), format('\\\\bord5\\\\blur4\\\\1c&HFFFFFF&\\\\3c&HFFFFFF&\\\\t(%s,%s,\\\\bord%s\\\\blur0\\\\1c%s\\\\3c%s)\\\\t(%s,%s,\\\\bord5\\\\blur4\\\\1c&HFFFFFF&\\\\3c&HFFFFFF&)', delay, delay + 1, l.outline, text.color1, text.color3, fx.dur - delay, fx.dur - delay + 1)","delay = 260","Lua"); table.insert(transla_fx_library, Move_ShineLine_RL); table.insert(transla_fx, "Move ShineLine RL")
	Screw_Char = table.duplicate(Trans_Box); table.inbox(Screw_Char, "translation[fx]: Screw Char","Translation Char",true,false,"#DBF5FF","#415462","#000000","0","0","0","l.start_time + time_li(30) + 100","l.end_time + time_lo(30) - 100","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","","char.text","format('\\\\frx-180\\\\t(0,400,0.8,\\\\frx0)\\\\t(%s,%s,0.8,\\\\frx180)\\\\fad(220,220)', fx.dur - 400, fx.dur)",""); table.insert(transla_fx_library, Screw_Char); table.insert(transla_fx, "Screw Char")
	Translation_Clasic_Char = table.duplicate(Trans_Box); table.inbox(Translation_Clasic_Char, "translation[fx]: Translation Clasic Char","Translation Char",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 15*(char.i - char.n -1)","l.end_time","","","","","char.center","char.middle","","","5","0","fx.pos_x","fx.pos_y","","1","l.scale_x, l.scale_y","char.text","'\\\\fad(300,300)'","delay = R(100,500)"); table.insert(transla_fx_library, Translation_Clasic_Char); table.insert(transla_fx, "Translation Clasic Char")
	Translation_Word = table.duplicate(Trans_Box); table.inbox(Translation_Word, "translation[fx]: Translation Word","Translation Word",true,false,"#FFFFFF","#008DFF","#000000","0","0","0","l.start_time + 50*(word.i - word.n -1)","l.end_time","","","","","word.center","word.middle","","","5","0","fx.pos_x + R(-25, 25), fx.pos_x","fx.pos_y + R(-25, 25), fx.pos_y","0, 400","1","l.scale_x, l.scale_y","word.text","'\\\\fad(300,300)'","delay = R(100,500)"); table.insert(transla_fx_library, Translation_Word); table.insert(transla_fx, "Translation Word")
	
	--===========================================================================================--
	include("Effector-newfx-3.2.lua")
	--include(Path_Effector_newfx_lua)
	for i = 1, #leadin_fx do
		if i < 10 then
			leadin_fx[i] = "[00"..i.."] "..leadin_fx[i]
		elseif i < 100 then
			leadin_fx[i] = "[0"..i.."] "..leadin_fx[i]
		else
			leadin_fx[i] = "["..i.."] "..leadin_fx[i]
		end
	end
	for i = 1, #hilight_fx do
		if i < 10 then
			hilight_fx[i] = "[00"..i.."] "..hilight_fx[i]
		elseif i < 100 then
			hilight_fx[i] = "[0"..i.."] "..hilight_fx[i]
		else
			hilight_fx[i] = "["..i.."] "..hilight_fx[i]
		end
	end
	for i = 1, #leadout_fx do
		if i < 10 then
			leadout_fx[i] = "[00"..i.."] "..leadout_fx[i]
		elseif i < 100 then
			leadout_fx[i] = "[0"..i.."] "..leadout_fx[i]
		else
			leadout_fx[i] = "["..i.."] "..leadout_fx[i]
		end
	end
	for i = 1, #shape_fx do
		if i < 10 then
			shape_fx[i] = "[00"..i.."] "..shape_fx[i]
		elseif i < 100 then
			shape_fx[i] = "[0"..i.."] "..shape_fx[i]
		else
			shape_fx[i] = "["..i.."] "..shape_fx[i]
		end
	end
	for i = 1, #transla_fx do
		if i < 10 then
			transla_fx[i] = "[00"..i.."] "..transla_fx[i]
		elseif i < 100 then
			transla_fx[i] = "[0"..i.."] "..transla_fx[i]
		else
			transla_fx[i] = "["..i.."] "..transla_fx[i]
		end
	end
	--=========================================================================================================--
	aegisub.register_macro(script_name.." "..script_version..script_update, script_description, effector.macro_fx)
	aegisub.register_filter(script_name.." "..script_version..script_update, "", 2000, effector.macro_fx)
	--=========================================================================================================--
