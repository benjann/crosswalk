{smcl}
{* version 1.0.0  29jan2025  Ben Jann}{...}
{hi:isco88_to_treiman()} {hline 2} Translate 4-digit ISCO-88 to SIOPS scores

{title:Syntax}

        {cmd:isco88_to_treiman(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 4-digit ISCO-88 codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 4-digit ISCO-88 codes to SIOPS scores
    (Standard International Occupational Prestige Scale; Treiman 1977).

{title:Source}

{pstd}
    {cmd:isco88_to_treiman()} is implemented as a wrapper for 
    {helpb _cwfcn_isco88_to_siops:isco88_to_siops()}.

{title:References}

{phang}
    Treiman, D.J. 1977. Occupational Prestige in Comparative Perspective. New
    York: Academic Press.
    {p_end}
{hline}
{asis}
.isco88_to_siops
