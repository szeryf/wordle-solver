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
<img width="508" alt="Screenshot 2025-04-18 at 15 23 36" src="https://github.com/user-attachments/assets/6a9e9689-27b7-4f04-b233-4679494b65d8" />

Caveat: it doesn't work that well with words that have repeated letters. Due to how the word score is calculated, the script has a bias towards words consisting of 5 unique letters. Here's an example from 2025-06-16:
```
╰─$ ruby wordle.rb later=bbgyb
later => 11 matches

untie = 3668
cutie = 3570
setup = 3458
fetus = 3322
fetid = 3251
detox = 3142
fetch = 3050
tithe = 3016
petty = 2748
butte = 2705

╰─$ ruby wordle.rb later=bbgyb untie=bbgby
later => 11 matches
untie => 4 matches

detox = 3142
fetch = 3050
petty = 2748
jetty = 2410

╰─$ ruby wordle.rb later=bbgyb untie=bbgby detox=bggbb
later => 11 matches
untie => 4 matches
detox => 3 matches

fetch = 3050
petty = 2748
jetty = 2410

╰─$ ruby wordle.rb later=bbgyb untie=bbgby detox=bggbb fetch=bggbb
later => 11 matches
untie => 4 matches
detox => 3 matches
fetch => 2 matches

petty = 2748
jetty = 2410
```

The correct solution was found in 5 steps:

<img width="501" alt="image" src="https://github.com/user-attachments/assets/caeb7209-af8a-485f-a5b3-e9a0bc7aa66e" />
