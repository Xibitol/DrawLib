local surface = surface
local draw = draw
local ipairs = ipairs
local Color = Color
local print = print

include("drawlib_config.lua")
local fonts = fonts
local colors = colors

fontLoaded = false
module("DrawLib")

----- Create font -----
function LoadFont()
    for k,v in ipairs(fonts) do
        surface.CreateFont(v.name, v.config)
    end

    fontloaded = true
end

----- Text Align -----
TEXT_ALIGN_LEFT = 0
TEXT_ALIGN_CENTER = 1
TEXT_ALIGN_RIGHT = 2
TEXT_ALIGN_TOP = 3
TEXT_ALIGN_BOTTOM = 4

----- Color function -----
function SetColor(color)
    for k,v in ipairs(colors) do
        if v.name == color then 
            return Color(v.r, v.g, v.b, v.a)
        end
    end

    return color
end

----- Draw box function -----
function Box(x, y, w, h, color)
    color = SetColor(color)

    surface.SetDrawColor(color.r, color.g, color.b, color.a)
    surface.DrawRect(x, y, w, h)
end
function RoundedBox(cornerRadius, x, y, w, h, color)
    color = SetColor(color)

    draw.RoundedBox(cornerRadius, x, y, w, h, color)
end

function BoxBorder(x, y, w, h, color, borderRadius, borderColor)
    if borderRadius == 0 then
        Box(x, y, w, h, color)
    else
        Box(x, y, w, h, color)

        Box(x+borderRadius, y, w-borderRadius*2, borderRadius, borderColor) -- UP
        Box(x + w - borderRadius, y, borderRadius, h, borderColor) -- LEFT
        Box(x+borderRadius, y + h - borderRadius, w-borderRadius*2, borderRadius, borderColor) -- DOWN
        Box(x, y, borderRadius, h, borderColor) -- RIGHT
    end
end

function OutlineBox(x, y, w, h, color, borderRadius)
    if borderRadius == 0 then
        return
    else
        Box(x+borderRadius, y, w-borderRadius*2, borderRadius, color) -- UP
        Box(x + w - borderRadius, y, borderRadius, h, color) -- LEFT
        Box(x+borderRadius, y + h - borderRadius, w-borderRadius*2, borderRadius, color) -- DOWN
        Box(x, y, borderRadius, h, color) -- RIGHT
    end
end

----- Draw image function -----
function Image(x, y, w, h, material, color)
    ImageRotated(x, y, w, h, 0, material, color)
end
function ImageRotated(x, y, w, h, r, material, color)
    color = SetColor(color)

    surface.SetDrawColor(color.r, color.g, color.b, color.a)
    surface.SetMaterial(material)
    surface.DrawTexturedRectRotated(x+w/2, y+h/2, w, h, r)
end

----- Draw text function -----
function GetTextSize(text, font)
    surface.SetFont(font)
    return surface.GetTextSize(text)
end
function Text(text, font, x, y, color, xalign, yalign)
    if fontLoaded == false then return end

    color = SetColor(color)
    xalign = xalign or TEXT_ALIGN_LEFT
	yalign = yalign or TEXT_ALIGN_TOP
	local w, h = GetTextSize(text, font)

	if ( xalign == TEXT_ALIGN_CENTER ) then
		x = x - w / 2
	elseif ( xalign == TEXT_ALIGN_RIGHT ) then
		x = x - w
	end

	if ( yalign == TEXT_ALIGN_CENTER ) then
		y = y - h / 2
	elseif ( yalign == TEXT_ALIGN_BOTTOM ) then
		y = y - h
	end

    surface.SetTextColor(color.r, color.g, color.b, color.a)
    surface.SetFont(font)
    surface.SetTextPos(x, y)
    surface.DrawText(text)
end
function Texts(x, y, xalign, yalign, texts)
    xalign = xalign or TEXT_ALIGN_LEFT
	yalign = yalign or TEXT_ALIGN_TOP
    local text = ""
    local w, h = 0, 0
    for k, v in pairs(texts) do
        text = text..v.text
        local w2, h2 = GetTextSize(v.text, v.font)
        w = w + w2

        if h2 > h then
            h = h2 
        end
    end

	if ( xalign == TEXT_ALIGN_CENTER ) then
		x = x - w / 2
	elseif ( xalign == TEXT_ALIGN_RIGHT ) then
		x = x - w
	end
	if ( yalign == TEXT_ALIGN_CENTER ) then
		y = y - h / 2
	elseif ( yalign == TEXT_ALIGN_BOTTOM ) then
		y = y - h
	end

    for k, v in pairs(texts) do
        Text(v.text, v.font, x, y, v.color, xalign, yalign)

        x = x + GetTextSize(v.text, v.font)
    end
end