{smcl}
{* version 1.0.0  09feb2025  Ben Jann}{...}
{hi:soc00_to_isco88()} {hline 2} Translate 6-digit 2000 SOC to 4-digit ISCO-88 (non-unique)

{title:Syntax}

        {cmd:soc00_to_isco88(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 6-digit 2000 SOC codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 6-digit 2000 SOC codes (2000 Standard
    Occupational Classification by the U.S. Bureau of Labor Statistics) to
    4-digit ISCO-88. The crosswalk table is non-unique, meaning that a single
    2000 SOC may be matched to multiple ISCO-88 codes (and vice versa;
    many-to-many crosswalk). {cmd:soc00_to_isco88()} requires option
    {helpb crosswalk##expandok:expandok}.

{title:Source}

{pstd}
    {cmd:soc00_to_isco88()} is implemented as a wrapper for
    {helpb _cwfcn_isco88_to_soc00:isco88_to_soc00()}.
    {p_end}
{hline}
{asis}
.isco88_to_soc00(2)
