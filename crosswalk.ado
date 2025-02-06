*! version 1.0.0  06feb2025  Ben Jann

capt mata: assert(mm_version()>=200)
if _rc==1 exit _rc
if _rc {
    di as err "{bf:moremata} version 2.0.0 or newer is required; " _c
    di as err "type {stata ssc install moremata, replace}"
    exit 499
}

program crosswalk
    version 14
    
    // check syntax and redirect to subcommand, if relevant
    syntax [anything(equalok)] [if] [in] [, * ]
    gettoken lhs rhs : anything, parse("=")
    gettoken eq  rhs : rhs, parse("=")
    if `:list sizeof lhs'!=1 | `"`eq'"'!="=" {
        gettoken subcmd : 0, parse(" ,")
        if `"`subcmd'"'==substr("label", 1, max(1, strlen(`"`subcmd'"'))) {
            gettoken subcmd 0 : 0, parse(" ,")
            _cw_label `0'
            exit
        }
        if `"`subcmd'"'==substr("define", 1, max(1, strlen(`"`subcmd'"'))) {
            gettoken subcmd 0 : 0, parse(" ,")
            _cw_define `0'
            exit
        }
        if `"`subcmd'"'==substr("dir", 1, max(2, strlen(`"`subcmd'"'))) {
            gettoken subcmd 0 : 0, parse(" ,")
            _cw_dir `0'
            exit
        }
        if `"`subcmd'"'=="clear" {
            gettoken subcmd 0 : 0, parse(" ,")
            _cw_clear `0'
            exit
        }
    }
    
    // redirect to _cw_case if relevant
    if substr(strtrim(`"`rhs'"'),1,5)=="case." {
        local rhs = substr(strtrim(`"`rhs'"'),6,.)
        _cw_case `lhs' `eq' `rhs' `if' `in', `options'
        exit
    }
    
    // apply crosswalk
    _crosswalk `"`rhs'"' `lhs' `if' `in', `options'
end

program _crosswalk, rclass
    // parse fcn()
    gettoken rhs 0 : 0
    gettoken fcn rhs : rhs, parse("(")
    if `"`fcn'"'=="(" error 198
    gettoken case rhs: rhs, match(par)
    if "`par'"==""   error 198
    if `"`rhs'"'!="" error 198
    gettoken xvar case : case
    unab xvar: `xvar', min(1) max(1)
    local str0 = (substr("`:type `xvar''",1,3)=="str")
    local case = strtrim(`"`case'"')
    
    // rest of syntax
    syntax name(name=generate) [if] [in] [, Replace NOLabel Label(str)/*
        */ MISsing COPYrest COPYrest2(str) COPYMISsing COPYMISsing2(str)/*
        */ NOINFO out(name) STRing NUMeric EXPANDok fast ]
    if "`string'"!="" & "`numeric'"!="" {
        di as err "{bf:string} and {bf:numeric} not both allowed"
        exit 198
    }
    if `"`copyrest2'"'!="" {
        local copyrest copyrest
        _parse_copyrest, `copyrest2'
    }
    if `"`copymissing2'"'!="" {
        local copymissing copymissing
        _parse_copymissing, `copymissing2'
    }
    if "`copymissing'"!="" {
        if "`missing'"!="" {
            di as err "only one of {bf:missing} and {bf:copymissing} allowed"
            exit 198
        }
        if "`copyrest'"!="" {
            di as err "only one of {bf:copyrest} and {bf:copymissing} allowed"
            exit 198
        }
        if `str0' {
            di as err "source variable is string; {bf:copymissing} not allowed"
            exit 198
        }
        if "`string'"!="" {
            di as err "{bf:copymissing} and {bf:string} not both allowed"
            exit 198
        }
        local numeric numeric
    }
    if "`copyrest'"!="" {
        if `str0' {
            if "`numeric'"!="" {
                di as err "{bf:numeric} not allowed if source variable is "/*
                    */ "string and {bf:copyrest} has been specified"
                exit 198
            }
            local string string
            local copyrest_nolabel nolabel
        }
        else {
            if "`string'"!="" {
                di as err "{bf:string} not allowed if source variable is "/*
                    */ "numeric and {bf:copyrest} has been specified"
                exit 198
            }
            local numeric numeric
            if "`missing'"=="" {
                local copymissing copymissing
                local copymissing_nolabel nolabel
            }
        }
    }
    if "`replace'"=="" {
        confirm new variable `generate'
        if "`out'"!="" confirm new variable `out'
    }
    
    // check value labels
    _parse_label `label'
    local label_user 0
    if "`nolabel'"!="" local label
    else if `"`label'"'!="" {
        mata: labels_find(st_local("label"))
        local label_user 1
    }
    else if "`string'"=="" {
        if strpos(`"`fcn'"',"_to_") {
            local label = substr(`"`fcn'"', strpos(`"`fcn'"',"_to_")+4,.)
            capt mata: labels_find(st_local("label"))
            if _rc==1 exit 1
            if _rc local label // no labels found
        }
    }
    
    // preserve data
    if "`expandok'"!="" & "`fast'"=="" preserve
    
    // mark sample
    marksample touse0
    if "`missing'"!="" local touse `touse0'
    else {
        tempvar touse
        qui gen byte `touse' = `touse0'
        markout `touse' `xvar', strok
    }
    
    // evaluate case expression
    if `"`case'"'!="" {
        capt unab CASE: `case', min(1) max(1)
        if _rc==1 exit _rc
        if _rc {
            tempvar CASE
            qui gen byte `CASE' = .
            _check_casefcn `case'
            if `"`casefcn'"'!="" {
                __cw_case `"`casefcn'"' `CASE' `touse' `caseargs'
            }
            else {
                qui replace `CASE' = (`case') if `touse'
            }
        }
    }
    else local CASE
    
    // translate
    tempvar newvar
    if "`out'"!="" tempvar OUT
    mata: crosswalk(`"`fcn'"', "`expandok'"!="", "`xvar'", "`CASE'",/*
        */ "`newvar'", "`touse'", "`string'"!="", "`numeric'"!="",/*
        */ "`copyrest'"!="", "`noinfo'"!="", "`OUT'")
    local str1 = (substr("`:type `newvar''",1,3)=="str")
    if "`expandok'"!="" {
        if `nadd'==1  local msg "observation"
        else          local msg "observations"
        di as txt "(`nadd' `msg' added)"
    }
    
    // add labels
    local haslbls 0
    if "`copyrest'"!="" & "`copyrest_nolabel'"=="" {
        local vlab: val lab `xvar'
        if `"`vlab'"'!="" {
            capt lab copy `vlab' `newvar'
            if _rc==1 exit 1
            if _rc==0 local haslbls 1
        }
    }
    if `"`label'"'!="" & `str1' {
        if `label_user' {
            di as txt "(outcome variable is string; ignoring {bf:label()})"
        }
        local label
    }
    if `"`label'"'!="" {
         mata: labels_set("`newvar'", "`newvar'", `"`label'"', 1,/*
            */ "`label_minimal'"!="")
        local haslbls 1
    }
    
    // copy extended missing values (updated haslbls)
    if "`copymissing'"!="" {
        _copy_missing `xvar' `newvar' `touse0' `copymissing_nolabel'
    }
    
    // display info levels of X not covered by the translator
    if "`noinfo'"=="" {
        if `r_out' {
            if `r_out'==1  local msg "{stata di r(levels_out):`r_out' level}"
            else           local msg "{stata di r(levels_out):`r_out' levels}"
            if `r_out'==1  local msg "`msg' of {bf:`xvar'} is"
            else           local msg "`msg' of {bf:`xvar'} are"
            di as txt "(`msg' out of scope)"
        }
    }
    
    // rename output variable
    if "`replace'"!="" {
        capt confirm new variable `generate'
        if _rc==1 exit _rc
        if _rc drop `generate'
    }
    rename `newvar' `generate'
    di as txt "(variable {bf:`generate'} generated)"
    if `haslbls' {
        capt label drop `generate'
        capt label copy `newvar' `generate'
        capt label drop `newvar'
        label values `generate' `generate', nofix
        if `"`label'"'!="" {
            di as txt "({it:lblset} {bf:`label'} added)"
        }
    }
    if "`out'"!="" {
        if "`replace'"!="" {
            capt confirm new variable `out'
            if _rc==1 exit _rc
            if _rc drop `out'
        }
        rename `OUT' `out'
        di as txt "(variable {bf:`out'} generated)"
    }
    
    // cancel preserve
    if "`expandok'"!="" & "`fast'"=="" restore, not
    
    // returns
    if "`noinfo'"=="" {
        ret local levels_out: list clean levels_out
        ret scalar r_out     = `r_out'
    }
    ret local case    `"`case'"'
    ret local varname `xvar'
    ret local newvar  `generate'
    ret local lblset  `"`label'"'
    ret local fcn     `"`fcn'()"'
    ret scalar string = `str1'
    if "`expandok'"!="" ret scalar N_add = `nadd'
end

program _parse_copyrest
    syntax [, noLabel ]
    c_local copyrest_nolabel `label'
end

program _parse_copymissing
    syntax [, noLabel ]
    c_local copymissing_nolabel `label'
end

program _parse_label
    syntax [anything] [, MINimal ]
    c_local label `"`anything'"'
    c_local label_minimal `minimal'
end

program _copy_missing
    args xvar newvar touse nolabel
    qui replace `newvar' = `xvar' if `touse' & `xvar'>.
    if "`nolabel'"!="" exit
    local vlab: val lab `xvar'
    if `"`vlab'"'=="" exit
    local haslbls 0
    foreach m in `c(alpha)' {
        local lbl: label `vlab' .`m', strict
        if `"`lbl'"'=="" continue
        label define `newvar' .`m' `"`lbl'"', nofix modify
        local haslbls 1
    }
    if `haslbls' c_local haslbls 1
end

program _cw_case, rclass
    // syntax
    syntax [anything(equalok)] [if] [in] [, * ]
    gettoken lhs rhs : anything, parse("=")
    gettoken eq  rhs : rhs, parse("=")
    if `"`eq'"'!="=" error 198
    local 0 `"`lhs' `if' `in', `options'"'
    syntax name(name=generate) [if] [in] [, Replace ]
    gettoken fcn rhs : rhs, parse("(")
    if `"`fcn'"'=="(" error 198
    gettoken args rhs: rhs, match(par)
    if "`par'"==""   error 198
    if `"`rhs'"'!="" error 198
    if "`replace'"=="" {
        confirm new variable `generate'
    }
    
    // apply function
    marksample touse
    tempvar case
    qui gen byte `case' = .
    __cw_case `"`fcn'"' `case' `touse' `args'
    
    // rename output variable
    if "`replace'"!="" {
        capt confirm new variable `generate'
        if _rc==1 exit _rc
        if _rc drop `generate'
    }
    rename `case' `generate'
    di as txt "(variable {bf:`generate'} generated)"
    
    // returns
    ret local newvar  `generate'
    ret local casefcn `"case.`fcn'()"'
end

program __cw_case
    gettoken fcn 0 : 0
    tempfile tmpf
    mata: casefcn_read(st_local("fcn"), st_local("tmpf"))
    run `"`tmpf'"' `0'
end

program _check_casefcn
    if substr(`"`0'"',1,5)!="case." exit
    local 0 = substr(`"`0'"',6,.)
    gettoken fcn rhs : 0, parse("(")
    if `"`fcn'"'=="(" exit
    gettoken args rhs: rhs, match(par)
    if "`par'"==""   exit
    if `"`rhs'"'!="" exit
    capt findfile `"_cwcasefcn_`fcn'.sthlp"'
    if _rc==1 exit 1
    if _rc exit
    c_local casefcn `"`fcn'"'
    c_local caseargs `"`args'"'
end

program _cw_label, rclass
    // syntax
    gettoken label 0 : 0, parse(", ")
    syntax [varlist(numeric default=none)] [, name(name) MODify MINimal ]
    if "`varlist'"=="" {
        local minimal
        if "`name'"=="" local name = strtoname(`"`label'"') 
    }
    
    // import and assign labels
    mata: labels_find(st_local("label"))
    mata: labels_set("`name'", tokens(st_local("varlist")), ///
        `"`label'"', "`modify'"!="", "`minimal'"!="")
    
    // display
    if "`varlist'"=="" {
        di as txt "({it:lblset} {bf:`label'} added to value label " /*
            */ "{stata label list `lblnames':{bf:`lblnames'}})"
    }
    else {
        di as txt "({it:lblset} {bf:`label'} assigned to {bf:`varlist'})"
    }
    
    // returns
    return local varlist  "`varlist'"
    return local lblname  "`lblnames'"
    return local lblset   "`label'"
end

program _cw_define, rclass
    // strip () from name, if relevant
    gettoken 0 rest : 0, parse("(")
    if `"`rest'"'!="" {
        gettoken args rest: rest, match(par)
        if "`par'"==""             error 198
        if strtrim(`"`args'"')!="" error 198
        if `"`rest'"'!=""          error 198
    }
    // collect input and store table
    syntax name
    mata: table_define(st_local("namelist"))
    di as txt "(crosswalk table {bf:`namelist'()} defined)"
    return local fcn `"`namelist'()"'
end

program _cw_dir, rclass
    if `"`0'"'!="" error 198
    mata: table_dir()
    return scalar n = `n'
    return local fcns `"`fcns'"'
end

program _cw_clear
    if `"`0'"'!="" error 198
    mata: rmexternal("_CROSSWALK_DB")
end

version 14
mata:
mata set matastrict on

void crosswalk(string scalar fcn, real scalar expand, string scalar xvar,
    string scalar CASE, string scalar newvar, string scalar touse,
    real scalar str, real scalar num, real scalar copyrest,
    real scalar noinfo, string scalar out)
{
    real scalar            i, n, Cok, Nadd, nadd
    string colvector       F, T
    real colvector         C, null
    transmorphic colvector X, Y, FROM
    pointer scalar         d
    transmorphic matrix    TO
    
    // load main translator
    T = table_load(fcn)
    F = table_alias(T)
    n = rows(F)
    if (!n) {
        F = fcn
        n = 1
    }
    if (expand) Nadd = 0
    // get data
    if (st_isstrvar(xvar)) st_sview(X="", ., xvar, touse)
    else                   st_view(X=., ., xvar, touse)
    if (CASE!="") C = st_data(., CASE, touse)
    Cok = !rows(C)
    Y = X
    null = J(rows(Y),1,0)
    // apply translator(s)
    for (i=1;i<=n;i++) {
        if (F!=fcn) T = table_load(F[i])
        table_parse(T, FROM="", TO="")
        if (!isstring(Y)) {
            if (!_strtorealifpossible(FROM, 1)) {
                printf("{p 0 0 2}{txt}(" + "crosswalk table {bf:%s()} " +
                    "contains nonnumeric origin values; " +
                    "transformation to real resulted in system missing" +
                    "){p_end}\n", fcn)
            }
        }
        if (!str) {
            if (num & i==n) {
                if (!_strtorealifpossible(TO, 1)) {
                    printf("{p 0 0 2}{txt}(" + "crosswalk table {bf:%s()} " +
                        "contains nonnumeric destination values; " +
                        "transformation to real resulted in system missing" +
                        "){p_end}\n", fcn)
                }
            }
            else (void) _strtorealifpossible(TO, 0)
        }
        if (copyrest & i==n) d = &X
        else                 d = &missingof(TO)
        if (expand) {
            nadd = _cw_expand(null, Y, C, FROM, TO, *d, F[i], Cok, touse)
            if (nadd & i<n) { // reload data for next translator if necessary
                if (st_isstrvar(xvar)) st_sview(X, ., xvar, touse)
                else                   st_view(X, ., xvar, touse)
                if (CASE!="") C = st_data(., CASE, touse)
            }
            Nadd = Nadd + nadd
            continue
        }
        if (rows(FROM) & !all(mm_unique_tag(FROM))) {
            errprintf("crosswalk table {bf:%s()} contains duplicate origin " +
                "values;\norigin values must be unique unless option " +
                "{bf:expandok} is specified\n", fcn)
            exit(498)
        }
        _cw_unique(null, Y, C, FROM, TO, *d, F[i], Cok)
    }
    if (!Cok) {
        printf("{p 0 0 2}{txt}(" +
               "argument {it:case} not used by {bf:%s()}" +
               "){p_end}\n", fcn)
    }
    // store result
    if (isstring(Y)) st_sstore(., st_addvar(_strtype(Y), newvar), touse, Y)
    else             st_store(., st_addvar(_dtype(Y), newvar), touse, Y)
    if (expand) st_local("nadd", strofreal(Nadd))
    // collect info on values not covered by the translator
    if (out!="") st_store(., st_addvar("byte", out), touse, null)
    if (!noinfo) _info_out(null, X) // (assumes X is no longer needed)
}

real scalar _cw_expand(real colvector null, transmorphic colvector Y,
    real colvector C, transmorphic colvector FROM, transmorphic matrix TO,
    transmorphic colvector d, string scalar fcn, real scalar Cok,
    string scalar touse)
{
    real scalar    n
    string scalar  E
    real colvector p, L
    pointer matrix P
    
    // check for duplicates
    p = _cw_duplcheck(FROM, TO) // (sorts table if there are duplicates)
    if (p==0) { // no duplicates
        _cw_unique(null, Y, C, FROM, TO, d, fcn, Cok)
        return(0)
    }
    // create pointer matrix containing destination values
    P = _cw_make_P(TO, p, L=.) // (fills in counts in L)
    // obtain ids of matches 
    p = _cw_match(null, Y, FROM[p])
    // count extra obs and expand original data if needed
    L = _cw_collect(null, p, 1, L, 0, "", .)
    n = sum(L)
    // collect pointers to destination values
    P = _cw_collect(null, p, C, P, NULL, fcn, Cok)
    // expand destination values
    Y = _cw_expand_P(P, L, d, n)
    // and expand original data if needed return number of added obs
    if (n) {
        null = null \ J(n, 1, 0)
        E = st_tempname()
        st_store(., st_addvar("double", E), touse, 1 :+ L)
        stata("expand " + E + " if " + touse, 1)
        st_dropvar(E)
    }
    return(n)
}

real colvector _cw_duplcheck(transmorphic colvector FROM,
    transmorphic matrix TO)
{
    real colvector p, q
    
    if (!rows(FROM)) return(0) // empty table
    p = mm_order(FROM, 1, 1) // use stable sort order
    q = _mm_unique_tag(FROM[p])
    if (all(q)) return(0) // no duplicates
    _collate(FROM, p); _collate(TO, p) // sort table
    return(selectindex(q)) // return start indices of groups
}

pointer matrix _cw_make_P(transmorphic matrix TO, real colvector p,
    real colvector L)
{
    real scalar    i, j, c, a, b
    pointer matrix P
    
    P = J(i=rows(p), c=cols(TO), NULL)
    L = J(i, 1, 0)
    a = rows(TO) + 1
    if (c==1) {
        for (;i;i--) {
            b = a - 1
            a = p[i]
            if (a==b) P[i] = &TO[a]
            else {
                P[i] = &TO[|a \ b|]
                L[i] = b - a
            }
        }
    }
    else {
        for (;i;i--) {
            b = a - 1
            a = p[i]
            if (a==b) {
                for (j=c;j;j--) P[i,j] = &TO[a,j]
            }
            else {
                for (j=c;j;j--) P[i,j] = &TO[|a,j \ b,j|]
                L[i] = b - a
            }
        }
    }
    return(P)
}

transmorphic colvector _cw_expand_P(pointer colvector P, real colvector L,
    transmorphic colvector d, real scalar n)
{
    real scalar            i, a, b
    transmorphic colvector Y, yi

    i = rows(P)
    Y = (rows(d)==1 ? J(i, 1, d) : d) \ J(n, 1, missingof(d))
    a = i + n + 1
    for (;i;i--) {
        if (P[i]==NULL) continue
        if (L[i]) {
            yi = *P[i]
            Y[i] = yi[1]
            b = a - 1
            a = a - L[i]
            Y[|a \ b|] = yi[|2 \ .|]
        }
        else Y[i] = *P[i]
    }
    return(Y)
}

void _cw_unique(real colvector null, transmorphic colvector X,
    real colvector C, transmorphic colvector FROM, transmorphic matrix TO,
    transmorphic colvector d, string scalar fcn, real scalar Cok)
{
    X = _cw_collect(null, _cw_match(null, X, FROM), C, TO, d, fcn, Cok)
}

real colvector _cw_match(real colvector null, transmorphic colvector X,
    transmorphic colvector FROM)
{
    real colvector id, p
    
    // find matches
    id = mm_crosswalk(X, FROM, rows(FROM) ? 1::rows(FROM) : J(0,1,.), 0)
    // update list of observations without match
    if (!all(id)) {
        p = selectindex(!id)
        null[p] = J(length(p), 1, 1)
    }
    // return match index
    return(id)
}

transmorphic colvector _cw_collect(real colvector null, real colvector id,
    real colvector C, transmorphic matrix TO, transmorphic colvector d,
    string scalar fcn, real scalar Cok)
{
    real scalar            j
    real colvector         p, q
    transmorphic colvector X
    
    // initialize default values
    X = (rows(d)==1 ? J(rows(id), 1, d) : d)
    // a) single-column translator; case not relevant
    if ((j = cols(TO))==1) {
        p = selectindex(!null)
        if (length(p)) X[p] = TO[id[p]]
        return(X)
    }
    // b) multiple-column translator; case not specified
    if (!rows(C)) {
        printf("{p 0 0 2}{txt}(" +
               "crosswalk table {bf:%s()} has multiple destination columns; " +
               "using first column for all observations; " +
               "specify argument {help crosswalk##case:{it:case}} " +
               "to select destination columns" +
               "){p_end}\n", fcn)
        p = selectindex(!null)
        if (length(p)) X[p] = TO[id[p],1]
        return(X)
    }
    // c) multiple-column translator; case specified
    Cok = 1
    // - process columns
    q = J(rows(X),1,1)
    for (;j;j--) {
        p = selectindex(C:==j :& !null)
        if (!length(p)) continue
        X[p] = TO[id[p],j]
        q[p] = J(rows(p),1,0)
    }
    // - use column 1 for obs with invalid case
    p = selectindex(q :& !null)
    if (length(p)) {
        printf("{p 0 0 2}{txt}(" +
               "argument {help crosswalk##case:{it:case}} " +
               "contains missing values or specifies destination columns " +
               "that do not exist in crosswalk table {bf:%s()}; " +
               "using first column in these cases" +
               "){p_end}\n", fcn)
        X[p] = TO[id[p],1]
    }
    return(X)
}

real scalar _strtorealifpossible(string matrix S, real scalar force)
{
    real scalar rc // 0 if S contains nonnumeric strings, else 1
    real matrix TO
    
    TO = strtoreal(S)
    rc = !any(TO:==. :& S:!="" :& S:!=".")
    if (rc | force) swap(S, TO)
    return(rc)
}

string scalar _strtype(string colvector Y)
{
    real scalar l
    
    l = max(strlen(Y))
    if (l>2045) return("strL")
    return("str"+strofreal(l<1 ? 1 : l))
}

string scalar _dtype(real colvector Y)
{
    real rowvector minmax
    
    if (any(Y:!=trunc(Y))) return("double")
    minmax = minmax(Y)
    if (minmax[1]>=-127        & minmax[2]<=100)        return("byte")
    if (minmax[1]>=-32767      & minmax[2]<=32740)      return("int")
    if (minmax[1]>=-2147483647 & minmax[2]<=2147483620) return("long")
    if (minmax==J(1,2,.))                               return("byte")
    return("double")
}

void _info_out(real colvector null, transmorphic colvector X)
{
    real colvector p
    
    p = selectindex(null)
    if (!length(p)) {
        st_local("r_out", "0")
        return
    }
    X = mm_unique(X[p])
    if (isstring(X)) X = ("`" + `"""') :+ X :+ (`"""' + "'")
    else             X = strofreal(X)
    st_local("levels_out", invtokens(X'))
    st_local("r_out", strofreal(rows(X)))
}

string colvector table_load(string scalar fcn)
{
    string colvector T
    
    T = table_get(fcn)
    if (T!=J(0,0,.)) return(T)
    T = table_read(fcn)
    if (T!=J(0,0,.)) return(T)
    errprintf("crosswalk table {bf:%s()} not found\n", fcn)
    exit(111)
}

void table_define(string scalar nm)
{
    real scalar      i, r
    string colvector T
    
    // collect input
    displayas("txt")
    T = J(100,1,"")
    r = rows(T)
    i = 0
    while (1) {
        stata("display _request2(_line)", 1)
        if (++i>r) {
            T = T \ J(100,1,"")
            r = rows(T)
        }
        T[i] = strtrim(st_local("line"))
        displayas("txt")
        printf("%3.0f. ", i)
        displayas("res")
        printf("%s\n", T[i])
        if (T[i]=="") {
            errprintf("unexpected end of input\n")
            exit(3498)
        }
        if (T[i]=="end") {; i--; break; } // end of input
    }
    if (i) T = T[|1\i|]
    else   T = J(0,1,"")
    // store table in global object
    table_put(nm, T)
}

void table_put(string scalar nm, string colvector T)
{
    pointer scalar p
    
    p = findexternal("_CROSSWALK_DB")
    if (p==NULL) {
        p = crexternal("_CROSSWALK_DB")
        *p = asarray_create()
    }
    asarray(*p, nm, T)
}

transmorphic table_get(string scalar nm)
{   // returns J(0,0,.) if table is not found
    pointer scalar p

    p = findexternal("_CROSSWALK_DB")
    if (p==NULL) return(J(0,0,.))
    return(asarray(*p, nm))
}

void table_dir()
{
    real scalar      i, n
    pointer scalar   p
    string colvector keys

    p = findexternal("_CROSSWALK_DB")
    if (p==NULL) {
        st_local("n", "0")
        printf("{txt}(none)\n")
    }
    else {
        keys = sort(asarray_keys(*p),1) :+ "()"
        displayas("res")
        n = length(keys)
        for (i=1;i<=n;i++) printf("%s\n", keys[i])
        st_local("n", strofreal(n))
        st_local("fcns", invtokens(keys'))
    }
}

transmorphic table_read(string scalar nm)
{   // returns J(0,0,.) if table is not found
    string scalar fn
    
    fn = findfile("_cwfcn_" + nm + ".sthlp")
    if (fn=="") return(J(0,0,.))
    return(cat(fn))
}

string colvector table_alias(string colvector T)
{   // returns J(0,1,"") if T is not an alias list
    real scalar      i, r
    string scalar    s
    string colvector F
    
    r = rows(T)
    F = J(r,1,"")
    for (i=1;i<=r;i++) {
        s = strtrim(subinstr(T[i],char(9)," "))
        // skip empty lines
        if (s=="") continue
        // skip comments
        if (substr(s,1,1)=="*") continue
        // skip header
        if (s=="{smcl}") {
            for (++i;i<=r;i++) { // find end
                s = strtrim(subinstr(T[i],char(9)," "))
                if (s=="{asis}") break
            }
            continue
        }
        // parse row
        if (substr(s,1,1)!=".") return(J(0,1,"")) // alias must start with "."
        if (strpos(s," "))      return(J(0,1,"")) // blanks not allowed in alias
        F[i] = substr(s,2,.)
    }
    return(select(F, F:!=""))
}

void table_parse(string colvector T, string colvector FROM, string matrix TO)
{
    real scalar      i, j, r, c, l
    real colvector   p
    string rowvector s
    transmorphic     t
    
    t = tokeninit()
    tokenqchars(t, ("''", `""""', `"`""'"'))
    r = rows(T)
    FROM = TO = J(r,c=1,"")
    p = J(r,1,0) 
    for (i=1;i<=r;i++) {
        s = strtrim(subinstr(T[i],char(9)," "))
        // skip empty lines
        if (s=="") continue
        // skip comments
        if (substr(s,1,1)=="*") continue
        // skip header
        if (s=="{smcl}") {
            for (++i;i<=r;i++) { // find end
                s = strtrim(subinstr(T[i],char(9)," "))
                if (s=="{asis}") break
            }
            continue
        }
        // parse row
        tokenset(t, s)
        FROM[i] = strip_quotes(tokenget(t)) // first
        s = tokengetall(t)                  // rest
        l = length(s)
        for (j=l; j; j--) s[j] = strip_quotes(s[j])
        if (l==c)     TO[i,] = s
        else if (l<c) TO[|i,1 \ i,l|] = s
        else {
            TO = TO, J(r, l-c, "")
            c = l
            TO[i,] = s
        }
        p[i] = 1
    }
    FROM = select(FROM, p)
    TO   = select(TO, p)
}

string scalar strip_quotes(string scalar s)
{
    if (substr(s, 1, 1)=="'") {              // '...'
        if (substr(s, -1, 1)=="'")           return(substr(s, 2, strlen(s)-2))
    }
    else if (substr(s, 1, 1)==`"""') {       // "..."
        if (substr(s, -1, 1)==`"""')         return(substr(s, 2, strlen(s)-2))
    }
    else if (substr(s, 1, 2)=="`" + `"""') { // `"..."'
        if (substr(s, -2, 2)==`"""' + "'")   return(substr(s, 3, strlen(s)-4))
    }
    return(s)
}

void casefcn_read(string scalar nm, string scalar tmpf)
{
    real scalar      r, i, fh
    string scalar    fn
    string colvector T
    
    fn = findfile("_cwcasefcn_" + nm + ".sthlp")
    if (fn=="") {
        errprintf("case function {bf:case.%s()} not found\n", nm)
        exit(111)
    }
    T = cat(fn)
    r = rows(T)
    fh = fopen(tmpf, "w")
    for (i=1;i<=r;i++) {
        if (strtrim(T[i])=="{smcl}") {
            for (++i;i<=r;i++) { // find end
                if (strtrim(T[i])=="{asis}") break
            }
            continue
        }
        fput(fh, T[i])
    }
    fclose(fh)
}

void labels_find(string scalar nm)
{
    pointer scalar p

    if (findfile("_cwfcn_labels_" + nm + ".sthlp")!="") return
    p = findexternal("_CROSSWALK_DB")
    if (p!=NULL) {
        if (asarray_contains(*p, "labels_"+nm)) return
    }
    errprintf("{it:lblset} {bf:%s} not found\n", nm)
    exit(111)
}

void labels_set(string scalar lblname, string rowvector vnames,
    string scalar lblset, real scalar modify, real scalar minimal)
{
    real scalar            i, n, hasmis
    real colvector         p
    transmorphic colvector values
    string matrix          labels
    
    // get label definitions
    table_parse(table_load("labels_"+lblset), values="", labels="")
    values = strtoreal(values)
    if (cols(labels)>1) labels = labels[,1]
    // value must be integer or extended missing
    p = selectindex((values:==trunc(values)) :& (values:!=.))
    if (length(p)<rows(values)) {
        printf("{p 0 0 2}{txt}("+
            "invalid label definitions found in {it:lblset} {bf:%s}; " +
            "values must be integer or extended missing; " +
            "invalid values ignored" +
            "){p_end}", lblset)
        values = values[p]; labels = labels[p]
    }
    // drop duplicates (use last)
    if (anyof(p=mm_unique_tag(values,2),0)) {
        p = selectindex(p)
        values = values[p]; labels = labels[p]
    }
    // case 1: no variables specified
    n = length(vnames)
    if (n==0) {
        if (modify==0) {
            if (st_vlexists(lblname)) st_vldrop(lblname)
        }
        if (length(values)) st_vlmodify(lblname, values, labels)
        st_local("lblnames", lblname)
        return
    }
    // case 2: variables specified, but no lblname
    hasmis = any(values:>=.)
    if (lblname=="") {
        for (i=n; i; i--) {
            if (modify==0) {
                if (st_vlexists(vnames[i])) st_vldrop(vnames[i])
            }
            st_varvaluelabel(vnames[i], vnames[i])
            if (minimal) {
                if (hasmis) p = labels_minim_hash(values, vnames[i])
                else        p = labels_minim(values, vnames[i])
                if (p!=.) {
                    if (length(p)) st_vlmodify(vnames[i], values[p], labels[p])
                }
                else st_vlmodify(vnames[i], values, labels)
            }
            else st_vlmodify(vnames[i], values, labels)
        }
        st_local("lblnames", invtokens(vnames))
        return
    }
    // case 3: both specified (use same set for all variables)
    if (modify==0) {
        if (st_vlexists(lblname)) st_vldrop(lblname)
    }
    for (i=n; i; i--) st_varvaluelabel(vnames[i], lblname)
    if (minimal) {
        if (hasmis) p = labels_minim_hash(values, vnames)
        else        p = labels_minim(values, vnames)
        if (p!=.) {
            values = values[p]; labels = labels[p]
        }
    }
    if (length(values)) st_vlmodify(lblname, values, labels)
    st_local("lblnames", lblname)
}

real colvector labels_minim(real colvector values, string rowvector vnames)
{
    real scalar    i, j, jj, r, v, offset, n
    real rowvector minmax
    real colvector idx, p
    
    // set up permutation vector to select relevant values
    r = rows(values)
    minmax = minmax(values)
    offset = minmax[1] - 1; n = minmax[2] - minmax[1] + 1
    idx = values :- offset // so that idx in {1,...,n}
    p = J(n, 1, .)
    p[idx] = J(r, 1, 0)
    
    // go through data and mark existing values
    for (j=length(vnames); j; j--) {
        jj = st_varindex(vnames[j])
        for (i=st_nobs(); i; i--) {
            v = _st_data(i,jj) - offset
            if (v<1) continue
            if (v>n) continue
            if (v!=trunc(v)) continue
            if (p[v]!=0) continue
            p[v] = 1
            r--
            if (!r) return(.) // done (all values exist in data)
        }
    }
    return(selectindex(p[idx]))
}

real colvector labels_minim_hash(real colvector values, string rowvector vnames)
{
    real scalar    i, j, jj, r, v
    real colvector p
    real matrix    a
    transmorphic   A
    
    // set up asarray
    A = asarray_create("real")
    r = length(values)
    for (i=r; i; i--) asarray(A, values[i], 0)
    
    // check values
    for (j=length(vnames); j; j--) {
        jj = st_varindex(vnames[j])
        for (i=st_nobs(); i; i--) {
            v = _st_data(i,jj)
            if (v!=trunc(v)) continue
            if (v==.) continue
            a = asarray(A, v)
            if (a!=0) continue
            asarray(A, v, 1)
            r--
            if (!r) return(.) // done (all values exist in data)
        }
    }
    
    // collect result
    r = length(values)
    p = J(r,1,0)
    for (i=r; i; i--) p[i] = asarray(A, values[i])
    return(selectindex(p))
}

end

exit
