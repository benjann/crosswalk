{smcl}
{* version 1.0.0  29jan2025  Ben Jann}{...}
{hi:isco08_to_treiman()} {hline 2} Translate 4-digit ISCO-08 to SIOPS scores

{title:Syntax}

        {cmd:isco08_to_treiman(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 4-digit ISCO-08 codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 4-digit ISCO-08 codes to SIOPS scores
    (Standard International Occupational Prestige Scale; Treiman 1977).

{title:Source}

{pstd}
    {cmd:isco08_to_treiman()} is implemented as a wrapper for 
    {helpb _cwfcn_isco08_to_siops:isco08_to_siops()}.

{title:References}

{phang}
    Treiman, D.J. 1977. Occupational Prestige in Comparative Perspective. New
    York: Academic Press.
    {p_end}
{hline}
{asis}
.isco08_to_siops
