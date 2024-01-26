rem
rem PLEASE READ README.md
rem

set GIF_PALETTE=split [gif0][gif1]; [gif0] palettegen=reserve_transparent=on:transparency_color=99ff00 [gifp]; [gif1][gifp] paletteuse
set TRANSPARENTBG=-f lavfi -i "color=0x00000000:s=112x112,format=rgba"
set INFILE=monnSALTY.png

ffmpeg ^
-t 2 -r 30 -loop 1 -i %INFILE% ^
-filter_complex "hue=H=t*PI, %GIF_PALETTE%" ^
-y hue-rotate.gif

ffmpeg ^
-t 2 -r 30 %TRANSPARENTBG% ^
-t 2 -r 30 -loop 1 -i %INFILE% ^
-filter_complex "[0][1] overlay=x='-w+sin(t*PI/2)*112':y=0, %GIF_PALETTE%" ^
-y slide-in-sin.gif

ffmpeg ^
-t 2 %TRANSPARENTBG% ^
-t 2 -r 30 -loop 1 -i %INFILE% ^
-filter_complex "[0][1] overlay=x='-w+ 112* (1-pow(1-t,3))':y=0,%GIF_PALETTE%" ^
-y slide-in-cubic.gif

ffmpeg ^
-t 2 %TRANSPARENTBG% ^
-t 2 -r 30 -loop 1 -i %INFILE% ^
-filter_complex "[0][1] overlay=x='min(0, -w+ 112* (1-pow(1-t,3)))':y=0,%GIF_PALETTE%" ^
-y slide-in-cubic-pause.gif

ffmpeg ^
-t 2 %TRANSPARENTBG% ^
-t 2 -r 30 -loop 1 -i %INFILE% ^
-filter_complex "[0][1] overlay=x='max(0, -w+ 112* (1-pow(1-t,3)))':y=0,%GIF_PALETTE%" ^
-y slide-out-cubic-pause.gif

ffmpeg ^
-t 0.5 -r 30 %TRANSPARENTBG% ^
-t 0.5 -r 30 -loop 1 -i %INFILE% ^
-t 0.5 -r 30 -loop 1 -i %INFILE% ^
-filter_complex "[0][1] overlay=x='-w+t*2*112':y=0 [working], [working][2] overlay=x='t*2*112':y=0, %GIF_PALETTE%" ^
-y rushing-past.gif

dir *.gif