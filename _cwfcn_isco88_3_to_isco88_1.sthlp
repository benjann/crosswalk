{smcl}
{* version 1.0.0  06feb2025  Ben Jann}{...}
{hi:isco88_3_to_isco88_1()} {hline 2} Translate 3-digit ISCO-88 to 1-digit ISCO-88

{title:Syntax}

        {cmd:isco88_3_to_isco88_1(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 3-digit ISCO-88 codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 3-digit ISCO-88 codes (minor groups)
    to 1-digit ISCO-88 codes (major groups).

{title:Source}

{pstd}
    {cmd:isco88_3_to_isco88_1()} is implemented as a wrapper for 
    {helpb _cwfcn_isco88_3_to_isco88_2:isco88_3_to_isco88_2()} followed by
    {helpb _cwfcn_isco88_2_to_isco88_1:isco88_2_to_isco88_1()}.
    {p_end}
{hline}
{asis}
.isco88_3_to_isco88_2
.isco88_2_to_isco88_1
