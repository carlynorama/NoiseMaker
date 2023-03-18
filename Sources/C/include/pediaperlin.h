//
//  pediaperlin.h
//  NoiseExplorer
//
//  Created by Carlyn Maw on 3/12/23.
//  from code found on https://en.wikipedia.org/wiki/Perlin_noise

#ifndef pediaperlin_h
#define pediaperlin_h

#include <stdio.h>

typedef struct {
    float x, y;
} vector2;

float interpolate(float, float, float);
vector2 randomGradient(int, int);
float dotGridGradient(int, int, float, float);
float perlin(float, float);

#endif /* pediaperlin_h */
