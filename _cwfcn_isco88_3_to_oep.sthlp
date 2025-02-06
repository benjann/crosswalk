{smcl}
{* version 1.0.0  06feb2025  Ben Jann}{...}
{hi:isco88_3_to_oep()} {hline 2} Translate 3-digit ISCO-88 to OEP scores

{title:Syntax}

        {cmd:isco88_3_to_oep(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 3-digit ISCO-88 codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 3-digit ISCO-88 codes to OEP scores
    (Occupational Earning Potential; Oesch et al. 2024).

{title:Source}

{pstd}
    File {bf:isco88-3_to_oep.xlsx} provided by Oesch (2025), supplemented (where
    possible) by 3-digit variants of the mappings in {bf:isco88-2_to_oep.xlsx} and
    {bf:isco88-1_to_oep.xlsx}.

{title:References}

{phang}
    Oesch, Daniel, Oliver Lipps, Roujman Shahbazian, Erik Bihagen,
    Katy Morris. 2024. Occupational Earning Potential. A new measure of social
    hierarchy applied to Europe. European Commission, Seville,
    {browse "https://publications.jrc.ec.europa.eu/repository/handle/JRC139883":JRC139883}.
    {p_end}
{phang}
    Oesch, Daniel, Oliver Lipps, Roujman Shahbazian, Erik Bihagen,
    Katy Morris. 2025. Occupational Earning Potential (OEP) Scale. OSF,
    DOI:{browse "https://doi.org/10.17605/OSF.IO/PR89U":10.17605/OSF.IO/PR89U}. 
    {p_end}
{hline}
{asis}
000 69
010 63
011 71
100 78
110 81
111 90
112 83
113 94
114 79
120 81
121 93
122 75
123 85
130 55
131 49
200 73
210 80
211 78
212 84
213 80
214 80
220 78
221 70
222 88
223 55
230 65
231 77
232 68
233 57
234 65
235 61
240 71
241 75
242 87
243 51
244 58
245 65
246 61
247 70
300 55
310 62
311 62
312 67
313 53
314 85
315 53
320 46
321 49
322 40
323 42
324 19
330 43
332 32
333 41
334 47
340 55
341 63
342 57
343 52
344 56
345 71
346 39
347 49
348 44
400 37
410 38
411 34
412 46
413 38
414 35
419 35
420 34
421 36
422 25
500 21
510 22
511 41
512 17
513 18
514 16
515 47
516 57
520 21
521 24
522 21
523 14
600 21
610 21
611 22
612 16
613 24
614 32
615 33
620 21
621 21
700 44
710 44
711 53
712 42
713 48
714 34
720 49
721 42
722 48
723 49
724 52
730 40
731 40
732 30
733 24
734 44
740 27
741 25
742 34
743 22
744 21
800 38
810 50
811 72
812 46
813 30
814 39
815 54
816 57
817 52
820 31
821 44
822 40
823 32
824 33
825 37
826 15
827 28
828 32
829 28
830 39
831 65
832 37
833 39
834 52
900 21
910 18
911 20
912 17
913 11
914 29
915 25
916 26
920 14
921 14
930 26
931 34
932 21
933 32
