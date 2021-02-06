## DrawLib wiki
All example can be used in your script.
### Function
#### Color
All color parameters use the `SetColor()`. You can just use the `Color()` function of gmod or put a string correspond to a color name in the config file.
#### Box and Rounded box
They function draw a box, `Box(x, y, width, height, color)` or a rounded box, `RoundedBox(cornerRadius, x, y, width, height, color)`.
#### Box border and Rounded box border
They function draw a box with border, `BoxBorder(x, y, width, height, color, borderRadius, borderColor)` or a rounded box with border, `RoundedBoxBorder(cornerRaduis, x, y, width, height, color, borderRadius, borderColor)`.
#### Outline box
They function draw a outline box, `OutlineBox(x, y, width, height, color, borderRadius)`.
#### Image and RotatedImage
They function draw an image, `Image(x, y, width, height, material, color)` or a image with rotation `ImageRotated(x, y, width, height, rotation, material, color)`.
#### Text functions
With they function, you can get a text size in function of the font `GetTextSize(text, font)` and draw a text `Text(text, font, x, y, color, xalign, yalign)`. See [gmod text align wiki](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN) for xalign and yalign.
Example :
```lua
DrawLib.Text("Test", "DL25", 0, 0, DrawLib.SetColor("white"), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT)
```
You can also draw a text with different color, `Texts(x, y, xalign, yalign, texts)`. For example, you draw `DrawLib` with Draw in white and Lib in blue. The `texts` variable is a table. Elements of him table must have `text` : the text part you want to draw, `color` : the color of this part and `font` : the font of this part. All elements corresponds to the text you want to draw.
Example :
```lua
DrawLib.Texts(0, 0, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, {
    {text = "Draw", color = "white", font = "ZL25"},
    {text = "Lib", color = Color(0, 0, 255, 255), font = "ZL25"}
})
```
### Config
#### Create font
For create a font usable with texts drawing function, put an element in the list called `fonts`. Any element must have a name : for calling and a config : for size, weight and more. See [gmod font wiki](https://wiki.facepunch.com/gmod/Structures/FontData) for the config. Here, mandatories parameters. For load them call `LoadFont()` function only in client.
_Tip for name : `name = [Your project initials][Font size]`._
Example :
```lua
{name = "DL25", config = {font = "Arial", size = 25}}
```
#### Add a color
For add a color usable in color parameter of functions, put an element in the list called `colors`. Any element must have a name, for calling and a red, green, blue, alpha value.
Example :
```lua
{name = "white", r = 255, g = 255, b = 255, a = 255}
```