{smcl}
{* version 1.0.0  09feb2025  Ben Jann}{...}
{hi:soc10_to_soc00()} {hline 2} Translate 6-digit 2010 SOC to 6-digit 2000 SOC (non-unique)

{title:Syntax}

        {cmd:soc10_to_soc00(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 6-digit 2010 SOC codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 6-digit 2010 SOC codes to 
    6-digit 2000 SOC codes (Standard Occupational Classification by the
    U.S. Bureau of Labor Statistics). The crosswalk table is non-unique,
    meaning that a single 2010 SOC may be matched to multiple 2000 SOC codes
    (and vice versa; many-to-many crosswalk). {cmd:soc10_to_soc00()} requires
    option {helpb crosswalk##expandok:expandok}.

{title:Source}

{pstd}
    {cmd:soc10_to_soc00()} is implemented as a wrapper for
    {helpb _cwfcn_soc00_to_soc10:soc00_to_soc10()}.
    {p_end}
{hline}
{asis}
.soc00_to_soc10(2)
