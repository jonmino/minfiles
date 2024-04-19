#!/bin/zsh

if [ ! "$1" ]; then
cat << EOF
1 2 3a La/Ac                      4a5a6a7a8a8a8a1a2a3 4 5 6 7 8
H                                                             He
LiBe                                                B C N O F Ne
NaMg                                                AlSiP S ClAr
K CaSc                            TiV CrMnFeCoNiCuZnGaGeAsSeBrKr
RbSrY                             ZrNbMoTcRuRhPdAgCdInSnSbTeI Xe
CsBaLaCePrNdPmSmEuGdTbDyHoErTmYbLuHfTaW ReOsIrPtAuHgTlPbBiPoAtRn
FrRaAcThPaU NpPuAmCmBkCfEsFmMdNoLr

usage: pse [nuclear charge | element name | element symbol ]
EOF
exit
fi

for pattern in $@; do
rg -i " $pattern " << EOF
  1 Hydrogen     Wasserstoff   H   1s1
  2 Helium                     He  1s2
  3 Lithium                    Li  [He] 2s1
  4 Beryllium                  Be  [He] 2s2
  5 Bor                        B   [He] 2s2 2p1
  6 Carbon       Kohlenstoff   C   [He] 2s2 2p2
  7 Nitrogen     Stickstoff    N   [He] 2s2 2p3
  8 Oxygen       Sauerstoff    O   [He] 2s2 2p4
  9 Fluorine     Fluor         F   [He] 2s2 2p5
 10 Neon                       Ne  [He] 2s2 2p6
 11 Sodium       Natrium       Na  [Ne] 3s1
 12 Magnesium                  Mg  [Ne] 3s2
 13 Aluminium                  Al  [Ne] 3s2 3p1
 14 Silicon      Silizium      Si  [Ne] 3s2 3p2 
 15 Phosphorus   Phosphor      P   [Ne] 3s2 3p3
 16 Sulfur       Schwefel      S   [Ne] 3s2 3p4
 17 Chlorine     Chlor         Cl  [Ne] 3s2 3p5
 18 Argon                      Ar  [Ne] 3s2 3p6
 19 Potassium    Kalium        K   [Ar]      4s1
 20 Calcium      Kalzium       Ca  [Ar]      4s2
 21 Scandium                   Sc  [Ar] 3d1  4s2 
 22 Titanium     Titan         Ti  [Ar] 3d2  4s2
 23 Vanadium                   V   [Ar] 3d3  4s2
 24 Chromium     Chrom         Cr  [Ar] 3d5  4s1
 25 Manganese    Mangan        Mn  [Ar] 3d5  4s2
 26 Iron         Eisen         Fe  [Ar] 3d6  4s2
 27 Cobalt                     Co  [Ar] 3d7  4s2
 28 Nickel                     Ni  [Ar] 3d8  4s2
 29 Copper       Kupfer        Cu  [Ar] 3d10 4s1
 30 Zinc         Zink          Zn  [Ar] 3d10 4s2
 31 Gallium                    Ga  [Ar] 3d10 4s2 4p1
 32 Germanium                  Ge  [Ar] 3d10 4s2 4p2
 33 Arsenic      Arsen         As  [Ar] 3d10 4s2 4p3
 34 Selenium     Selen         Se  [Ar] 3d10 4s2 4p4
 35 Bromine      Brom          Br  [Ar] 3d10 4s2 4p5
 36 Krypton                    Kr  [Ar] 3d10 4s2 4p6
 37 Rubidium                   Rb  [Kr]      5s1
 38 Strontium                  Sr  [Kr]      5s2
 39 Yttrium                    Y   [Kr] 4d1  5s2
 40 Zirconium                  Zr  [Kr] 4d2  5s2
 41 Niobium      Niob          Nb  [Kr] 4d4  5s1
 42 Molybdenum   Molybdaen     Mo  [Kr] 4d5  5s1
 43 Technetium                 Tc  [Kr] 4d5  5s2
 44 Ruthenium                  Ru  [Kr] 4d7  5s1
 45 Rhodium                    Rh  [Kr] 4d8  5s1
 46 Palladium                  Pd  [Kr] 4d10 
 47 Silver       Silber        Ag  [Kr] 4d10 5s1
 48 Cadmium                    Cd  [Kr] 4d10 5s2
 49 Indium                     In  [Kr] 4d10 5s2 5p1
 50 Tin          Zinn          Sn  [Kr] 4d10 5s2 5p2
 51 Antimony     Antimon       Sb  [Kr] 4d10 5s2 5p3
 52 Tellurium    Tellur        Te  [Kr] 4d10 5s2 5p4
 53 Iodine       Iod           I   [Kr] 4d10 5s2 5p5
 54 Xenon                      Xe  [Kr] 4d10 5s2 5p6
 55 Cesium       Caesium       Cs  [Xe]           6s1
 56 Barium                     Ba  [Xe]           6s2
 57 Lanthanum    Lanthan       La  [Xe]      5d1  6s2
 58 Cerium       Cer           Ce  [Xe] 4f2       6s2
 59 Praseodynium Praseodym     Pr  [Xe] 4f3       6s2
 60 Neodynium    Neodym        Nd  [Xe] 4f4       6s2
 61 Promethium                 Pm  [Xe] 4f5       6s2
 62 Samarium                   Sm  [Xe] 4f6       6s2
 63 Europium                   Eu  [Xe] 4f7       6s2
 64 Gadolinium                 Gd  [Xe] 4f7  5d1  6s2
 65 Terbium                    Tb  [Xe] 4f9       6s2
 66 Dysprosium                 Dy  [Xe] 4f10      6s2
 67 Holmium                    Ho  [Xe] 4f11      6s2
 68 Erbium                     Er  [Xe] 4f12      6s2
 69 Thullium                   Tm  [Xe] 4f13      6s2
 70 Ytterbium                  Yb  [Xe] 4f14      6s2
 71 Lutetium                   Lu  [Xe] 4f14 5d1  6s2
 72 Hafnium                    Hf  [Xe] 4f14 5d2  6s2
 73 Tantalum     Tantal        Ta  [Xe] 4f14 5d3  6s2
 74 Tungsten     Wolfram       W   [Xe] 4f14 5d4  6s2
 75 Rhenium                    Re  [Xe] 4f14 5d5  6s2
 76 Osmium                     Os  [Xe] 4f14 5d6  6s2
 77 Iridium                    Ir  [Xe] 4f14 5d7  6s2
 78 Platinum     Platin        Pt  [Xe] 4f14 5d9  6s1
 79 Gold                       Au  [Xe] 4f14 5d10 6s1
 80 Mercury      Quecksilber   Hg  [Xe] 4f14 5d10 6s2
 81 Thallium                   Tl  [Xe] 4f14 5d2  6s2 6p1
 82 Lead         Blei          Pb  [Xe] 4f14 5d2  6s2 6p2
 83 Bismuth                    Bi  [Xe] 4f14 5d2  6s2 6p3
 84 Polonium                   Po  [Xe] 4f14 5d2  6s2 6p4
 85 Astatine     Astat         At  [Xe] 4f14 5d2  6s2 6p5
 86 Radon                      Rn  [Xe] 4f14 5d2  6s2 6p6
 87 Francium                   Fr  [Rn]           7s1
 88 Radium                     Ra  [Rn]           7s2
 89 Actinium                   Ac  [Rn]      6d1  7s2
 90 Thorium                    Th  [Rn]      6d2  7s2
 91 Protactinium               Pa  [Rn] 5f2  6d1  7s2
 92 Uranium      Uran          U   [Rn] 5f3  6d1  7s2
 93 Neptunium                  Np  [Rn] 5f4  6d1  7s2
 94 Plutonium                  Pu  [Rn] 5f5  6d1  7s2
 95 Americium                  Am  [Rn] 5f7       7s2
 96 Curium                     Cm  [Rn] 5f7  6d1  7s2
 97 Berkelium                  Bk  [Rn] 5f8  6d1  7s2
 98 Californium                Cf  [Rn] 5f9  6d1  7s2
 99 Einsteinium                Es  [Rn] 5f10 6d1  7s2
100 Fermium                    Fm  [Rn] 5f11 6d1  7s2
101 Mendelevium                Md  [Rn] 5f12 6d1  7s2
102 Nobelium                   No  [Rn] 5f13 6d1  7s2
103 Lawrencium                 Lr  [Rn] 5f14 6d1  7s2
EOF
done
