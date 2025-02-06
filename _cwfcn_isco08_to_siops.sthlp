{smcl}
{* version 1.0.0  29jan2025  Ben Jann}{...}
{hi:isco08_to_siops()} {hline 2} Translate 4-digit ISCO-08 to SIOPS scores

{title:Syntax}

        {cmd:isco08_to_siops(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 4-digit ISCO-08 codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 4-digit ISCO-08 codes to SIOPS scores
    (Standard International Occupational Prestige Scale; Treiman 1977).

{title:Source}

{pstd}
    SPSS script {cmd:isqotrei08.sps} provided by Harry Ganzeboom at
    {browse "http://www.harryganzeboom.nl/isco08/"}. Leading zeros have been
    added to ISCO-08 codes with less than 4 digits.

{title:References}

{phang}
    Treiman, D.J. 1977. Occupational Prestige in Comparative Perspective. New
    York: Academic Press.
    {p_end}
{hline}
{asis}
0000 42.88
0100 48.68
0110 48.68
0200 39.00
0210 39.00
0300 43.23
0310 43.23
1000 48.87
1100 64.92
1110 65.38
1111 64.00
1112 66.84
1113 42.00
1114 54.88
1120 64.51
1200 56.60
1210 53.28
1211 49.00
1212 58.00
1213 53.28
1219 53.28
1220 54.61
1221 52.00
1222 52.36
1223 52.36
1300 61.15
1310 61.15
1311 61.15
1312 61.15
1320 60.67
1321 64.00
1322 60.67
1323 53.00
1324 57.21
1330 61.15
1340 73.51
1341 73.51
1342 73.51
1343 73.51
1344 73.51
1345 72.00
1346 73.51
1349 75.00
1400 44.83
1410 39.28
1411 37.52
1412 39.91
1420 45.13
1430 47.00
1431 47.00
1439 47.00
2000 62.42
2100 63.15
2110 69.75
2111 75.68
2112 69.51
2113 69.00
2114 67.00
2120 58.16
2130 62.66
2131 62.66
2132 62.66
2133 62.66
2140 61.39
2141 54.00
2142 70.00
2143 61.69
2144 66.00
2145 66.00
2146 61.16
2149 55.00
2150 65.00
2151 65.00
2152 65.00
2153 65.00
2160 66.52
2161 63.19
2162 63.19
2163 63.19
2164 63.19
2165 58.00
2166 63.19
2200 69.03
2210 78.01
2211 78.01
2212 78.01
2220 53.82
2221 54.05
2222 46.00
2230 69.03
2240 69.03
2250 61.00
2260 65.80
2261 70.00
2262 64.00
2263 65.80
2264 56.21
2265 52.00
2266 65.80
2267 60.15
2269 65.80
2300 63.18
2310 78.16
2320 57.00
2330 62.63
2340 56.97
2341 57.00
2342 49.00
2350 62.15
2351 62.28
2352 62.00
2353 62.28
2354 62.28
2355 62.28
2356 62.28
2359 68.00
2400 57.18
2410 58.45
2411 58.45
2412 58.45
2413 58.45
2420 55.80
2421 55.80
2422 55.80
2423 55.80
2424 55.80
2430 50.09
2431 50.09
2432 57.00
2433 48.37
2434 50.09
2500 51.00
2510 51.00
2511 51.00
2512 51.00
2513 51.00
2514 51.00
2519 51.00
2520 51.00
2521 51.00
2522 51.00
2523 51.00
2529 51.00
2600 59.97
2610 73.14
2611 73.10
2612 76.11
2619 69.40
2620 54.00
2621 54.00
2622 54.00
2630 56.30
2631 60.00
2632 68.51
2633 56.30
2634 66.00
2635 53.89
2636 54.00
2640 57.40
2641 56.92
2642 62.99
2643 65.66
2650 52.40
2651 57.00
2652 46.09
2653 40.00
2654 66.78
2655 56.79
2656 50.00
2659 33.00
3000 48.11
3100 46.74
3110 49.72
3111 46.00
3112 52.72
3113 46.00
3114 49.65
3115 46.00
3116 46.00
3117 54.00
3118 55.00
3119 46.00
3120 45.94
3121 45.94
3122 45.94
3123 45.94
3130 34.91
3131 34.76
3132 34.91
3133 34.91
3134 43.00
3135 34.91
3139 34.91
3140 49.00
3141 52.00
3142 48.57
3143 49.00
3150 59.00
3151 60.00
3152 55.44
3153 66.00
3154 59.00
3155 59.00
3200 50.27
3210 55.90
3211 58.00
3212 54.58
3213 44.00
3214 60.00
3220 44.00
3221 44.00
3222 44.00
3230 50.27
3240 48.00
3250 49.87
3251 49.87
3252 49.87
3253 49.87
3254 57.00
3255 49.87
3256 50.00
3257 48.00
3258 49.87
3259 49.89
3300 48.81
3310 45.93
3311 56.00
3312 45.93
3313 43.81
3314 51.00
3315 48.97
3320 47.20
3321 46.00
3322 47.00
3323 48.86
3324 55.00
3330 47.61
3331 47.61
3332 47.61
3333 47.61
3334 49.00
3339 42.15
3340 48.81
3341 48.81
3342 48.81
3343 48.81
3344 48.81
3350 54.81
3351 54.64
3352 52.00
3353 54.64
3354 54.64
3355 54.64
3359 54.64
3400 50.11
3410 49.84
3411 54.17
3412 49.00
3413 39.00
3420 49.63
3421 48.62
3422 50.00
3423 49.63
3430 50.38
3431 45.69
3432 38.00
3433 50.38
3434 38.00
3435 54.59
3500 47.24
3510 53.00
3511 53.00
3512 53.00
3513 53.00
3514 53.00
3520 44.87
3521 44.87
3522 44.87
4000 38.54
4100 41.81
4110 42.09
4120 50.87
4130 44.16
4131 42.00
4132 45.00
4200 38.19
4210 38.53
4211 40.28
4212 38.53
4213 38.53
4214 27.00
4220 37.83
4221 43.00
4222 37.83
4223 42.15
4224 33.00
4225 37.83
4226 34.24
4227 37.83
4229 37.83
4300 32.37
4310 34.00
4311 34.00
4312 34.00
4313 34.00
4320 31.89
4321 30.28
4322 44.00
4323 32.49
4400 34.44
4410 34.44
4411 36.00
4412 30.05
4413 41.00
4414 34.44
4415 31.00
4416 34.44
4419 37.00
5000 35.11
5100 25.92
5110 31.07
5111 50.00
5112 30.93
5113 31.07
5120 30.98
5130 22.11
5131 21.67
5132 23.00
5140 32.00
5141 32.00
5142 32.00
5150 24.00
5151 37.03
5152 24.00
5153 23.27
5160 22.90
5161 22.90
5162 17.00
5163 34.00
5164 22.90
5165 41.00
5169 22.90
5200 36.95
5210 36.69
5211 36.69
5212 36.69
5220 38.84
5221 48.00
5222 42.78
5223 42.78
5230 32.16
5240 24.09
5241 24.09
5242 24.09
5243 24.00
5244 26.00
5245 25.00
5246 16.00
5249 24.09
5300 30.21
5310 47.66
5311 23.00
5312 50.00
5320 29.00
5321 29.00
5322 29.00
5329 29.00
5400 33.71
5410 33.80
5411 35.00
5412 40.89
5413 39.00
5414 27.89
5419 33.71
6000 42.02
6100 43.53
6110 43.53
6111 43.53
6112 43.53
6113 43.53
6114 43.53
6120 43.53
6121 43.53
6122 43.53
6123 43.53
6129 43.53
6130 43.53
6200 26.11
6210 22.69
6220 27.24
6221 27.24
6222 27.24
6223 27.24
6224 27.24
6300  5.00
6310  5.00
6320  5.00
6330  5.00
6340  5.00
7000 37.00
7100 33.06
7110 34.10
7111 34.10
7112 34.00
7113 38.00
7114 34.00
7115 36.76
7119 29.83
7120 32.27
7121 31.00
7122 32.27
7123 31.00
7124 28.00
7125 26.00
7126 34.01
7127 32.27
7130 30.48
7131 30.92
7132 29.00
7133 25.00
7200 40.26
7210 37.72
7211 37.45
7212 39.00
7213 33.02
7214 44.00
7215 32.00
7220 37.84
7221 35.42
7222 39.96
7223 37.87
7224 27.62
7230 41.37
7231 44.00
7232 49.89
7233 42.17
7234 28.00
7300 38.51
7310 35.06
7311 43.52
7312 33.00
7313 43.00
7314 25.00
7315 32.48
7316 31.00
7317 21.00
7318 35.06
7319 35.06
7320 41.46
7321 42.31
7322 41.08
7323 32.00
7400 41.08
7410 41.17
7411 44.01
7412 38.00
7413 36.00
7420 40.69
7421 44.15
7422 35.00
7500 34.69
7510 30.11
7511 23.79
7512 33.00
7513 34.00
7514 30.11
7515 34.00
7516 34.18
7520 38.08
7521 39.41
7522 39.99
7523 36.00
7530 32.23
7531 38.57
7532 41.00
7533 26.00
7534 31.00
7535 22.00
7536 27.37
7540 39.22
7541 39.22
7542 39.22
7543 38.81
7544 39.22
7549 41.00
8000 32.45
8100 32.77
8110 32.11
8111 32.25
8112 32.00
8113 31.00
8114 30.00
8120 38.86
8121 41.13
8122 28.00
8130 36.54
8131 31.55
8132 36.00
8140 29.61
8141 30.00
8142 29.30
8143 28.00
8150 27.78
8151 32.64
8152 30.20
8153 27.86
8154 23.32
8155 27.86
8156 27.86
8157 27.86
8159 27.86
8160 36.28
8170 29.55
8171 28.00
8172 29.95
8180 25.00
8181 25.00
8182 25.00
8183 25.00
8189 25.00
8200 39.34
8210 35.52
8211 39.34
8212 48.00
8219 39.34
8300 31.89
8310 34.28
8311 39.41
8312 29.09
8320 30.76
8321 30.76
8322 30.76
8330 32.91
8331 32.00
8332 33.00
8340 31.60
8341 31.00
8342 32.00
8343 32.39
8344 28.00
8350 28.69
9000 20.76
9100 20.26
9110 20.00
9111 20.00
9112 20.00
9120 20.03
9121 20.03
9122 20.03
9123 20.03
9129 20.03
9200 22.28
9210 22.16
9211 21.00
9212 26.00
9213 22.28
9214 21.00
9215 42.00
9216 22.28
9300 18.96
9310 18.02
9311 18.02
9312 27.60
9313 15.00
9320 20.09
9321 22.00
9329 21.08
9330 20.39
9331 17.00
9332 23.97
9333 20.30
9334 20.39
9400 22.00
9410 22.00
9411 22.00
9412 22.00
9500 21.72
9510 12.00
9520 21.80
9600 20.08
9610 13.00
9611 13.00
9612 13.00
9613 13.00
9620 21.89
9621 23.13
9622 22.88
9623 21.00
9624 22.88
9629 24.00
