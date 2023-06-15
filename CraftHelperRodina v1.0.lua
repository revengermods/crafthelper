script_name('Crafth')
script_author('revenger mods')
script_version('1.0')

require "lib.moonloader" -- ����������� ����������
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8



local main_window_state = imgui.ImBool(false)


update_state = false

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/revengermods/crafthelper/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "" -- ��� ���� ������
local script_path = thisScript().path

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampRegisterChatCommand("crafth", cmd_imgui)
	sampAddChatMessage("{9370DB}Craft Helper{ffffff} ������� ��������! ��������:{9370DB} /crafth", -1)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id)


    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)

	imgui.Process = false

	-------------------------------------------------------------------

	while true do
	  wait(0)


        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("������ ������� ��������!", -1)
                    thisScript():reload()
                end
            end)
            break
        end


	  if main_window_state.v == false then
	  	imgui.Process = false
	  end	
	end
end 

function cmd_imgui()
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end


function imgui.OnDrawFrame()
	if main_window_state then
	imgui.SetNextWindowSize(imgui.ImVec2(400, 400), imgui.Cond.FirstUseEver)
	if not window_pos then
		ScreenX, ScreenY = getScreenResolution()ScreenX, ScreenY = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
	end		
	imgui.Begin("Craft Helper", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)
	imgui.CenterText(u8" ")
	imgui.SameLine()
	imgui.SetCursorPos(imgui.ImVec2(4, 25))
	imgui.BeginChild('left', imgui.ImVec2(123, -50), true) 
	if imgui.Selectable(u8"����������", menu == 1) then menu = 1 
	elseif imgui.Selectable(u8"������", menu == 2) then menu = 2 
	elseif imgui.Selectable(u8"�����", menu == 9) then menu = 9 
	elseif imgui.Selectable(u8"���������", menu == 7) then menu = 7 
	elseif imgui.Selectable(u8"�������", menu == 3) then menu = 3 
	elseif imgui.Selectable(u8"������", menu == 10) then menu = 10 
	elseif imgui.Selectable(u8"�������", menu == 11) then menu = 11 
	elseif imgui.Selectable(u8"������", menu == 12) then menu = 12  
	elseif imgui.Selectable(u8"�������", menu == 13) then menu = 13 
	elseif imgui.Selectable(u8"���������", menu == 14) then menu = 14 end 
	imgui.EndChild()
	imgui.SameLine()
	imgui.BeginChild('right', imgui.ImVec2(0, -50), true) 
	if menu == 1 then
		-- 1  ����� �� ������������
	imgui.Button(u8'������ ������������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n����� - 10��\n˸� - 50��\n������ - 50��\n��������� - 3000�')
		    imgui.EndTooltip()
		end   
	imgui.Button(u8'������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 12��\n��������� ������� �������� - 42��\n�������� - 3��\n˸� - 40��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� �� ������������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 100��\n������ - 100��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8'�������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 25��\n������ - 9��\n������ - 50��\n������ - 5��\n��������� - 15000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'�������� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 20��\n������ - 3��\n�������� - 5��\n˸� - 5��\n��������� - 15000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'�����������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 18��\n������ - 4��\n����������� - 80��\n������ - 5��\n��������� - 15000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'�����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 13��\n������ - 6��\n˸� - 10��\n������ - 10��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 13��\n������ - 6��\n˸� - 10��\n������ - 10��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n����� � ������������� - 2��\n˸� - 100��\n������ - 100��\n����� - 400��\n��������� - 3000�')
		    imgui.EndTooltip()
		end																	
	imgui.Button(u8'�������� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n����� � ������������� - 2��\n˸� - 100��\n������ - 100��\n����� - 400��\n��������� - 3000�')
		    imgui.EndTooltip()
		end																	
	imgui.Button(u8'���� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n����� � ������������� - 2��\n˸� - 100��\n������ - 100��\n����� - 400��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'���. ����� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n����� � ������������� - 2��\n˸� - 100��\n������ - 100��\n����� - 400��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������������ �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 30��\n��������� - 10��\n������� - 1��\n˸� - 3��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n����� - 6��\n��������� - 24��\n˸� - 5��\n������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������- 30��\n����� - 20��\n��������� - 10��\n������ - 5��\n˸� - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 26��\n����� - 6��\n��������� - 2��\n˸� - 5��\n������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'��� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 8��\n����� - 6��\n������ - 4��\n˸� - 5��\n������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 11��\n������ - 12��\n������ - 3��\n������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 14��\n��������� - 15��\n������ - 6��\n������� - 3��\n˸� - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'��������� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 50��\n��������� - 35��\n�������� - 15��\n����� � ������������� - 5��\n������ - 4��\n��������� - 4500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n������ - 60��\n�������� - 1��\n˸� - 50��\n����� ����� - 1��\n��������� - 9000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������� ������� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ������� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ������� �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ���� �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������� ���� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������� ������� GUCCI')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����������� ����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������� ������� ��')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ������� �� 2')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� - ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 2��\n�������� - 10��\n������ - 15��\n˸� - 50��\n������ - 50��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 2��\n�������� - 10��\n������ - 15��\n˸� - 50��\n������ - 50��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"���������� BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 2��\n�������� - 10��\n������ - 15��\n˸� - 50��\n������ - 50��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 25��\n������ - 25��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	elseif menu == 2 then
	-- ������ (id:394)
	imgui.Button(u8"������ (id:394)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ (id:395)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 3��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ ���� (id:396)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 3��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� (id:398)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 3��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� �������� (id:399)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end		
------------------------------------------------------------------------------------------------------
	imgui.Button(u8"��� ���� (id:400)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"��������� (id:402)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� (id:403)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ (id:404)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"��������� (id:405)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end			
---------------------------------------------------------------------------------------------------
	imgui.Button(u8"���������� (id:406)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ (id:407)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� (id:408)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� (id:409)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"? ��� ����� (id:410)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end	
		-------------
	imgui.Button(u8"Noize MC (id:412)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���� ���� (id:413)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 3��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���� �������� (id:416)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end																																															
	elseif menu == 9 then
	imgui.Button(u8"�������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 1��\n��������� - 150�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 2��\n������������� ���� - 2��\n��������� - 900�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ��� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 14��\n��������� - 10��\n������� - 1��\n������ - 21��\n��������� - 3000�')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"����������� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 20��\n������ - 20��\n���������������� ���� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� ������ �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 1��\n������ - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end				
	elseif menu == 12 then
	imgui.Button(u8"Glock Pink")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end															
	imgui.Button(u8"Makarov Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end															
	imgui.Button(u8"TT Brown")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Deagle Red")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Deagle Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Colt Python Eagle")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"AK574 Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"M249 Deserted")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n�������� - 75��\n������ - 60��\n������ - 180��\n˸� - 180��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"M249 Vietnam")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n�������� - 75��\n������ - 60��\n������ - 180��\n˸� - 180��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	elseif menu == 3 then
	imgui.Button(u8"���� ��� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 200��\n������ - 40��\n�������� - 10��\n������ - 10��\n����������� - 1��\n��������� - 300000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ��� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 100��\n������ - 10��\n��������� - 300000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ��� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 50��\n��������� - 1��\n��������� - 300000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 3��\n��������� - 1��\n��������� - 300000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� ��� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n������ - 5��\n������ - 10��\n��������� - 1��\n������� - 1��\n��������� - 300000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n����� - 1��\n��������� - 1��\n������� - 1��\n������ - 5��\n��������� - 300000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ��� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������� - 3��\n��������� - 15000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"�������� ��� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 2��\n������ - 50��\n�������� - 2��\n��������� - 15000�')
		    imgui.EndTooltip()
		end																																																				
	end			
	imgui.EndChild()
	----------------------------------------------------------------
	imgui.SetCursorPos(imgui.ImVec2(30, 350))
	if imgui.Button(u8'�����',imgui.ImVec2(165,35)) then
	    os.execute('start https://vk.com/srevenreg')
    end
    imgui.SetCursorPos(imgui.ImVec2(205, 350))
   	if imgui.Button(u8'�������',imgui.ImVec2(165,35)) then
	    main_window_state.v = not main_window_state.v
    end
imgui.End()
end
end   


function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end


function black_purple()
	imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(0.57, 0.38, 0.99, 1.00);
    colors[clr.SliderGrab]             = ImVec4(0.50, 0.28, 1.00, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(0.50, 0.29, 0.98, 1.00);
    colors[clr.Button]                 = ImVec4(0.50, 0.28, 1.00, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(0.58, 0.40, 0.99, 1.00);
    colors[clr.ButtonActive]           = ImVec4(0.45, 0.22, 0.98, 1.00);
    colors[clr.Header]                 = ImVec4(0.50, 0.28, 1.00, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(0.56, 0.38, 0.98, 1.00);
    colors[clr.HeaderActive]           = ImVec4(0.45, 0.21, 0.99, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(0.50, 0.28, 1.00, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(0.57, 0.38, 1.00, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(0.47, 0.24, 1.00, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(0.57, 0.38, 1.00, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(0.45, 0.22, 0.99, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(0.42, 0.17, 0.99, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(0.53, 0.33, 0.99, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end
black_purple()