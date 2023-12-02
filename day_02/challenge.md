# Challenge - Day 2

## Part 1

Each game is listed with its ID number followed by a semicolon-separated list of
subsets of cubes that were revealed from the bag (like 3 red, 5 green, 4 blue).

For example, the record of a few games might look like this:

```
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
```

In game 1, three sets of cubes are revealed from the bag. The first set 
is 3 blue cubes and 4 red cubes; the second set is 1 red cube, 2 green cubes, 
and 6 blue cubes; the third set is only 2 green cubes.

Which games would have been possible if the bag contained only: 12 red cubes, 
13 green cubes, and 14 blue cubes?

In the example above, games 1, 2, and 5 would have been possible if the bag had 
been loaded with that configuration. However, game 3 would have been impossible.
If you add up the IDs of the games that would have been possible, you get 8.

What is the sum of the IDs of all the possible games?

## Part 2

In each game you played, what is the fewest number of cubes of each color that
could have been in the bag to make the game possible?

Again consider the example games from earlier:

```
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
```

In game 1, the game could have been played with as few as 4 red, 2 green, and 
6 blue cubes.

The power of a set of cubes is equal to the numbers of red, green, and blue 
cubes multiplied together. The power of the minimum set of cubes in 
game 1 is 48. In games 2-5 it was 12, 1560, 630, and 36, respectively. Adding up
these five powers produces the sum 2286.

For each game, find the minimum set of cubes that must have been present. What 
is the sum of the power of these sets?
