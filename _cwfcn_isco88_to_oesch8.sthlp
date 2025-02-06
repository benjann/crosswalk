{smcl}
{* version 1.0.0  05feb2025  Ben Jann}{...}
{hi:isco88_to_oesch8()} {hline 2} Translate 4-digit ISCO-88 to 8 OESCH classes

{title:Syntax}

        {cmd:isco88_to_oesch8(}{varname} [{help crosswalk##case:{it:case}}]{cmd:)}

{pstd}
    where {it:varname} contains 4-digit ISCO-88 codes
    and {it:case} selects the destination column.

{pstd}
    Typical usage:

        {cmd:isco88_to_oesch8(}{varname} {cmd:case.oesch(}{it:sempl} {it:supvis}{cmd:)}{cmd:)}

{pstd}
    with {it:sempl} and {it:supvis} as described in {helpb _cwcasefcn_oesch:case.oesch()}.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 4-digit ISCO-88 codes to 8 OESCH classes
    (Oesch 2006a,b). Also see {helpb _cwfcn_isco88_to_oesch:isco88_to_oesch()} and
    {helpb _cwfcn_isco88_to_oesch5:isco88_to_oesch5()}.

{pstd}
    Cases (destination columns):

        1 = employed
        2 = self-employed, no employees
        3 = self-employed, 1-9 employees
        4 = self-employed, 10 or more employees

{pstd}
    Case 2 includes helping family members.

{title:Source}

{pstd}
    {cmd:isco08_to_oesch8()} is implemented as a wrapper for 
    {helpb _cwfcn_isco88_to_oesch:isco88_to_oesch()} followed by
    {helpb _cwfcn_oesch_to_oesch8:oesch_to_oesch8()}.

{title:References}

{phang}
    Oesch, D. 2006a. Coming to Grips with a Changing Class Structure. An Analysis
    of Employment Stratification in Britain, Germany, Sweden and Switzerland. International
    Sociology 21(2): 263-288
    {p_end}
{phang}
    Oesch, D. 2006b. Redrawing the Class Map. Stratification and Institutions
    in Britain, Germany, Sweden and Switzerland. Palgrave Macmillan.
    {p_end}
{hline}
{asis}
.isco88_to_oesch
.oesch_to_oesch8
