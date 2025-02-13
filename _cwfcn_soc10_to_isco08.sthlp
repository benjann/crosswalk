{smcl}
{* version 1.0.0  09feb2025  Ben Jann}{...}
{hi:soc10_to_isco08()} {hline 2} Translate 6-digit 2010 SOC to 4-digit ISCO-08 (non-unique)

{title:Syntax}

        {cmd:soc10_to_isco08(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 6-digit 2010 SOC codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 6-digit 2010 SOC codes (2010 Standard
    Occupational Classification by the U.S. Bureau of Labor Statistics) to
    4-digit ISCO-08. The crosswalk table is non-unique, meaning that a single
    2010 SOC may be matched to multiple ISCO-08 codes (and vice versa;
    many-to-many crosswalk). {cmd:soc10_to_isco08()} requires option
    {helpb crosswalk##expandok:expandok}.

{title:Source}

{pstd}
    {cmd:soc10_to_isco08()} is implemented as a wrapper for
    {helpb _cwfcn_isco08_to_soc10:isco08_to_soc10()}.
    {p_end}
{hline}
{asis}
.isco08_to_soc10(2)
