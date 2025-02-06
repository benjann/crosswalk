{smcl}
{* version 1.0.0  29jan2025  Ben Jann}{...}
{hi:case.egp68()} {hline 2} EGP case function for ISCO-68

{title:Syntax}

        {cmd:case.egp68(}{help varname:{it:sempl}} [{help varname:{it:supvis}}]{cmd:)}

    {it:sempl}!=0 indicates that a respondent is self-employed
    {it:supvis} specifies the number of subordinates or employees

{title:Description}

{pstd}
    {helpb crosswalk} case function for use with ISCO-68 to EGP
    translator. The function distinguishes the following cases:

        1 = employed, without subordinates
        2 = employed, 1-9 subordinates
        3 = employed, 10 or more subordinates
        4 = self-employed, no employees
        5 = self-employed, 1-9 employees
        6 = self-employed, 10 or more employees

{pstd}
    Missing values in {it:sempl} will be treated as {it:sempl}=0; missing or
    negative values in {it:supvis} will be treated as {it:supvis}=0.
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
// generate cases
replace `case' = 1 if `touse'
replace `case' = 4 if `sempl'!=0 & `sempl'<. & `touse'
if "`supvis'"!="" {
    replace `case' = 2 if `supvis'>=1  & `supvis'<10 & `case'==1 & `touse'
    replace `case' = 3 if `supvis'>=10 & `supvis'<.  & `case'==1 & `touse'
    replace `case' = 5 if `supvis'>=1  & `supvis'<10 & `case'==4 & `touse'
    replace `case' = 6 if `supvis'>=10 & `supvis'<.  & `case'==4 & `touse'
}
