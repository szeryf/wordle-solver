# How to ruin your wordle experience with Ruby

Table of contents:
- [Wordle solver](#wordle-solver)
- [Quordle solver](#quordle-solver)


## Wordle solver

The [wordle.rb](wordle.rb) is a simple helper script for the [Wordle puzzle](https://www.nytimes.com/games/wordle/index.html).

When run without arguments, it prints top 10 words based on letter frequencies, which are all good starting words (I usually start with “later”).

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

Caveat: it doesn't work that well with words that have repeated letters. Due to how the word score is calculated, the script has a bias towards words consisting of 5 unique letters (otherwise the list of suggestions is dominated with words like `eerie` or `rarer`).

Here's an example from 2025-06-16:
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

## Quordle solver

The [quordle.rb](quordle.rb) is a simple helper script for the [Quordle puzzle](https://quordlegame.com/). 

Run it without arguments to see some good starting words:
```
╰─$ ruby quordle.rb 
arose = 7.977414421832726
orate = 7.97694388895424
serai = 7.873426655687566
arise = 7.873426655687566
raise = 7.873426655687566
retia = 7.872956122809081
irate = 7.872956122809081
arite = 7.872956122809081
tarie = 7.872956122809081
ariel = 7.867309728267263
```

After entering the starting word, you'll see something like this:

<img width="556" alt="image" src="https://github.com/user-attachments/assets/da972ac6-7055-487e-8b75-7b1ae8ae8655" />

These results need to be encoded in a similar way as with `wordle.rb`, one codeword for each diagram separated by commas: `arose=ybbbb,bybby,bbggb,bgbgy`. Based on that, `quordle.rb` lists words that may be good to try next: 
```
╰─$ ruby quordle.rb arose=ybbbb,bybby,bbggb,bgbgy
0: arose => 826 matches 
1: arose => 343 matches 
2: arose => 22 matches 
3: arose => 10 matches 
crest = 1361.2
drest = 1346.3
prest = 1335.8
wrest = 1275.0
trest = 1206.4
tress = 1206.4
fresh = 1166.6
cress = 1123.0
dress = 1108.1
press = 1097.6
```

The first part shows how many words match for each of the diagrams (we can see that the last one has only 10 matches already!) and top 10 words for next guess, based on their score and how many matches there are (the less the better). 

Trying `crest` gives us the first solution!

<img width="546" alt="image" src="https://github.com/user-attachments/assets/b510661e-1bdf-4438-b654-5060e9101f12" />

After each solved word, it's important to not use its hints anymore in order to not affect the scores for other diagrams. Notice that we are now using three "codewords" per word:

```
╰─$ ruby quordle.rb arose=ybbbb,bybby,bbggb crest=gbbbb,bygbb,bbbgb
0: arose => 826 matches 
1: arose => 343 matches 
2: arose => 22 matches 
0: crest => 75 matches 
1: crest => 25 matches 
2: crest => 13 matches 
klosh = 750.9230769230769
knosp = 736.7692307692307
flosh = 733.7692307692307
slosh = 682.9230769230769
gloss = 665.9230769230769
kiosk = 665.3846153846154
floss = 632.0
boosy = 611.7692307692307
goosy = 607.0769230769231
sposh = 600.1538461538462
```

So, after `arose` and `crest`, we only have 13 possible matches on the third diagram. I tried `gloss` next but it doesn't look like it was a very good guess:

<img width="543" alt="image" src="https://github.com/user-attachments/assets/d64d26cd-73d2-46fc-ae03-351c9e33e8d6" />

Nevertheless, let's try to encode the results we got:
```
╰─$ ruby quordle.rb arose=ybbbb,bybby,bbggb crest=gbbbb,bygbb,bbbgb gloss=bybbb,bbbbb,bbggb
0: arose => 826 matches 
1: arose => 343 matches 
2: arose => 22 matches 
0: crest => 75 matches 
1: crest => 25 matches 
2: crest => 13 matches 
0: gloss => 17 matches 
1: gloss => 21 matches 
2: gloss => 0 matches ()
```

This doesn't look good – we don't have any matches for the last diagram! The problem is that our codeword is contradictory: we have `g` for the first letter `S` and then `b` for the final letter `s` and `b` will basically cause the removal of all words containing an `s`. In this case, we need to encode the final `s` as `y` (it's in the word, but not at this spot). 

```
╰─$ ruby quordle.rb arose=ybbbb,bybby,bbggb crest=gbbbb,bygbb,bbbgb gloss=bybbb,bbbbb,bbggy
0: arose => 826 matches 
1: arose => 343 matches 
2: arose => 22 matches 
0: crest => 75 matches 
1: crest => 25 matches 
2: crest => 13 matches 
0: gloss => 17 matches 
1: gloss => 21 matches 
2: gloss => 7 matches (boosy, hoosh, kiosk, knosp, sposh, swosh, woosh)
knosp = 1368.2857142857142
kiosk = 1235.7142857142858
boosy = 1136.142857142857
sposh = 1114.5714285714287
woosh = 1027.7142857142858
swosh = 1027.7142857142858
hoosh = 929.7142857142857
calid = 727.5294117647059
cauld = 686.5294117647059
cumal = 680.8235294117648
```

Entering `kiosk` gives us another solution:

<img width="540" alt="image" src="https://github.com/user-attachments/assets/c0101173-9fb3-473f-b565-a5db0c16f73b" />

As before, now we need to remove the codewords for this diagram from the params (`kiosk` encoded as `ybbbg` not `bbbbg` for the first diagram, see the example above):

```
╰─$ ruby quordle.rb arose=ybbbb,bybby crest=gbbbb,bygbb gloss=bybbb,bbbbb kiosk=ybbbg,bbbbb
0: arose => 826 matches 
1: arose => 343 matches 
0: crest => 75 matches 
1: crest => 25 matches 
0: gloss => 17 matches 
1: gloss => 21 matches 
0: kiosk => 2 matches (chalk, caulk)
1: kiosk => 16 matches 
caulk = 5578.0
chalk = 5297.5
rheum = 738.0
quern = 717.625
query = 679.5
rheen = 677.3125
reedy = 643.9375
emery = 637.875
peery = 637.375
beery = 629.1875
```

`chalk` is the next solution! Yay, 3 out of 4 already! Also, you may have noticed that I don't always pick the top word from the list, but sometimes use the one that sounds more "casual" if they have a similar score.

<img width="538" alt="image" src="https://github.com/user-attachments/assets/b89f8b89-c7c0-4f48-aeee-f6ed68606aa1" />

OK, after removing the codewords for the first diagram, let's focus on the final word, which seems to have been a bit neglected until now... 

```
╰─$ ruby quordle.rb arose=bybby crest=bygbb gloss=bbbbb kiosk=bbbbb chalk=bbbbb            
0: arose => 343 matches 
0: crest => 25 matches 
0: gloss => 21 matches 
0: kiosk => 16 matches 
0: chalk => 13 matches 
quern = 883.2307692307693
query = 836.3076923076923
reedy = 792.5384615384615
emery = 785.0769230769231
peery = 784.4615384615385
beery = 774.3846153846154
ewery = 737.6923076923077
reefy = 735.7692307692307
veery = 720.7692307692307
every = 720.7692307692307
```

There's still 13 possible matches in the dictionary (we only have `e` in the third position and `r` somewhere), let's try `query`...

<img width="544" alt="image" src="https://github.com/user-attachments/assets/6eb2133e-98a7-4d99-97e2-0cc9283a9b43" />

Solved!
