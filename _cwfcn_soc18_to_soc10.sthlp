{smcl}
{* version 1.0.0  09feb2025  Ben Jann}{...}
{hi:soc18_to_soc10()} {hline 2} Translate 6-digit 2018 SOC to 6-digit 2010 SOC (non-unique)

{title:Syntax}

        {cmd:soc18_to_soc10(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 6-digit 2018 SOC codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 6-digit 2018 SOC codes to 
    6-digit 2010 SOC codes (Standard Occupational Classification by the
    U.S. Bureau of Labor Statistics). The crosswalk table is non-unique,
    meaning that a single 2018 SOC may be matched to multiple 2010 SOC codes
    (and vice versa; many-to-many crosswalk). {cmd:soc18_to_soc10()} requires
    option {helpb crosswalk##expandok:expandok}.

{title:Source}

{pstd}
    {cmd:soc18_to_soc10()} is implemented as a wrapper for
    {helpb _cwfcn_soc10_to_soc18:soc10_to_soc18()}.
    {p_end}
{hline}
{asis}
.soc10_to_soc18(2)
