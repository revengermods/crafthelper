script_name('Crafth')
script_author('revenger mods')
script_version('1.0')

require "lib.moonloader" -- подключение библиотеки
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

local update_url = "https://raw.githubusercontent.com/revengermods/crafthelper/main/update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

local script_url = "" -- тут свою ссылку
local script_path = thisScript().path

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampRegisterChatCommand("crafth", cmd_imgui)
	sampAddChatMessage("{9370DB}Craft Helper{ffffff} успешно загружен! Активаия:{9370DB} /crafth", -1)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id)


    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("Есть обновление! Версия: " .. updateIni.info.vers_text, -1)
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
                    sampAddChatMessage("Скрипт успешно обновлен!", -1)
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
	if imgui.Selectable(u8"Аксессуары", menu == 1) then menu = 1 
	elseif imgui.Selectable(u8"Одежда", menu == 2) then menu = 2 
	elseif imgui.Selectable(u8"Химия", menu == 9) then menu = 9 
	elseif imgui.Selectable(u8"Обработка", menu == 7) then menu = 7 
	elseif imgui.Selectable(u8"Теплица", menu == 3) then menu = 3 
	elseif imgui.Selectable(u8"Тюнинг", menu == 10) then menu = 10 
	elseif imgui.Selectable(u8"Чертежи", menu == 11) then menu = 11 
	elseif imgui.Selectable(u8"Оружие", menu == 12) then menu = 12  
	elseif imgui.Selectable(u8"Телефон", menu == 13) then menu = 13 
	elseif imgui.Selectable(u8"Настройки", menu == 14) then menu = 14 end 
	imgui.EndChild()
	imgui.SameLine()
	imgui.BeginChild('right', imgui.ImVec2(0, -50), true) 
	if menu == 1 then
		-- 1  Маска от коронавируса
	imgui.Button(u8'Гитара Акустическая')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 5шт\nДрова - 10шт\nЛён - 50шт\nХлопок - 50шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end   
	imgui.Button(u8'Удочка')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 12шт\nДревесина высшего качества - 42шт\nАлюминий - 3шт\nЛён - 40шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Маска от коронавируса')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 100шт\nХлопок - 100шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8'Молоток')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 25шт\nБронза - 9шт\nКамень - 50шт\nХлопок - 5шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Канистра на бедро')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 20шт\nБронза - 3шт\nКанистра - 5шт\nЛён - 5шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'Фотоаппарат')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 18шт\nБронза - 4шт\nФотоаппарат - 80шт\nХлопок - 5шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'Кирка')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 13шт\nБронза - 6шт\nЛён - 10шт\nХлопок - 10шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Грабли')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 13шт\nБронза - 6шт\nЛён - 10шт\nХлопок - 10шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Дилдо на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nНабор с инструментами - 2шт\nЛён - 100шт\nХлопок - 100шт\nДрова - 400шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end																	
	imgui.Button(u8'Вибратор на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nНабор с инструментами - 2шт\nЛён - 100шт\nХлопок - 100шт\nДрова - 400шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end																	
	imgui.Button(u8'Жезл на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nНабор с инструментами - 2шт\nЛён - 100шт\nХлопок - 100шт\nДрова - 400шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Мед. сумка на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nНабор с инструментами - 2шт\nЛён - 100шт\nХлопок - 100шт\nДрова - 400шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Огнетушитель на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nКамень - 30шт\nМатериалы - 10шт\nСеребро - 1шт\nЛён - 3шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Клюшка на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nДрова - 6шт\nМатериалы - 24шт\nЛён - 5шт\nХлопок - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Бита на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень- 30шт\nДрова - 20шт\nМатериалы - 10шт\nХлопок - 5шт\nЛён - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Лопата на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 26шт\nДрова - 6шт\nМатериалы - 2шт\nЛён - 5шт\nХлопок - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Кий на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 8шт\nДрова - 6шт\nМеталл - 4шт\nЛён - 5шт\nХлопок - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Тесак на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nМатериалы - 11шт\nКамень - 12шт\nБронза - 3шт\nХлопок - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Топор на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 14шт\nМатериалы - 15шт\nКамень - 6шт\nСеребро - 3шт\nЛён - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Велосипед на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 50шт\nМатериалы - 35шт\nАлюминий - 15шт\nНабор с инструментами - 5шт\nБронза - 4шт\nСтоимость - 4500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Респиратор')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 5шт\nХлопок - 60шт\nАлюминий - 1шт\nЛён - 50шт\nШкура оленя - 1шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Дамская сумочка белая')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Дамская сумочка черная')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Дамская сумочка розовая')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Дамский клач красный')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Дамский клач синий')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Дамская сумочка GUCCI')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Леопардовый клач')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Дамская сумочка МК')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Дамская сумочка МК 2')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Сумка - уточка')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Синяя сумка')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Зеленая сумка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Шапка BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 2шт\nАлюминий - 10шт\nМеталл - 15шт\nЛён - 50шт\nХлопок - 50шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Маска BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 2шт\nАлюминий - 10шт\nМеталл - 15шт\nЛён - 50шт\nХлопок - 50шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Бронежилет BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 2шт\nАлюминий - 10шт\nМеталл - 15шт\nЛён - 50шт\nХлопок - 50шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Очки киберпанк")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 25шт\nХлопок - 25шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	elseif menu == 2 then
	-- Амиран (id:394)
	imgui.Button(u8"Амиран (id:394)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Литвин (id:395)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 3шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Эдвард Билл (id:396)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 3шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Хабиб (id:398)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 3шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Диана Шурыгина (id:399)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end		
------------------------------------------------------------------------------------------------------
	imgui.Button(u8"Ева Элфи (id:400)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Оскимирон (id:402)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Павленко (id:403)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Бузова (id:404)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Лукашенко (id:405)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end			
---------------------------------------------------------------------------------------------------
	imgui.Button(u8"Ресторатор (id:406)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Техник (id:407)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Баста (id:408)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Дзюба (id:409)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"? ван Урган (id:410)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end	
		-------------
	imgui.Button(u8"Noize MC (id:412)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Саша Грей (id:413)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 3шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Ричи Галлиани (id:416)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end																																															
	elseif menu == 9 then
	imgui.Button(u8"Аптечка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Наркотики - 1шт\nСтоимость - 150р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Адреналин")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Наркотики - 2шт\nНаркотический гриб - 2шт\nСтоимость - 900р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Смазка для разгона")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 14шт\nМатериалы - 10шт\nСеребро - 1шт\nКамень - 21шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"Охлаждающая жидкасть")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 20шт\nХлопок - 20шт\nДистиллированная вода - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Кусок редкой ткани")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 1шт\nХлопок - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end				
	elseif menu == 12 then
	imgui.Button(u8"Glock Pink")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end															
	imgui.Button(u8"Makarov Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end															
	imgui.Button(u8"TT Brown")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Deagle Red")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Deagle Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Colt Python Eagle")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"AK574 Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Скорпион Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"M249 Deserted")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 150шт\nАлюминий - 75шт\nБронза - 60шт\nХлопок - 180шт\nЛён - 180шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"M249 Vietnam")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 150шт\nАлюминий - 75шт\nБронза - 60шт\nХлопок - 180шт\nЛён - 180шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	elseif menu == 3 then
	imgui.Button(u8"Стол для смешивания")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 200шт\nМеталл - 40шт\nАлюминий - 10шт\nХлопок - 10шт\nПлоскогубцы - 1шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Бочка для воды")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 100шт\nМеталл - 10шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Лоток для растений")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 50шт\nПроволока - 1шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Лампа освещения")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Серебро - 3шт\nПроволока - 1шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Помпа для перекачки")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nБронза - 5шт\nМеталл - 10шт\nПроволока - 1шт\nВеревка - 1шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Опрыскиватель")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 20шт\nЗамок - 1шт\nНапильник - 1шт\nВеревка - 1шт\nМеталл - 5шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Ведро для воды")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nВеревка - 3шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Канистра для воды")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 2шт\nХлопок - 50шт\nАлюминий - 2шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end																																																				
	end			
	imgui.EndChild()
	----------------------------------------------------------------
	imgui.SetCursorPos(imgui.ImVec2(30, 350))
	if imgui.Button(u8'Автор',imgui.ImVec2(165,35)) then
	    os.execute('start https://vk.com/srevenreg')
    end
    imgui.SetCursorPos(imgui.ImVec2(205, 350))
   	if imgui.Button(u8'Закрыть',imgui.ImVec2(165,35)) then
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