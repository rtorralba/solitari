# Introduction
Code developed when I was a student (1999 - 2000). Is a pseudo solitarie game to practice with pascal data structures.

## How to run

### Docker and Makefile

```bash
make up
make compile
make run
make stop
```

### Free Pascal Compiler (fpc)

```bash
fpc PRINCIPA.PAS
./PRINCIPA
```

## How to play

Press enter to show the next card and move to a free position or on suit pile (oros, copes, espases, bastos).

The suit plies are in the center of the screen.

If there are no free postions and can't put the card on the suit pile (because are not the following) then game over.

## Curiosities

The files names has only 8 characters because was a file system restriction.
The variables, procedure names, etc... Are in catalan language.