# How to ruin your wordle experience with Ruby

When run without arguments, it will output top 10 words based on letter frequencies, which are all good starting words (I usually start with “later”).

```
╰─$ ruby wordle.rb

later = 4547
alert = 4547
alter = 4547
arose = 4523
irate = 4501
stare = 4499
arise = 4440
raise = 4440
learn = 4391
renal = 4391
```

After inputting your word at wordle, it will give you color-based feedback:
- 🟩 green for correct letter and spot,
- 🟨 yellow for correct letter but wrong spot,
- ⬜️ grey otherwise (the letter does not appear in the word).

You can then use it as an argument for the script to get a better word to try next. The arguments need to be formatted like this: `snore=bbbyg` (`g` for green, `y` for yellow, `b` for ~~black~~ grey).

The picture below shows how the script helped me to solve the wordle puzzle for 2025-04-18 in four attempts. The final word was found after running:

```
╰─$ ruby wordle.rb later=bbbyy
later => 99 matches

snore = 4121
rinse = 4038
resin = 4038
score = 4023
rouse = 4014
horse = 3935
shore = 3935
crone = 3928
spore = 3913
prose = 3913

╰─$ ruby wordle.rb later=bbbyy snore=bbbyg
later => 99 matches
snore => 24 matches

price = 3637
crime = 3588
pride = 3555
ridge = 3500
dirge = 3500
prime = 3478
gripe = 3472
bride = 3470
crude = 3461
grime = 3423

╰─$ ruby wordle.rb later=bbbyy snore=bbbyg price=byybg
later => 99 matches
snore => 24 matches
price => 3 matches

ridge = 3500
dirge = 3500
eerie = 2797
```

