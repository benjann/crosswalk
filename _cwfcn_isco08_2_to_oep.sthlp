{smcl}
{* version 1.0.0  06feb2025  Ben Jann}{...}
{hi:isco08_2_to_oep()} {hline 2} Translate 2-digit ISCO-08 to OEP scores

{title:Syntax}

        {cmd:isco08_2_to_oep(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 2-digit ISCO-08 codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 2-digit ISCO-08 codes to OEP scores
    (Occupational Earning Potential; Oesch et al. 2024).

{title:Source}

{pstd}
    File {bf:isco08-2_to_oep.xlsx} provided by Oesch (2025), supplemented (where
    possible) by 2-digit variants of the mappings in {bf:isco08-1_to_oep.xlsx}.

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
00 69
01 87
02 74
03 59
10 81
11 87
12 84
13 79
14 52
20 71
21 79
22 73
23 62
24 74
25 80
26 65
30 55
31 63
32 43
33 58
34 40
35 65
40 38
41 36
42 37
43 40
44 37
50 23
51 21
52 22
53 18
54 54
60 22
61 21
62 32
63 22
70 44
71 41
72 47
73 40
74 53
75 28
80 37
81 34
82 32
83 39
90 19
91 11
92 14
93 26
94 13
95 17
96 27
