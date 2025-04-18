{smcl}
{* version 1.0.1  07mar2025  Ben Jann}{...}
{hi:soc00_to_soc10()} {hline 2} Translate 6-digit 2000 SOC to 6-digit 2010 SOC (non-unique)

{title:Syntax}

        {cmd:soc00_to_soc10(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 6-digit 2000 SOC codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 6-digit 2000 SOC codes to 
    6-digit 2010 SOC codes (Standard Occupational Classification by the
    U.S. Bureau of Labor Statistics). The crosswalk table is non-unique,
    meaning that a single 2000 SOC may be matched to multiple 2010 SOC codes
    (and vice versa; many-to-many crosswalk). {cmd:soc00_to_soc10()} requires
    option {helpb crosswalk##dupl:duplicates()}.

{title:Source}

{pstd}
    File {bf:soc_2000_to_2010_crosswalk.xls} provided by the Bureau of Labor Statistics at
    {browse "https://www.bls.gov/soc/soccrosswalks.htm"}.
    {p_end}
{hline}
{asis}
111011 111011
111021 111021
111031 111031
112011 112011
112021 112021
112022 112022
112031 112031
113011 113011
113021 113021
113031 113031
113041 113111
113042 113131
113049 113121
113051 113051
113061 113061
113071 113071
119011 119013
119012 119013
119021 119021
119031 119031
119032 119032
119033 119033
119039 119039
119041 119041
119051 119051
119061 119061
119061 394031
119071 119071
119081 119081
119111 119111
119121 119121
119131 119131
119141 119141
119151 119151
119199 119199
131011 131011
131021 131021
131022 131022
131023 131023
131031 131031
131032 131032
131041 131041
131041 339093
131051 131051
131061 119161
131071 131071
131072 131141
131073 131151
131079 131071
131079 131075
131081 131081
131111 131111
131121 131121
131199 131121
131199 131161
131199 131199
132011 132011
132021 132021
132031 132031
132041 132041
132051 132051
132052 132052
132053 132053
132061 132061
132071 132071
132072 132072
132081 132081
132082 132082
132099 132099
151011 151111
151021 151131
151031 151132
151032 151133
151041 151151
151051 151121
151051 151143
151061 151141
151071 151142
151081 151122
151081 151134
151081 151142
151081 151143
151081 151152
151099 151199
152011 152011
152021 152021
152031 152031
152041 152041
152091 152091
152099 152099
171011 171011
171012 171012
171021 171021
171022 171022
172011 172011
172021 172021
172031 172031
172041 172041
172051 172051
172061 172061
172071 172071
172072 172072
172081 172081
172111 172111
172112 172112
172121 172121
172131 172131
172141 172141
172151 172151
172161 172161
172171 172171
172199 172199
173011 173011
173012 173012
173013 173013
173019 173019
173021 173021
173022 173022
173023 173023
173024 173024
173025 173025
173026 173026
173027 173027
173029 173029
173031 173031
191011 191011
191012 191012
191013 191013
191021 191021
191022 191022
191023 191023
191029 191029
191031 191031
191032 191032
191041 191041
191042 191042
191099 191099
192011 192011
192012 192012
192021 192021
192031 192031
192032 192032
192041 192041
192042 192042
192043 192043
192099 192099
193011 193011
193021 131161
193022 193022
193031 193031
193032 193032
193039 193039
193041 193041
193051 193051
193091 193091
193092 193092
193093 193093
193094 193094
193099 193099
194011 194011
194021 194021
194031 194031
194041 194041
194051 194051
194061 194061
194091 194091
194092 194092
194093 194093
194099 194099
211011 211011
211012 211012
211013 211013
211014 211014
211015 211015
211019 211019
211021 211021
211022 211022
211023 211023
211029 211029
211091 211091
211091 211094
211092 211092
211093 211093
211099 211094
211099 211099
212011 212011
212021 212021
212099 212099
231011 231011
231021 231021
231022 231022
231023 231023
232011 232011
232091 232091
232092 231012
232092 232011
232093 232093
232099 232099
251011 251011
251021 251021
251022 251022
251031 251031
251032 251032
251041 251041
251042 251042
251043 251043
251051 251051
251052 251052
251053 251053
251054 251054
251061 251061
251062 251062
251063 251063
251064 251064
251065 251065
251066 251066
251067 251067
251069 251069
251071 251071
251072 251072
251081 251081
251082 251082
251111 251111
251112 251112
251113 251113
251121 251121
251122 251122
251123 251123
251124 251124
251125 251125
251126 251126
251191 251191
251192 251192
251193 251193
251194 251194
251199 251199
252011 252011
252012 252012
252021 252021
252022 252022
252023 252023
252031 252031
252032 252032
252041 252051
252041 252052
252042 252053
252043 252054
253011 253011
253021 253021
253099 252059
253099 253099
254011 254011
254012 254012
254013 254013
254021 254021
254031 254031
259011 259011
259021 259021
259031 259031
259041 259041
259099 259099
271011 271011
271012 271012
271013 271013
271014 271014
271019 271019
271021 271021
271022 271022
271023 271023
271024 271024
271025 271025
271026 271026
271027 271027
271029 271029
272011 272011
272012 272012
272021 272021
272022 272022
272023 272023
272031 272031
272032 272032
272041 272041
272042 272042
272099 272099
273011 273011
273012 273012
273021 273021
273022 273022
273031 131121
273031 131161
273031 273031
273041 273041
273042 273042
273043 273043
273091 273091
273099 273099
274011 274011
274012 274012
274013 274013
274014 274014
274021 274021
274031 274031
274032 274032
274099 274099
291011 291011
291021 291021
291022 291022
291023 291023
291024 291024
291029 291029
291031 291031
291041 291041
291051 291051
291061 291061
291062 291062
291063 291063
291064 291064
291065 291065
291066 291066
291067 291067
291069 291069
291071 291071
291081 291081
291111 291141
291111 291151
291111 291161
291111 291171
291121 291181
291122 291122
291123 291123
291124 291124
291125 291125
291126 291126
291127 291127
291129 291128
291129 291129
291131 291131
291199 291199
292011 292011
292012 292012
292021 292021
292031 292031
292032 292032
292033 292033
292034 292034
292034 292035
292041 292041
292051 292051
292052 292052
292053 292053
292054 292054
292055 292055
292056 292056
292061 292061
292071 292071
292081 292081
292091 292091
292099 292057
292099 292092
292099 292099
299011 299011
299012 299012
299091 299091
299099 299092
299099 299099
311011 311011
311012 311014
311012 311015
311013 311013
312011 312011
312012 312012
312021 312021
312022 312022
319011 319011
319091 319091
319092 319092
319093 319093
319094 319094
319095 319095
319096 319096
319099 319097
319099 319099
331011 331011
331012 331012
331021 331021
331099 331099
332011 332011
332021 332021
332022 332022
333011 333011
333012 333012
333021 333021
333031 333031
333041 333041
333051 333051
333052 333052
339011 339011
339021 339021
339031 339031
339032 339032
339032 339093
339091 339091
339092 339092
339099 339093
339099 339099
351011 351011
351012 351012
352011 352011
352012 352012
352013 352013
352014 352014
352015 352015
352019 352019
352021 352021
353011 353011
353021 353021
353022 353022
353031 353031
353041 353041
359011 359011
359021 359021
359031 359031
359099 359099
371011 371011
371012 371012
372011 372011
372012 372012
372019 372019
372021 372021
373011 373011
373012 373012
373013 373013
373019 373019
391011 391011
391012 391012
391021 391021
392011 392011
392021 392021
393011 393011
393012 393012
393019 393019
393021 393021
393031 393031
393091 393091
393092 393092
393093 393093
393099 393099
394011 394011
394021 394021
395011 395011
395012 395012
395091 395091
395092 395092
395093 395093
395094 395094
396011 396011
396012 396012
396021 397011
396022 397012
396031 532031
396032 536061
399011 399011
399021 399021
399031 399031
399032 399032
399041 399041
399099 399099
411011 411011
411012 411012
412011 412011
412012 412012
412021 412021
412022 412022
412031 412031
413011 413011
413021 413021
413031 413031
413041 413041
413099 413099
414011 414011
414012 414012
419011 419011
419012 419012
419021 419021
419022 419022
419031 419031
419041 419041
419091 419091
419099 131131
419099 419099
431011 431011
432011 432011
432021 432021
432099 432099
433011 433011
433021 433021
433031 433031
433041 433041
433051 433051
433061 433061
433071 433071
434011 434011
434021 434021
434031 434031
434041 434041
434051 434051
434061 434061
434071 434071
434081 434081
434111 434111
434121 434121
434131 434131
434141 434141
434151 434151
434161 434161
434171 434171
434181 434181
434199 434199
435011 435011
435021 435021
435031 435031
435032 435032
435041 435041
435051 435051
435052 435052
435053 435053
435061 435061
435071 435071
435081 435081
435111 435111
436011 436011
436012 436012
436013 436013
436014 436014
439011 439011
439021 439021
439022 439022
439031 439031
439041 439041
439051 439051
439061 439061
439071 439071
439081 439081
439111 439111
439199 433099
439199 439199
451011 451011
451012 131074
452011 452011
452021 452021
452041 452041
452091 452091
452092 452092
452093 452093
452099 452099
453011 453011
453021 453021
454011 454011
454021 454021
454022 454022
454023 454023
454029 454029
471011 471011
472011 472011
472021 472021
472022 472022
472031 472031
472041 472041
472042 472042
472043 472043
472044 472044
472051 472051
472053 472053
472061 472061
472071 472071
472072 472072
472073 472073
472081 472081
472082 472082
472111 472111
472111 472231
472121 472121
472131 472131
472132 472132
472141 472141
472142 472142
472151 472151
472152 472152
472161 472161
472171 472171
472181 472181
472181 472231
472211 472211
472221 472221
473011 473011
473012 473012
473013 473013
473014 473014
473015 473015
473016 473016
473019 473019
474011 474011
474021 474021
474031 474031
474041 474041
474051 474051
474061 474061
474071 474071
474091 474091
474099 472231
474099 474099
475011 475011
475012 475012
475013 475013
475021 475021
475031 475031
475041 475041
475042 475042
475049 475049
475051 475051
475061 475061
475071 475071
475081 475081
475099 475099
491011 491011
492011 492011
492021 492021
492022 492022
492091 492091
492092 492092
492093 492093
492094 492094
492095 492095
492096 492096
492097 492097
492098 492098
493011 493011
493021 493021
493022 493022
493023 493023
493031 493031
493041 493041
493042 493042
493043 493043
493051 493051
493052 493052
493053 493053
493091 493091
493092 493092
493093 493093
499011 499011
499012 499012
499021 472231
499021 499021
499031 499031
499041 499041
499042 499071
499043 499043
499044 499044
499045 499045
499051 499051
499052 499052
499061 499061
499062 499062
499063 499063
499064 499064
499069 499069
499091 499091
499092 499092
499093 499093
499094 499094
499095 499095
499096 499096
499097 499097
499098 499098
499099 472231
499099 499081
499099 499099
511011 511011
512011 512011
512021 512021
512022 512022
512023 512023
512031 512031
512041 512041
512091 512091
512092 512092
512093 512093
512099 512099
513011 513011
513021 513021
513022 513022
513023 513023
513091 513091
513092 513092
513093 513093
514011 514011
514012 514012
514021 514021
514022 514022
514023 514023
514031 514031
514032 514032
514033 514033
514034 514034
514035 514035
514041 514041
514051 514051
514052 514052
514061 514061
514062 514062
514071 514071
514072 514072
514081 514081
514111 514111
514121 514121
514122 514122
514191 514191
514192 514192
514193 514193
514194 514194
514199 514199
515011 515113
515012 515113
515021 515112
515021 515113
515022 515111
515023 515112
516011 516011
516021 516021
516031 516031
516041 516041
516042 516042
516051 516051
516052 516052
516061 516061
516062 516062
516063 516063
516064 516064
516091 516091
516092 516092
516093 516093
516099 516099
517011 517011
517021 517021
517031 517031
517032 517032
517041 517041
517042 517042
517099 517099
518011 518011
518012 518012
518013 518013
518021 518021
518031 518031
518091 518091
518092 518092
518093 518093
518099 518099
519011 519011
519012 519012
519021 519021
519022 519022
519023 519023
519031 519031
519032 519032
519041 519041
519051 519051
519061 519061
519071 519071
519081 519081
519082 519082
519083 519083
519111 519111
519121 519121
519122 519122
519123 519123
519131 519151
519132 519151
519141 519141
519191 519191
519192 519192
519193 519193
519194 519194
519195 519195
519196 519196
519197 519197
519198 519198
519199 513099
519199 519199
531011 531011
531021 531021
531031 531031
532011 532011
532012 532012
532021 532021
532022 532022
533011 533011
533021 533021
533022 533022
533031 533031
533032 533032
533033 533033
533041 533041
533099 533099
534011 534011
534012 534012
534013 534013
534021 534021
534031 534031
534041 534041
534099 534099
535011 535011
535021 535021
535022 535022
535031 535031
536011 536011
536021 536021
536031 536031
536041 536041
536051 536051
536099 536099
537011 537011
537021 537021
537031 537031
537032 537032
537033 537033
537041 537041
537051 537051
537061 537061
537062 537062
537063 537063
537064 537064
537071 537071
537072 537072
537073 537073
537081 537081
537111 537111
537121 537121
537199 537199
551011 551011
551012 551012
551013 551013
551014 551014
551015 551015
551016 551016
551017 551017
551019 551019
552011 552011
552012 552012
552013 552013
553011 553011
553012 553012
553013 553013
553014 553014
553015 553015
553016 553016
553017 553017
553018 553018
553019 553019
