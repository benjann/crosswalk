{smcl}
{* version 1.0.0  07feb2025  Ben Jann}{...}
{hi:ilo_isco88_to_isco08()} {hline 2} Translate 4-digit ISCO-88 to 4-digit ISCO-08 (non-unique)

{title:Syntax}

        {cmd:ilo_isco88_to_isco08(}{varname}{cmd:)}

{pstd}
    where {it:varname} contains 4-digit ISCO-08 codes.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 4-digit ISCO-88 codes to 4-digit ISCO-08
    codes based on the correspondence table provided by the ILO. The crosswalk table is
    non-unique, meaning that a single ISCO-88 code may be matched to multiple
    ISCO-08 codes (and vice versa; many-to-many crosswalk). {cmd:ilo_isco88_to_isco08()}
    requires option {helpb crosswalk##expandok:expandok}.

{title:Source}

{pstd}
    {cmd:ilo_isco88_to_isco08()} is implemented as a wrapper for
    {helpb _cwfcn_ilo_isco08_to_isco88:ilo_isco08_to_isco88()}.
    {p_end}
{hline}
{asis}
.ilo_isco08_to_isco88(2)
