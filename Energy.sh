#!/bin/bash

echo 1 | g_energy -f *.edr -o bond.xvg
echo 2 | g_energy -f *.edr -o angle.xvg
echo 3 | g_energy -f *.edr -o dihed.xvg
echo 4 | g_energy -f *.edr -o LJ14.xvg
