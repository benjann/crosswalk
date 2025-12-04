*! version 1.0.6  04dec2025  Ben Jann

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
        gettoken subcmd rest : 0, parse(" ,")
        if `"`subcmd'"'==substr("label", 1, max(1, strlen(`"`subcmd'"'))) {
            _cw_label `rest'
            exit
        }
        if `"`subcmd'"'==substr("define", 1, max(1, strlen(`"`subcmd'"'))) {
            _cw_define `rest'
            exit
        }
        if `"`subcmd'"'=="save" {
            _cw_save `rest'
            exit
        }
        if `"`subcmd'"'==substr("dir", 1, max(2, strlen(`"`subcmd'"'))) {
            _cw_dir `rest'
            exit
        }
        if `"`subcmd'"'=="drop" {
            _cw_drop `rest'
            exit
        }
        if `"`subcmd'"'=="clear" {
            _cw_clear `rest'
            exit
        }
        if `"`subcmd'"'=="list" {
            _cw_list `rest'
            exit
        }
        if `"`subcmd'"'=="import" {
            _cw_import `rest'
            exit
        }
        if `"`subcmd'"'=="post" {
            _cw_post `rest'
            exit
        }
        if `"`subcmd'"'=="export" {
            _cw_export `rest'
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
    
    // get prefix and position of "_to_" (if specified)
    local tmp = strpos(`"`fcn'"',".")
    if (`tmp') {
        local prefix = substr(`"`fcn'"',1,`tmp'-1)
        local fcn    = substr(`"`fcn'"',`tmp'+1,.)
        local posofto = strpos(`"`fcn'"',"_to_")
        if `posofto' {
            local posofto = `posofto' + strlen(`"`prefix'"') + 1
        }
        local fcn `"`prefix'_`fcn'"'
    }
    else local posofto = strpos(`"`fcn'"',"_to_")
    if (strlen(`"`fcn'"')<(`posofto'+4)) local posofto 0
    
    // rest of syntax
    syntax name(name=generate) [if] [in] [, Replace NOLabel Label(str)/*
        */ MISsing COPYrest COPYrest2(str) COPYMISsing COPYMISsing2(str)/*
        */ NOINFO out(name) STRing NUMeric/*
        */ DUPlicates(str) EXPANDok fast ] // expandok is old syntax
    if `"`duplicates'"'=="" & "`expandok'"!="" local duplicates expand
    _parse_dupl, `duplicates' // returns dupl and duplicates
    if "`string'"!="" & "`numeric'"!="" {
        di as err "{bf:string} and {bf:numeric} not both allowed"
        exit 198
    }
    if `dupl'>2 & "`string'"=="" local numeric numeric
    if `"`copyrest2'"'!="" {
        local copyrest copyrest
        _parse_copyrest, `copyrest2'
    }
    if `"`copymissing2'"'!="" {
        local copymissing copymissing
        _parse_copymissing, `copymissing2'
    }
    if "`copyrest'"!="" {
        if `str0' {
            if "`numeric'"=="" local string string
            local copyrest_nolabel nolabel
        }
        else {
            if "`string'"=="" local numeric numeric
            else              local copyrest_nolabel nolabel
            if "`missing'"=="" {
                local copymissing copymissing
                local copymissing_nolabel nolabel
            }
        }
    }
    if "`copymissing'"!="" {
        if "`missing'"!="" {
            di as err "only one of {bf:missing} and {bf:copymissing} allowed"
            exit 198
        }
        if `str0' {
            di as txt "(source variable is string; {cmd:copymissing} ignored)"
            local copymissing
        }
        else if "`string'"=="" local numeric numeric
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
        if `posofto' {
            local label = substr(`"`fcn'"',`posofto'+4,.)
            if `"`prefix'"'!="" local label `"`prefix'_`label'"'
            capt mata: labels_find(st_local("label"))
            if _rc==1 exit 1
            if _rc local label // no labels found
        }
    }
    
    // preserve data
    if "`duplicates'"=="expand" & "`fast'"=="" preserve
    
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
    mata: crosswalk(`"`fcn'"', `"`prefix'"', `posofto', `dupl', "`xvar'",/*
        */ "`CASE'", "`newvar'", "`touse'", "`string'"!="", "`numeric'"!="",/*
        */ "`copyrest'"!="", "`noinfo'"!="", "`OUT'")
    local str1 = (substr("`:type `newvar''",1,3)=="str")
    if "`duplicates'"=="expand" {
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
        _copy_missing `str1' `xvar' `newvar' `touse0' `copymissing_nolabel'
    }
    
    // display info levels of X not covered by the translator
    if "`noinfo'"=="" {
        if `r_out' {
            if `r_out'==1  local msg "{stata di r(levels_out):`r_out' level}"
            else           local msg "{stata di r(levels_out):`r_out' levels}"
            di as txt "(`msg' of {bf:`xvar'} not matched)"
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
    if "`duplicates'"=="expand" & "`fast'"=="" restore, not
    
    // returns
    if "`noinfo'"=="" {
        ret local levels_out: list clean levels_out
        ret scalar r_out = `r_out'
    }
    ret local duplicates "`duplicates'"
    ret local fn_casefcn `"`fn_casefcn'"'
    ret local case       `"`case'"'
    ret local varname    `xvar'
    ret local newvar     `generate'
    ret local fn_lblset  `"`fn_lblset'"'
    ret local lblset     `"`label'"'
    ret local pfx        `"`prefix'"'
    ret local fn         `"`fn'"'
    ret local fcn        `"`fcn'()"'
    ret scalar string    = `str1'
    if "`duplicates'"=="expand" ret scalar N_add = `nadd'
end

program _parse_dupl
    local Stats First Last min max mean
    //   dupl = 1     2    3   4   5
    local stats = strlower("`Stats'")
    syntax [, expand `Stats' ]
    local dupl 0
    local duplicates
    if "`expand'"!="" {
        local dupl -1
        local duplicates "`expand'"
    }
    local i 0
    foreach stat of local stats {
        local ++i
        if "``stat''"=="" continue
        if `dupl' {
            di as err "only one keyword allowed in {bf:duplicates()}"
            exit 198
        }
        local dupl `i'
        local duplicates "`stat'"
    }
    c_local dupl `dupl'
    c_local duplicates `duplicates'
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
    local anything: subinstr local anything "." "_" // "pfx.name"=>"pfx_name"
    c_local label `"`anything'"'
    c_local label_minimal `minimal'
end

program _copy_missing
    args str xvar newvar touse nolabel
    if `str' {
        qui replace `newvar' = strofreal(`xvar') if `touse' & `xvar'>.
        exit
    }
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
    ret local newvar     `generate'
    ret local fn_casefcn `"`fn_casefcn'"'
    ret local casefcn    `"case.`fcn'()"'
end

program __cw_case
    gettoken fcn 0 : 0
    tempfile tmpf
    mata: casefcn_read(st_local("fcn"), st_local("tmpf"))
    run `"`tmpf'"' `0'
    c_local fn_casefcn `"`fn'"'
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
    local label: subinstr local label "." "_" // "pfx.name"=>"pfx_name"
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
    return local varlist   "`varlist'"
    return local lblname   "`lblnames'"
    return local fn_lblset `"`fn_lblset'"'
    return local lblset    "`label'"
end

program _cw_define, rclass
    _parse_fcn 0 `0' // strip () from fcn()
    syntax name
    mata: table_define(st_local("namelist"))
    di as txt "(crosswalk table {bf:`namelist'()} defined)"
    return local fcn `"`namelist'()"'
end

program _cw_save, rclass
    _parse comma fcn 0 : 0
    syntax [, Replace path(str) ]
    _parse_fcn 0 `fcn' // strip () from fcn()
    syntax name
    local fn `"_cwfcn_`namelist'.sthlp"'
    if `"`path'"'!="" {
        mata: _checkdir(st_local("path"))
        mata: st_local("fn", pathjoin(st_local("path"), st_local("fn")))
    }
    if "`replace'"=="" {
        confirm new file `"`fn'"'
    }
    mata: mm_outsheet(st_local("fn"), table_get(st_local("namelist")),/*
        */ "replace")
    di as txt "(crosswalk table {bf:`namelist'()} stored in file "/*
        */ `"{view `"`fn'"'})"'
    return local fcn `"`namelist'()"'
    return local fn `"`fn'"'
end

program _cw_dir, rclass
    if `"`0'"'!="" error 198
    mata: table_dir()
    return scalar n = `n'
    return local fcns `"`fcns'"'
end

program _cw_drop
    _parse_fcn 0 `0' // strip () from fcn()
    syntax name
    mata: table_drop(st_local("namelist"))
end

program _cw_clear
    if `"`0'"'!="" error 198
    mata: rmexternal("_CROSSWALK_DB")
end

program _cw_list, rclass
    _parse_fcn 0 `0' // strip () from fcn()
    syntax name
    mata: list_table(st_local("namelist"))
    return scalar r = `r'
    return local fn `"`fn'"'
end

program _cw_import, rclass
    _parse comma fcn 0 : 0
    syntax [, clear ]
    // strip () from fcn()
    _parse_fcn fcn `fcn' 
    if `"`fcn'"'!=="" {
        di as err "name required"
        exi 100
    }
    // clear option
    if "`clear'"=="" {
        if c(changed) error 4
    }
    // import fcn
    mata: import_table(st_local("fcn"))
    label data `"`fcn'()"'
    describe
    return add
    return local fn `"`fn'"'
end

program _cw_post, rclass
    _parse_fcn 0 `0' // strip () from fcn()
    syntax name
    mata: table_put(st_local("namelist"), data_to_table())
    di as txt "(crosswalk table {bf:`namelist'()} defined)"
    return local fcn `"`namelist'()"'
end

program _cw_export, rclass
    _parse comma fcn 0 : 0
    syntax [, Replace path(str) ]
    _parse_fcn 0 `fcn' // strip () from fcn()
    syntax name
    local fn `"_cwfcn_`namelist'.sthlp"'
    if `"`path'"'!="" {
        mata: _checkdir(st_local("path"))
        mata: st_local("fn", pathjoin(st_local("path"), st_local("fn")))
    }
    if "`replace'"=="" {
        confirm new file `"`fn'"'
    }
    mata: mm_outsheet(st_local("fn"), data_to_table(), "replace")
    di as txt "(crosswalk table {bf:`namelist'()} stored in file "/*
        */ `"{view `"`fn'"'})"'
    return local fcn `"`namelist'()"'
    return local fn `"`fn'"'
end

program _parse_fcn
    gettoken nm 0 : 0
    local 0: subinstr local 0 "." "_" // "pfx.name"=>"pfx_name"
    gettoken 0 rest : 0, parse("(")
    if `"`rest'"'!="" {
        gettoken args rest: rest, match(par)
        if "`par'"==""             error 198
        if strtrim(`"`args'"')!="" error 198
        if `"`rest'"'!=""          error 198
    }
    c_local `nm' `"`0'"'
end

version 14
mata:
mata set matastrict on

void crosswalk(string scalar fcn, string scalar pfx, real scalar posofto,
    real scalar dupl, string scalar xvar, string scalar CASE,
    string scalar newvar, string scalar touse, real scalar str,
    real scalar num, real scalar copyrest, real scalar noinfo,
    string scalar out)
{
    real scalar            i, n, Cok, nobs, Nadd, nadd
    string scalar          fn
    string matrix          F
    real colvector         C, null, id
    transmorphic colvector X, Y, FROM
    pointer scalar         d
    transmorphic matrix    T, TO
    
    // load main translator
    T = table_load(fcn, fn="", pfx!="") // fills in fn
    if (T!=J(0,0,.)) {
        F = table_alias(T)
        n = rows(F)
        if (!n) {
            F = (fcn, "")
            n = 1
        }
    }
    else { // only possible if pfx!=""
        F = table_alias_build(fcn, pfx, posofto)
        n = rows(F)
    }
    st_local("fn", fn)
    if (dupl<0) Nadd = 0 // (expand)
    // get data
    if (st_isstrvar(xvar)) st_sview(X="", ., xvar, touse)
    else                   st_view(X=., ., xvar, touse)
    if (CASE!="") C = st_data(., CASE, touse)
    Cok = !rows(C)
    Y = X
    nobs = rows(Y)
    null = J(nobs,1,0)
    if (dupl>2) id = 1::nobs
    // apply translator(s)
    for (i=1;i<=n;i++) {
        if (F[,1]!=fcn) T = table_load(F[i,1])
        table_parse(T, FROM="", TO="", F[i,2])
        if (!cols(TO)) TO = J(rows(TO),1,"")
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
        d = _cw_set_d(copyrest & i==n, missingof(TO), X, xvar)
        if (dupl<0) {
            nadd = _cw_expand(null, Y, C, FROM, TO, *d, F[i,1], Cok, touse)
            if (nadd & i<n) { // reload data for next translator if necessary
                if (st_isstrvar(xvar)) st_sview(X, ., xvar, touse)
                else                   st_view(X, ., xvar, touse)
                if (CASE!="") C = st_data(., CASE, touse)
            }
            Nadd = Nadd + nadd
            continue
        }
        if (dupl>2) {
            _cw_nonunique(null, id, Y, C, FROM, TO, *d, F[i,1], Cok,
                X, copyrest, i==n)
            continue
        }
        if      (dupl==1) _cw_dupl_select(FROM, TO, 1)
        else if (dupl==2) _cw_dupl_select(FROM, TO, 2)
        else if (rows(FROM) & !all(mm_unique_tag(FROM))) {
            errprintf("crosswalk table {bf:%s()} contains duplicate origin " +
                "values;\norigin values must be unique unless option " +
                "{helpb crosswalk##dupl:duplicates()} is specified\n", fcn)
            exit(498)
        }
        _cw_unique(null, Y, C, FROM, TO, *d, F[i,1], Cok)
    }
    if (dupl>2) _cw_nonunique_collapse(dupl, null, id, Y, nobs)
    if (!Cok) {
        printf("{p 0 0 2}{txt}(" +
               "argument {it:case} not used by {bf:%s()}" +
               "){p_end}\n", fcn)
    }
    // store result
    if (isstring(Y)) st_sstore(., st_addvar(_strtype(Y), newvar), touse, Y)
    else             st_store(., st_addvar(_dtype(Y), newvar), touse, Y)
    if (dupl<.) st_local("nadd", strofreal(Nadd)) // (expand)
    // collect info on values not covered by the translator
    if (out!="") st_store(., st_addvar("byte", out), touse, null)
    if (!noinfo) _info_out(null, X) // (assumes X is no longer needed)
}

pointer scalar _cw_set_d(real scalar xset, transmorphic scalar mv,
    transmorphic colvector X, string scalar xvar)
{
    if (!xset) return(&mv)
    if (isstring(mv)) {
        if (isstring(X)) return(&X)
        return(&strofreal(X, st_varformat(xvar)))
    }
    if (isstring(X)) return(&strtoreal(X))
    return(&X)
}

void _cw_dupl_select(transmorphic colvector FROM, transmorphic matrix TO,
    real scalar which) // 1 use first, 2 use last
{
    real colvector p
    
    if (!rows(FROM)) return // empty table
    p = selectindex(mm_unique_tag(FROM, which))
    FROM = FROM[p]; TO = TO[p,]
}

real scalar _cw_expand(real colvector null, transmorphic colvector Y,
    real colvector C, transmorphic colvector FROM, transmorphic matrix TO,
    transmorphic colvector d, string scalar fcn, real scalar Cok,
    string scalar touse)
{
    real scalar    n
    string scalar  E
    real colvector L
    
    // match and expand
    n = __cw_expand(null, Y, C, FROM, TO, d, fcn, Cok, L=.)
    // expand original data if needed
    if (n) {
        null = null \ J(n, 1, 0)
        E = st_tempname()
        st_store(., st_addvar("double", E), touse, 1 :+ L)
        stata("expand " + E + " if " + touse, 1)
        st_dropvar(E)
    }
    return(n)
}

real scalar __cw_expand(real colvector null, transmorphic colvector Y,
    real colvector C, transmorphic colvector FROM, transmorphic matrix TO,
    transmorphic colvector d, string scalar fcn, real scalar Cok,
    real colvector L)
{
    real scalar    n
    real colvector p
    pointer matrix P
    
    // check for duplicates
    p = _cw_duplcheck(FROM, TO) // (sorts table if there are duplicates)
    if (p==0) { // no duplicates
        _cw_unique(null, Y, C, FROM, TO, d, fcn, Cok)
        return(0)
    }
    // create pointer matrix containing destination values
    P = _cw_make_P(TO, p, L) // (fills in counts in L)
    // obtain ids of matches 
    p = _cw_match(null, Y, FROM[p])
    // count extra obs and expand original data if needed
    L = _cw_collect(null, p, 1, L, 0, "", .)
    n = sum(L)
    // collect pointers to destination values
    P = _cw_collect(null, p, C, P, NULL, fcn, Cok)
    // expand destination values
    Y = _cw_expand_P(P, L, d, n)
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

void _cw_nonunique(real colvector null, real colvector id,
    transmorphic colvector Y, real colvector C, transmorphic colvector FROM,
    transmorphic matrix TO, transmorphic colvector d, string scalar fcn,
    real scalar Cok, transmorphic colvector X, real scalar copyrest,
    real scalar last)
{
    real scalar    n
    real colvector L
    
    // match and expand
    n = __cw_expand(null, Y, C, FROM, TO, d, fcn, Cok, L=.)
    if (!n) return
    // expend null and id
    null = null \ J(n, 1, 0)
    _cw_nonunique_expand(id, L, n)
    // expand X and C if needed
    if (last) return
    if (copyrest) _cw_nonunique_expand(X, L, n)
    if (!rows(C)) return
    _cw_nonunique_expand(C, L, n)
}

void _cw_nonunique_expand(transmorphic colvector Y, real colvector L,
    real scalar n)
{
    real scalar i, l, a, b
    
    i = rows(Y)
    Y = Y \ J(n,1,missingof(Y))
    a = i + n + 1
    for (i=rows(L);i;i--) {
        l = L[i]
        if (!l) continue
        b = a - 1; a = a - l
        Y[|a\b|] = J(l,1,Y[i])
    }
}

void _cw_nonunique_collapse(real scalar dupl, real colvector null,
    real colvector id, transmorphic colvector Y, real scalar nobs)
{
    real scalar    a, b, i
    real colvector p, q, yi
    pointer scalar f
    
    if (isstring(Y)) {
        if      (dupl==3) f = &_cw_strmin()
        else if (dupl==4) f = &_cw_strmax()
        else              f = &_cw_strmean()
    }
    else {
        if      (dupl==3) f = &min()
        else if (dupl==4) f = &max()
        else              f = &mean()
    }
    p = mm_order(id,1,1) // stable sort
    q = selectindex(_mm_unique_tag(id[p]))
    assert(rows(q)==nobs)
    a = rows(id) + 1
    for (i=nobs;i;i--) {
        b = a - 1
        a = q[i]
        if (a==b) continue         // no match or no duplicates
        yi = select(Y[p[|a\b|]], !null[p[|a\b|]]) // use matched only
        if (!length(yi)) continue  // all non-matched
        Y[i] = (*f)(yi)            // note: p[a] is equal to i
        null[i] = 0                // treat as matched if at least one match
    }
    Y = Y[|1\nobs|]
    null = null[|1\nobs|]
}

string scalar _cw_strmin(string colvector S)
    return(strofreal(min(strtoreal(S))))

string scalar _cw_strmax(string colvector S)
    return(strofreal(max(strtoreal(S))))

string scalar _cw_strmean(string colvector S)
    return(strofreal(mean(strtoreal(S))))

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

void list_table(string scalar fcn)
{
    real scalar      i, r
    string scalar    fn
    string colvector T
    
    T = table_load(fcn, fn="") // fills in fn
    if (fn!="") printf("{txt}(listing crosswalk table from file %s)\n", fn)
    else        printf("{txt}(listing crosswalk table from memory)\n")
    r = rows(T)
    displayas("txt")
    for (i=1;i<=r;i++) printf("%s\n",T[i])
    st_local("r", strofreal(r))
    st_local("fn", fn)
}

void import_table(string scalar fcn)
{
    real scalar            j, c, brk
    string scalar          fn
    string colvector       T
    transmorphic colvector FROM
    transmorphic matrix    TO
    
    T = table_load(fcn, fn="") // fills in fn
    if (fn!="") printf("{txt}(importing crosswalk table from file %s)\n", fn)
    else        printf("{txt}(importing crosswalk table from memory)\n")
    table_parse(T, FROM="", TO="")
    c = cols(TO)
    brk = setbreakintr(0)
    stata("clear")
    st_addobs(rows(FROM))
    st_sstore(., st_addvar(_strtype(FROM), "v1"), FROM)
    for (j=1;j<=c;j++)
        st_sstore(., st_addvar(_strtype(TO[,j]), "v"+strofreal(1+j)), TO[,j])
    (void) setbreakintr(brk)
    st_local("fn", fn)
}

string colvector data_to_table()
{
    real scalar      j, k
    string colvector T, S
    
    T = J(st_nobs(),1,"")
    k = st_nvar()
    for (j=1;j<=k;j++) {
        if (st_isstrvar(j)) {
            S = st_sdata(., j)
            if (any(strpos(S, `"""'))) S = ("`" + `"""') :+ S :+ (`"""' + "'")
            else if (any(strpos(S, " "))) S = `"""' :+ S :+ `"""'
            else if (anyof(S, ""))        S = `"""' :+ S :+ `"""'
        }
        else S = strofreal(st_data(., j), st_varformat(j))
        if (j>1) S = " " :+ S
        T = T + S
    }
    return(T)
}

transmorphic matrix table_load(string scalar fcn, | string scalar fn,
    real scalar relax)
{
    transmorphic matrix T
    
    if (args()<3) relax = 0
    T = _table_load(fcn, fn) // fills in fn
    if (T==J(0,0,.)) {
        if (relax) return(T) // not found
        _table_notfound(fcn)
    }
    return(_table_clean(T))
}

void _table_notfound(string scalar fcn)
{
    errprintf("crosswalk table {bf:%s()} not found\n", fcn)
    exit(111)
}

string matrix _table_clean(string matrix T)
{
    real scalar    i, r
    real colvector p
    string scalar  s
    
    r = rows(T)
    p = J(r,1,0)
    for (i=1;i<=r;i++) {
        s = strtrim(subinstr(T[i],char(9)," "))
        if (s=="") continue              // skip empty line
        if (substr(s,1,1)=="*") continue // skip comment
        if (s=="{smcl}") {               // skip smcl section
            for (++i;i<=r;i++) {
                s = strtrim(subinstr(T[i],char(9)," "))
                if (s=="{asis}") break  // end of smcl section
            }
            continue
        }
        T[i] = s
        p[i] = 1
    }
    p = selectindex(p)
    if (length(p)) return(T[p])
    else           return(J(0,1,""))
}

transmorphic matrix _table_load(string scalar fcn, string scalar fn)
{   // returns J(0,0,.) if table is not found
    transmorphic matrix T
    
    T = _table_get(fcn)
    if (T!=J(0,0,.)) return(T)
    return(_table_read(fcn, fn)) // fills in fn
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

string colvector table_get(string scalar fcn)
{
    string colvector T
    
    T = _table_get(fcn)
    if (T!=J(0,0,.)) return(T)
    _table_notfound(fcn)
}

transmorphic matrix _table_get(string scalar nm)
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

void table_drop(string scalar nm)
{
    pointer scalar   p

    p = findexternal("_CROSSWALK_DB")
    if (p!=NULL) {
        if (asarray_contains(*p, nm)) {
            asarray_remove(*p, nm)
            printf("{txt}(crosswalk table {bf:%s()} dropped)\n", nm)
            return
        }
    }
    printf("{txt}(crosswalk table {bf:%s()} not found; nothing to do)\n", nm)
}

transmorphic matrix _table_read(string scalar nm, string scalar fn)
{   // returns J(0,0,.) if table is not found
    fn = findfile("_cwfcn_" + nm + ".sthlp")
    if (fn=="") return(J(0,0,.))
    return(cat(fn))
}

string matrix table_alias(string colvector T)
{   // returns J(0,2,"") if T is not an alias list
    real scalar   i, r, l
    string scalar s, ocol
    string matrix F
    
    r = rows(T)
    F = J(r,2,"")
    for (i=1;i<=r;i++) {
        s = T[i]
        if (substr(s,1,1)!=".") return(J(0,2,"")) // alias must start with "."
        if (strpos(s," "))      return(J(0,2,"")) // blanks not allowed in alias
        ocol = ""
        if (l=strpos(s,"(")) { // check ()
            if (substr(s,-1,1)==")") {
                ocol = substr(s,l+1,strlen(s)-l-1)
                s = substr(s,1,l-1)
            }
        }
        if (strlen(s)<2) return(J(0,2,"")) // alias name missing
        F[i,] = (substr(s,2,.), ocol)
    }
    return(select(F, F[,1]:!=""))
}

string matrix table_alias_build(string scalar fcn, string scalar pfx,
    real scalar posofto)
{
    string scalar lnk, orig, dest
    
    if (!posofto) _table_notfound(fcn) // fcn not <origin>_to_<destination>
    lnk  = _table_alias_build_lnk(fcn, pfx) // get link
    orig = substr(substr(fcn, 1, posofto-1), strlen(pfx)+2, .)
    dest = substr(fcn, posofto+4, .)
    return(_table_alias_build(fcn, pfx + "_" + orig + "_to_" + lnk) \
           _table_alias_build(fcn, pfx + "_" + lnk + "_to_" + dest))
}

string matrix _table_alias_build(string scalar fcn, string scalar fcn2)
{
    string matrix       F
    transmorphic matrix T
    
    T = table_load(fcn2, "", 1)
    if (T==J(0,0,.)) {
        errprintf("cannot build wrapper for {bf:%s()}\n", fcn)
        _table_notfound(fcn2)
    }
    F = table_alias(T)
    if (!rows(F)) F = (fcn2, "") // fcn2 is not an alias list
    return(F)
}

string scalar _table_alias_build_lnk(string scalar fcn, string scalar pfx)
{
    string scalar fn, lnk
    string matrix T
    
    lnk = ""
    fn = findfile("_cwlink_" + pfx + ".sthlp")
    if (fn!="") {
        T = _table_clean(cat(fn))
        if (length(T)==1) {
            T = tokens(T)
            if (length(T)==1) lnk = strtrim(T)
        }
    }
    if (length(tokens(lnk))!=1) {
        errprintf("cannot build wrapper for {bf:%s()}\n", fcn)
        errprintf("{bf:%s} not found or invalid\n", "_cwlink_" + pfx + ".sthlp")
        exit(111)
    }
    return(lnk)
}

void table_parse(string colvector T, string colvector FROM, string matrix TO,
    | string scalar OCOL)
{
    real scalar      i, j, r, c, l, ocol
    real colvector   p
    string rowvector s
    transmorphic     t
    
    if (OCOL!="") ocol = strtoreal(OCOL) // column containing origin values
    else          ocol = 1
    t = tokeninit()
    tokenqchars(t, ("''", `""""', `"`""'"'))
    r = rows(T)
    FROM = J(r,1,""); TO = J(r,c=0,"")
    p = J(r,1,0) 
    for (i=1;i<=r;i++) {
        tokenset(t, T[i])
        if (ocol==1) {
            FROM[i] = strip_quotes(tokenget(t)) // first
            s = tokengetall(t)                  // rest
            l = length(s)
        }
        else {
            s = tokengetall(t)
            l = length(s)
            if (ocol>0 & ocol<=l) {
                FROM[i] = strip_quotes(s[ocol])
                if (l>1) s = select(s, (1..l):!=ocol)
                else     s = J(0,1,"")
                l = length(s)
            }
            else FROM[i] = ""
        }
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
    st_local("fn", fn)
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
    string scalar          fn
    real colvector         p
    transmorphic colvector values
    string matrix          labels
    
    // get label definitions
    table_parse(table_load("labels_"+lblset, fn=""), values="", labels="")
    st_local("fn_lblset", fn)
    values = strtoreal(values)
    if      (!cols(labels))  labels = J(rows(labels),1,"")
    else if (cols(labels)>1) labels = labels[,1]
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

void _checkdir(string scalar path)
{
    if (!direxists(path)) {
        errprintf("directory '%s' does not exist\n", path)
        exit(499)
    }
}

end

exit
