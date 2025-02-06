{smcl}
{* version 1.0.0  30jan2025  Ben Jann}{...}
{hi:isco08_to_esec()} {hline 2} Translate 4-digit ISCO-08 to ESeC classes

{title:Syntax}

        {cmd:isco08_to_esec(}{varname} [{help crosswalk##case:{it:case}}]{cmd:)}

{pstd}
    where {it:varname} contains 4-digit ISCO-08 codes
    and {it:case} selects the destination column.

{pstd}
    Typical usage:

        {cmd:isco08_to_esec(}{varname} {cmd:case.esec(}{it:sempl} {it:supvis}{cmd:)}{cmd:)}

{pstd}
    with {it:sempl} and {it:supvis} as described in {helpb _cwcasefcn_esec:case.esec()}.

{title:Description}

{pstd}
    {helpb crosswalk} table translating 4-digit ISCO-08 codes to ESeC classes
    (European Socio-economic Classification; see Harrison/Rose 2006). Note that
    ESeC is defined at the level of minor ISCO groups (3 digit); that is, all
    unit groups within a minor group will translate into the same class.

{pstd}
    Cases (destination columns):

            1 = employed, without supervisory status
            2 = employed, with supervisory status
            3 = self-employed, no employees
            4 = self-employed, 1-9 employees
            5 = self-employed, 10 or more employees

{pstd}
    Employees with supervisory status are employees who have formal responsibility
    for supervising the work of other employees. If the data does not contain a
    direct measure of supervisory status, Harrison and Rose (2006, section 4.7)
    suggest coding employees as supervisors if they are supervising at least
    three people.

{title:Source}

{pstd}
    {cmd:isco08_to_esec()} is implemented as a wrapper for 
    {helpb _cwfcn_isco08_to_isco08_3:isco08_to_isco08_3()} followed by
    {helpb _cwfcn_isco08_3_to_esec:isco08_3_to_esec()}.

{title:References}

{phang}
    Harrison, E., D. Rose. 2006. The European Socio-economic Classification
    (ESeC) User Guide. Institute for Social and Economic Research,
    University of Essex. Available from
    {browse "http://www.iser.essex.ac.uk/archives/esec/user-guide"}.
    {p_end}
{hline}
{asis}
.isco08_to_isco08_3
.isco08_3_to_esec
