animated emotes without crappy backgrounds

# what need
- windows
- ffmpeg

most probably not have ffmpeg. install [scoop.sh](https://scoop.sh) and cast spell `scoop install ffmpeg` at command prompt. scoop very good for install many useful program.

if not like scoop, can get [ffmpeg windows build](https://www.gyan.dev/ffmpeg/builds/) and put `ffmpeg.exe` in folder with `run.cmd`.

# how run
- launch `run.cmd` to make a bunch of gif files
- open `gallery.html` in a browser to see them with pink behind, see no ugly background problems

# time to learn
open `run.cmd` in notepad, or view on github

## first important!
see `^` end of lines? 
```cmd
ffmpeg ^
more command stuff ^
final line
```
mean "don't run command yet! more to say!". spell easier to read, write, and explain when in small parts.

## second important!
see `set` lines at top?
```cmd
set UNHOLY_WORDS=loremipsum--DOLORSit
set SUMM_CIRCLE=^_#8485#_%980343
set INFILE=monnLOVE.png
```
these shortcuts for say thing often, not repeat self.
two reasons:
- want copy paste complex common spell part
- want quick change common spell part

will explain unholy incantation part later chapter.

## rest important too

each spell start with `ffmpeg`, invoke name of demon for make video work.

next lines of spell speak name of sacrifices to `ffmpeg` demon:
```cmd
ffmpeg ^
-t 2 %TRANSPARENTBG% ^
-t 2 -r 30 -loop 1 -i %INFILE% ^
```
first sacrifice `%TRANSPARENTBG%` (from `set`!)...
fake image, completely transparent, 112x112 size.
`-t 2` mean "this video 2 seconds long".

second sacrifice `%INFILE%` (from `set`!)...
`monnLOVE.png` right now. this emote we want to animate.
- `-t 2` "this video 2 seconds long".
- `-r 30` "this video 30 frames per second".
- `-loop 1` "play this video once" (probably not needed?).
- `-i` "the inputs filename is..."

maybe one sacrifice, maybe many. depends on desired effect.

next line truly unholy:
```cmd
-filter_complex "[0][1] overlay=x='-w+sin(t*PI/2)*112':y=0, %GIF_PALETTE%" ^
```

`-filter_complex` dark soul of `ffmpeg`, menagerie of filter beasts, useful for animation and processing. need not approach right now, read chapter later.

final line a short prayer:
```
-y slide-in-sin.gif
```
`-y` YES i want to overwrite the file if it exists.
`slide-in-sin.gif` the file to write.

# font of knowledge
not born knowing how to inscribe summoning circle. learn as needed.

[ffmpeg.html](https://ffmpeg.org/ffmpeg.html) and [ffmpeg-filters.html](https://ffmpeg.org/ffmpeg-filters.html) official ffmpeg documentation. like reading a dictionary. useful for examples of filters, description of options.

[google](https://google.com) often good results with `ffmpeg` keyword

# -filter_complex aka the chains
take moment to light candle, sprinkle salt circle around computer chair.

and breathe.

look upon the caged beast (with `%GIF_PALETTE%` substituted for full horror):
```
[0][1] overlay=x='-w+sin(t*PI/2)*112':y=0, split [gif0][gif1];

[gif0] palettegen=reserve_transparent=on:transparency_color=99ff00 [gifp];

[gif1][gifp] paletteuse
```
semicolon `;` divide this into "chains", and comma `,` divide chain into "filters". finally, `[label]` at ends of chains link to other chains.

chain 1 has two filters: `overlay` and `split`, with two inputs `[0][1]` - our sacrifices. `[0][1]overlay` demand for join these sacrifices, with second sacrifice on top (not important detail right now). demand the second image to be placed at `x=0:y=0`... turn head and ignore unholy math for the moment. then make 2 copies, call them `[gif0]` and `[gif1]`.

chain 2 send `[gif0]` to `palettegen` filter... simple beast finds popular colors in image, for make transparent gif work. details unimportant, send to `[gifp]`.

chain 3: take `[gif1]` and `[gifp]`, another simple beast `paletteuse` for make transparent gif work. output is transparent image!

everything `split` and after is for make gif good: always same, so `set` in `%GIF_PALETTE%` and reuse.

# unholy math

```
overlay=x='-w+sin(t*PI/2)*112':y=0
```
this how image moves across screen... `x=` calculated every frame, different every frame, makes movement.

```
x='
  -w +
    sin(
      t*PI/2
    ) * 112
'
```
this spell earned by trial and error and google search.
`-w` mean `-112` so all the way off screen left side.
`sin(anything)` will always be number from 0 to 1.
`* 112` multiply sin to move image more.
`t` inside sin is "time elapsed in seconds", from 0 onwards.

`t` goes up, `x` goes up, image moves across.
experiment for new results.

name of unholy spell ["easing functions"](https://easings.net/).
scary beast become less scary with name.