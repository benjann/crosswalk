{smcl}
{* version 1.0.0  06feb2025  Ben Jann}{...}
{hi:isco88_2_to_oep()} {hline 2} Translate 2-digit ISCO-88 to OEP scores

{title:Syntax}

        {cmd:isco88_2_to_oep(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 2-digit ISCO-88 codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 2-digit ISCO-88 codes to OEP scores
    (Occupational Earning Potential; Oesch et al. 2024).

{title:Source}

{pstd}
    File {bf:isco88-2_to_oep.xlsx} provided by Oesch (2025), supplemented (where
    possible) by 2-digit variants of the mappings in {bf:isco88-1_to_oep.xlsx}.

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
01 69
10 78
11 81
12 81
13 55
20 73
21 80
22 78
23 65
24 71
30 55
31 62
32 46
33 43
34 55
40 37
41 38
42 34
50 21
51 22
52 21
60 21
61 21
62 21
70 44
71 44
72 49
73 40
74 27
80 38
81 50
82 31
83 39
90 21
91 18
92 14
93 26
