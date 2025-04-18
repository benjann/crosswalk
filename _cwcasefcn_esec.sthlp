{smcl}
{* version 1.0.0  29jan2025  Ben Jann}{...}
{hi:case.esec()} {hline 2} ESeC case function (for ISCO-08)

{title:Syntax}

        {cmd:case.esec(}{help varname:{it:sempl}} [{help varname:{it:supvis}}]{cmd:)}

    {it:sempl}!=0 indicates that a respondent is self-employed
    if {it:sempl}==0: {it:supvis}>0 indicates that a respondent has supervisory status
    if {it:sempl}!=0: {it:supvis} specifies the number of employees

{title:Description}

{pstd}
    {helpb crosswalk} case function for use with ISCO-08 to ESeC
    translators. The function distinguishes the following cases:

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

{pstd}
    Missing values in {it:sempl} will be treated as {it:sempl}=0; missing or
    negative values in {it:supvis} will be treated as {it:supvis}=0.

{title:References}

{phang}
    Harrison, E., D. Rose. 2006. The European Socio-economic Classification
    (ESeC) User Guide. Institute for Social and Economic Research,
    University of Essex. Available from
    {browse "http://www.iser.essex.ac.uk/archives/esec/user-guide"}.
    {p_end}
{hline}
{asis}
// parse input
gettoken case   0 : 0
gettoken touse  0 : 0
gettoken sempl  0 : 0
gettoken supvis 0 : 0
if `"`0'"'!="" error 198
unab sempl: `sempl', min(1) max(1)
count if `sempl'>=. & `touse'
if r(N) noi di as txt "({cmd:`sempl'}: missing values treated as 0)"
if `"`supvis'"'!=""{
    unab supvis: `supvis', min(1) max(1)
    count if `supvis'>=. & `touse'
    if r(N) noi di as txt "({cmd:`supvis'}: missing values treated as 0)"
    count if `supvis'<0 & `touse'
    if r(N) noi di as txt "({cmd:`supvis'}: negative values treated as 0)"
}
else noi di as txt "({it:supvis} not specified; assumed 0)"
// generate cases
replace `case' = 1 if `touse'
replace `case' = 3 if `sempl'!=0 & `sempl'<. & `touse'
if "`supvis'"!="" {
    replace `case' = 2 if `supvis'>=1  & `supvis'<.  & `case'==1 & `touse'
    replace `case' = 4 if `supvis'>=1  & `supvis'<10 & `case'==3 & `touse'
    replace `case' = 5 if `supvis'>=10 & `supvis'<.  & `case'==3 & `touse'
}
