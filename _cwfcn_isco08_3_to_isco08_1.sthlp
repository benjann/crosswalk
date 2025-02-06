{smcl}
{* version 1.0.0  06feb2025  Ben Jann}{...}
{hi:isco08_3_to_isco08_1()} {hline 2} Translate 3-digit ISCO-08 to 1-digit ISCO-08

{title:Syntax}

        {cmd:isco08_3_to_isco08_1(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 3-digit ISCO-08 codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 3-digit ISCO-08 codes (minor groups)
    to 1-digit ISCO-08 codes (major groups).

{title:Source}

{pstd}
    {cmd:isco08_3_to_isco08_1()} is implemented as a wrapper for 
    {helpb _cwfcn_isco08_3_to_isco08_2:isco08_3_to_isco08_2()} followed by
    {helpb _cwfcn_isco08_2_to_isco08_1:isco08_2_to_isco08_1()}.
    {p_end}
{hline}
{asis}
.isco08_3_to_isco08_2
.isco08_2_to_isco08_1
