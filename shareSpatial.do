//parent socTraSocCapW6.do
clear                                  
capture set maxvar 10000
version 14                             
set more off                           
run ~/papers/root/do/aok_programs.do
loc pap shareSpatial
loc tmp /home/aok/misc/grants/poland/leszekMorawskiVistula/shareSpatial/tmp/
cap mkdir `tmp'

! time stata -b do  /home/aok/misc/grants/poland/leszekMorawskiVistula/creW6.do  &
//! time stata -b do /home/aok/misc/grants/poland/leszekMorawskiVistula/creW4.do  & 
//meh just do w6; dofiule for w4 out of date
use /tmp/shareElderly/allW6.dta,clear
ren swb ls
la var ls "life satisfaction"
encode iso, gen(isoN)
//replace isoS=18-isoS //so that its alphabetically on graph BUG this would mess it up!

//TODO explain in caption full meaning
la var VCO1 "none"	       
la var VCO2 "less"	       
la var VCO3 "month"
la var VCO4 "week" 
la var VCO5 "day"


**** descriptive stats

 
rm /tmp/a.txt
levelsof iso, loc(iso) 
foreach i in `iso'{ 
sum  ls casp  if iso=="`i'" //did sum; dont know hwo to get mean in macro from moean
loc beta= r(mean)
mean ls casp  if iso=="`i'" //guess need to run mean for est sto to work
est sto `i'
! echo `beta' , `i' "||" >> /tmp/a.txt
}
! sort -k1 -n -t "," /tmp/a.txt>/tmp/sort.txt
! cut -f1 -d"," --complement /tmp/sort.txt > /tmp/z.txt
! cat /tmp/z.txt | tr '\n' ' ' > /tmp/z2.txt
file open myfile using "/tmp/z2.txt", read 
file read myfile line
file close myfile
coefplot `line',  bycoefs byopts(xrescale)     //byopts(compact cols(1))
dy
gr export `tmp'ls-casp-means.pdf


rm /tmp/a.txt
levelsof iso, loc(iso) 
foreach i in `iso'{ 
sum  volCha volChaOft  if iso=="`i'" //did sum; dont know hwo to get mean in macro from moean
loc beta= r(mean)
mean volCha volChaOft  if iso=="`i'" //guess need to run mean for est sto to work
est sto `i'
! echo `beta' , `i' "||" >> /tmp/a.txt
}
! sort -k1 -n -t "," /tmp/a.txt>/tmp/sort.txt
! cut -f1 -d"," --complement /tmp/sort.txt > /tmp/z.txt
! cat /tmp/z.txt | tr '\n' ' ' > /tmp/z2.txt
file open myfile using "/tmp/z2.txt", read 
file read myfile line
file close myfile
coefplot `line',  bycoefs byopts(xrescale)     //byopts(compact cols(1))
dy
gr export `tmp'volCha-volChaOft-means.pdf,replace


//TODO think about these below and giess add some to paper!

//rhfo
rm /tmp/a.txt
levelsof iso, loc(iso) 
foreach i in `iso'{ 
sum   ghto ghih  volCha  if iso=="`i'" //did sum; dont know hwo to get mean in macro from moean
loc beta= r(mean)
mean  ghto ghih  volCha  if iso=="`i'" //guess need to run mean for est sto to work
est sto `i'
! echo `beta' , `i' "||" >> /tmp/a.txt
}
! sort -k1 -n -t "," /tmp/a.txt>/tmp/sort.txt
! cut -f1 -d"," --complement /tmp/sort.txt > /tmp/z.txt
! cat /tmp/z.txt | tr '\n' ' ' > /tmp/z2.txt
file open myfile using "/tmp/z2.txt", read 
file read myfile line
file close myfile
coefplot `line',  bycoefs byopts(xrescale  row(1)) //byopts(compact cols(1))
dy 



rm /tmp/a.txt
levelsof iso, loc(iso) 
foreach i in `iso'{ 
sum   casp ghto  if iso=="`i'" //did sum; dont know hwo to get mean in macro from moean
loc beta= r(mean)
mean  casp ghto  if iso=="`i'" //guess need to run mean for est sto to work
est sto `i'
! echo `beta' , `i' "||" >> /tmp/a.txt
}
! sort -k1 -n -t "," /tmp/a.txt>/tmp/sort.txt
! cut -f1 -d"," --complement /tmp/sort.txt > /tmp/z.txt
! cat /tmp/z.txt | tr '\n' ' ' > /tmp/z2.txt
file open myfile using "/tmp/z2.txt", read 
file read myfile line
file close myfile
coefplot `line',  bycoefs byopts(xrescale  row(1)) //byopts(compact cols(1))
dy 



rm /tmp/a.txt
levelsof iso, loc(iso) 
foreach i in `iso'{ 
sum   casp volCha  if iso=="`i'" //did sum; dont know hwo to get mean in macro from moean
loc beta= r(mean)
mean  casp volCha  if iso=="`i'" //guess need to run mean for est sto to work
est sto `i'
! echo `beta' , `i' "||" >> /tmp/a.txt
}
! sort -k1 -n -t "," /tmp/a.txt>/tmp/sort.txt
! cut -f1 -d"," --complement /tmp/sort.txt > /tmp/z.txt
! cat /tmp/z.txt | tr '\n' ' ' > /tmp/z2.txt
file open myfile using "/tmp/z2.txt", read 
file read myfile line
file close myfile
coefplot `line',  bycoefs byopts(xrescale  row(1)) //byopts(compact cols(1))
dy 


rm /tmp/a.txt
levelsof iso, loc(iso) 
foreach i in `iso'{ 
sum   hnetw pen  if iso=="`i'" //did sum; dont know hwo to get mean in macro from moean
loc beta= r(mean)
mean  hnetw pen  if iso=="`i'" //guess need to run mean for est sto to work
est sto `i'
! echo `beta' , `i' "||" >> /tmp/a.txt
}
! sort -k1 -n -t "," /tmp/a.txt>/tmp/sort.txt
! cut -f1 -d"," --complement /tmp/sort.txt > /tmp/z.txt
! cat /tmp/z.txt | tr '\n' ' ' > /tmp/z2.txt
file open myfile using "/tmp/z2.txt", read 
file read myfile line
file close myfile
coefplot `line',  bycoefs byopts(xrescale  row(1)) //byopts(compact cols(1))
dy 

TODO
denmark adn sweden--super low pension and hhnwtw! is thsi possible?? lm!




**** regressions




rm /tmp/a.txt
levelsof iso, loc(iso) 
foreach i in `iso'{ 
//reg casp volCha if iso=="`i'" 
reg casp volCha pen ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 labInc ub sa disab   hnetw male mar emp age age2  yedu ngrchild disabled mobility health [pw=cciw_w6] if iso=="`i'", beta robust  
loc beta= _b[volCha]
est sto `i'
! echo `beta' , `i' "||" >> /tmp/a.txt
}
! sort -k1 -n -t "," /tmp/a.txt>/tmp/sort.txt
! cut -f1 -d"," --complement /tmp/sort.txt > /tmp/z.txt
! cat /tmp/z.txt | tr '\n' ' ' > /tmp/z2.txt
file open myfile using "/tmp/z2.txt", read 
file read myfile line
file close myfile
coefplot `line', keep(volCha) bycoefs byopts(xrescale) xline(0)    //byopts(compact cols(1))
dy
gr export `tmp'reg-volCha.pdf,replace



//sth weird witch CZE!
preserve
drop if iso=="CZE"
rm /tmp/a.txt
levelsof iso, loc(iso) 
foreach i in `iso'{ 
//reg casp volCha if iso=="`i'" 
reg casp volCha pen ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 labInc ub sa disab   hnetw male mar emp age age2  yedu ngrchild disabled mobility health [pw=cciw_w6] if iso=="`i'", beta robust  
loc beta= _b[pen]
est sto `i'
! echo `beta' , `i' "||" >> /tmp/a.txt
}
! sort -k1 -n -t "," /tmp/a.txt>/tmp/sort.txt
! cut -f1 -d"," --complement /tmp/sort.txt > /tmp/z.txt
! cat /tmp/z.txt | tr '\n' ' ' > /tmp/z2.txt
file open myfile using "/tmp/z2.txt", read 
file read myfile line
file close myfile
coefplot `line', keep(pen) bycoefs byopts(xrescale) xline(0)    //byopts(compact cols(1))
dy
restore
gr export `tmp'pen-means.pdf,replace




** social transfers

//LATER:thereis also looking after grandchildern,but guess not in imputed and many many missing


/*A:
1 income:
2 labor
3 replacement (instead of labor, emerytury, renty etc)
4 transfers 
*/

//inc--guess would count tings again
reg ls labInc i.country [pw=cciw_w6], beta robust
estadd beta
est sto a1

d pen ub sa disab
corr pen ub sa disab 
sum pen ub sa disab
count
count if pen>0
count if ub>0
count if sa>0
count if disab>0

reg ls labInc  pen i.country [pw=cciw_w6], beta robust
estadd beta
est sto a2

//neg even contrlling for hea and emp
//reg ls labInc inc pen ub sa disab hea emp, beta robust

//liab otrf--guess already incl in hnetw
reg ls labInc  pen ub sa disab    hnetw i.country [pw=cciw_w6], beta robust //missing for many perho
estadd beta
est sto a3

reg ls labInc pen ub sa disab   hnetw male mar emp age age2  yedu ngrchild disabled mobility health i.country [pw=cciw_w6], beta robust //missing for many perho
estadd beta
est sto a4

reg casp labInc i.country [pw=cciw_w6], beta robust
estadd beta
est sto a5

reg casp labInc  pen i.country [pw=cciw_w6], beta robust
estadd beta
est sto a6

reg casp labInc  pen ub sa disab    hnetw i.country [pw=cciw_w6], beta robust 
estadd beta
est sto a7

reg casp labInc pen ub sa disab   hnetw male mar emp age age2  yedu ngrchild disabled mobility health i.country [pw=cciw_w6], beta robust 
estadd beta
est sto a8



estout a* ,style(tab)  cells(beta(star fmt(%9.2f))) replace  collabels(, none) stats(N, labels("N")fmt(%9.0f))

estout a1 a2 a3 a4 a5 a6 a7 a8 using `tmp'regAw6.tex,style(tex)  cells(beta(star fmt(%9.2f))) replace  collabels(, none) stats(N, labels("N")fmt(%9.0f))drop(*country*)varlabels(_cons constant) label starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001)
//in w6 pensions negative and only later flip to positive--explanation--collinearity--they pick up from other bad stuff like bad health etc!! and once control for these all good then  
//! sed -i '/^constant/i\country dummies&no&no&no&no&yes\\\\' `tmp'regAw6.tex
! sed -i '1 i\&\\multicolumn{4}{c}{Life satisfaction}&\\multicolumn{4}{c}{CASP}\\\\' `tmp'regAw6.tex


** social capital


/*B:
1 volunteering only
2 soc cap ac vars
3 income
4 other controls
*/

//no ac035d6 in w6!!

reg ls VCO2-VCO5 i.country [pw=cciw_w6], robust beta
estadd beta
est sto b1
reg ls VCO2-VCO5 ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 i.country [pw=cciw_w6], robust beta 
estadd beta
est sto b2

d ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10

reg ls VCO2-VCO5 ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 emp i.country [pw=cciw_w6], robust beta
estadd beta
est sto b3


reg ls VCO2-VCO5 ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 male mar emp age age2  yedu ngrchild disabled mobility health i.country [pw=cciw_w6], beta robust 
estadd beta
est sto b4


reg casp VCO2-VCO5 i.country [pw=cciw_w6], robust beta
estadd beta
est sto b5
reg casp VCO2-VCO5 ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 i.country [pw=cciw_w6], robust beta 
estadd beta
est sto b6

d ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10


reg casp VCO2-VCO5 ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 emp i.country [pw=cciw_w6], robust beta
estadd beta
est sto b7

reg casp VCO2-VCO5 ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 male mar emp age age2  yedu ngrchild disabled mobility health i.country [pw=cciw_w6], beta robust 
estadd beta
est sto b8



estout b* ,style(tab)  cells(beta(star fmt(%9.2f))) replace  collabels(, none) stats(N, labels("N")fmt(%9.0f))

estout b* using `tmp'regBw6.tex,style(tex)  cells(beta(star fmt(%9.2f))) replace  collabels(, none) stats(N, labels("N")fmt(%9.0f))drop(_cons *country*)varlabels(_cons constant) label starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001)

//! sed -i '/^constant/i\country dummies&no&no&no&yes\\\\' `tmp'regBw6.tex
! sed -i '/^volChaOft==less often/i\\{voluntary or charity work:}&&&&\\\\' `tmp'regBw6.tex
! sed -i 's/volChaOft==/\\hspace{.25in}/g' `tmp'regBw6.tex
! sed -i '1 i\&\\multicolumn{4}{c}{Life satisfaction}&\\multicolumn{4}{c}{CASP}\\\\' `tmp'regBw6.tex



**C: substytucja

 
reg ls VCO2-VCO5 pen ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 i.country [pw=cciw_w6], robust beta
estadd beta
est sto c1


reg ls VCO2-VCO5 pen ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 labInc ub sa disab   hnetw male mar emp age age2  yedu ngrchild disabled mobility health i.country [pw=cciw_w6], beta robust  
estadd beta
est sto c2

corr ls casp

reg casp VCO2-VCO5 pen ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 i.country [pw=cciw_w6], robust beta
estadd beta
est sto c3


reg casp VCO2-VCO5 pen ac035d4 ac035d5  ac035d7 ac035d8 ac035d9 ac035d10 labInc ub sa disab   hnetw male mar emp age age2  yedu ngrchild disabled mobility health i.country [pw=cciw_w6], beta robust  
estadd beta
est sto c4

estout c* ,style(tab)  cells(beta(star fmt(%9.3f))) replace  collabels(, none) stats(N, labels("N")fmt(%9.0f))

estout c1 c2 c3 c4 using `tmp'regCw6.tex,style(tex)  cells(beta(star fmt(%9.2f))) replace  collabels(, none) stats(N, labels("N")fmt(%9.0f))drop(_cons *country*) label starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001)
//yay so actually stronger effect than in w4 :) so no more 2/3 of effect if anything stronger on volunteering!!

! sed -i '1 i\&\\multicolumn{2}{c}{Life satisfaction}&\\multicolumn{2}{c}{CASP}\\\\' `tmp'regCw6.tex
//! sed -i '/^constant/i\country dummies&no&no&yes&yes&no&no&yes&yes\\\\' `tmp'regCw6.tex
! sed -i '/^volChaOft==less often/i\\{voluntary or charity work:}&&&&&&&&\\\\' `tmp'regCw6.tex
! sed -i 's/volChaOft==/\\hspace{.25in}/g' `tmp'regCw6.tex













//------------------------old crap below----------------------------------
//------------------------old crap below----------------------------------
//------------------------old crap below----------------------------------
//------------------------old crap below----------------------------------
//------------------------old crap below----------------------------------



//TODOand have commands in the template like aokhist listtex stepwise etc

have most of the stuff outputted to online appendix:)--start with that and then
select stuff to paper--have brief narrative describng patterns in online app too

have one section for data mining that outputs graphs scatterplots lfits forrestplots dotplots and
regressions to res in pdf and one that actually does stuff for the paper !!!

and have commands in the template like aokhist listtex stepwise etc

*E.G. many additional vars commented out that can be used in the future  
* double check everything with "assert" inspect etc

rememebr to run!!
git add *.do *.tex  *.org -n

clear                                  
capture set maxvar 10000
version 14                             
set more off                           
run ~/papers/root/do/aok_programs.do

loc pap XXX
loc d = "/home/aok/papers/" + "`pap'" + "/"

capture mkdir `d'tex                 
capture mkdir `d'scr
capture mkdir /tmp/`pap'

loc tmp /tmp/`pap'/

//file open tex using `d'out/tex, write text replace
//file write tex `"%<*ginipov>`:di  %9.2f `r(rho)''%</ginipov>"' 

file open f using `d'notes.txt, write replace
file write f  "a note...." _n _n


**** dat_man


insheet using ~/data/data_sources.csv, names clear
list  if regexm(tag, "seg")



**** sum_sts


aok_var_des , ff(cre00 boh00 art90 chu_per50 mem_per50 totrt adj) fname(`tmp'var_des)
aok_histograms for the appendix
TODO add more aok_cool programs ! :))

logout, tex save(`tmp'aha) replace: sum happy realinc5  age health  unemp ed  male hompop rep dem lib con, format
cat `tmp'aha.tex
! sed -i '1,4d' `tmp'aha.tex 
! head -n -2 `tmp'aha.tex > `tmp'aha2.tex
cat `tmp'aha2.tex

foreach i of varlist `x'{
di "`:var lab `i''"
! sed -i "s|`i'|`:var lab `i''|g" `tmp'aha2.tex
}
cat `tmp'aha2.tex

//if need sig can try net install mkcorr (newer version 2 i guess)
//set linesize 120
corrtex happy realinc5  age health  unemp ed  male hompop rep dem lib con, file(`tmp'ahb) replace   dig(2) //sig
//meh don't reallyneed sig--if it's big it is sig
cat `tmp'ahb.tex
//set linesize 78
! sed -i '1,2d' `tmp'ahb.tex 
! head -n -3 `tmp'ahb.tex > `tmp'ahb2.tex
cat `tmp'ahb2.tex
//foreach i of varlist `x'{
//di "`:var lab `i''"
//! sed -i "s|`i'|`:var lab `i''|g" `tmp'ahb2.tex
//}
//cat `tmp'ahb2.tex
//! perl -pe 's/[-+]?\d*(?:\.?\d|\d\.)\d*(?:[eE][-+]?\d+)?/sprintf("%.2f",$&)/ge' `tmp'ahb2.tex > `tmp'ahb3.tex
//cat `tmp'ahb3.tex
! sed -i "s|\\\multicolumn{1}{c}||g" `tmp'ahb2.tex

//replace in lines 3,4
! sed -i '1 s|\&|\\end{sideways}\&\\begin{sideways}|g' `tmp'ahb2.tex
! sed -i '1 s|{Variables} \\end{sideways}|{Variables}|g' `tmp'ahb2.tex
! sed -i '1 s|\\\\ \\hline|\\end{sideways}\\\\ \\hline|g' `tmp'ahb2.tex

//! sed -i 's|\\label{corrtable}}|\\label{corrtable}}\\tiny|g' `tmp'corr.tex



**** ana

*** initial playing

//LATER try as DV pil and casp


** volCha

reg swb volCha, robust cluster(country)
reg swb volCha inc health male mar age age2 emp, robust cluster(country)

reg swb ypen1 ypen2 ypen36 ypen4 ypen5, robust cluster(country)
reg swb ypen1 ypen2 ypen36 ypen4 ypen5, robust beta
reg swb ypen1 ypen2 ypen36 ypen4 ypen5, robust beta

reg swb volCha ypen1 ypen2 ypen36 ypen4 ypen5, robust cluster(country) //interesting some ypen neg! they must proxy some scikness!

reg swb volCha ypen1 ypen2 ypen36 ypen4 ypen5 [aw=cciw_w4], robust cluster(country)

reg swb volCha ypen1 ypen2 ypen36 ypen4 ypen5 inc health male mar age age2 emp, robust beta //yay! voluntering most important!

reg swb volCha ac035d*, robust cluster(country)

reg swb volCha ypen1 ypen2 ypen36 ypen4 ypen5 inc health male mar age age2 emp ac035d*, robust beta //yay! voluntering still sticks,but lower magnit
//ac035d9 ac035d8 mniej effectu niz z innymi ludzmi! lepiej z innymiu

reg swb volCha ypen1  inc health male mar age age2 emp ac035d* [aw=cciw_w4], robust  cluster(country)

svy: reg swb volCha ypen1 ypen2 ypen36 ypen4 ypen5 inc health male mar age age2 emp ac035d*,  

reg casp volCha ypen1 ypen2 ypen36 ypen4 ypen5 inc health male mar age age2 emp ac035d*, robust beta 

reg pil volCha ypen1 ypen2 ypen36 ypen4 ypen5 inc health male mar age age2 emp ac035d* , robust beta //pieniadze/transfsfers mniej wazne dla

//PL
reg swb volCha ypen1 ypen2 ypen36 ypen4 ypen5 inc health male mar age age2 emp ac035d* if countr==29, robust beta 

//DK
reg swb volCha ypen1 ypen2 ypen36 ypen4 ypen5 inc health male mar age age2 emp ac035d* if countr==18, robust beta

bys count:sum swb

bys count: reg swb volCha ypen1 ypen2 ypen36 ypen4 ypen5 inc health male mar age age2 emp ac035d* , robust beta

reg swb volCha ypen1 ypen2 ypen36 ypen4 ypen5 inc health male mar age age2 emp ac035d* i.count, robust beta //dummies should pick country infosyncracies

//more controls
perho otrf liab  hnetw yedu nchild rhfo
//rhfo can look not only at giving but also receiving
//nchil may be important for elderly to have sb to rely on!



leszeks idea: follow debbie's article: extend hers with wave 4 and 6 plus maybe
focus on ee

BY COUNTRY AND/OR FOCUS ON POLAND

leszek: match countries into groups based on estimates
aok: rank them based on coefficients

/*lm:!may want to do by country--differs a lot by country!
udzial zasilku z bezrobocia wszedzie - a w pl (i slovenia) +

may be due to ingroup: przyzwolenie spoleczne na zasilek w polsce a nie na */
/*volunteering

in pol in 2016 zasilek negtywny--leszek mowi ze liczba osob pobierajacych */
/*zasilek zmalala o duzo!
pol different from others--can do one paper on otherness of poland
*/



levelsof iso, loc(_iso)
foreach i of local _iso{
di "---------------------------------------------------------------------------------"
di "`i'"
reg swb volCha if iso=="`i'", robust 
}

** zasilek

est drop *
levelsof iso, local(ii)
foreach i of local ii{
di "---------------------------------------------------------------------------------"
di "`i'"
reg swb ub heal inc empl if iso=="`i'"
loc j=strtoname("`i'")
est title: "`i'"
est sto b_`j'
}

reg swb ypen4 heal inc empl if cs=="Austria",beta
//est table b_Austria, star b(%9.2f)beta

//esttab b*_Austria
//esttab b_Austria ,  cells(b(star fmt(%9.2f)))

estout b* using `tmp't1.txt,style(tab)  cells(b(star fmt(%9.2f))) replace  collabels(, none) stats(N, labels("N")fmt(%9.0f)) label keep(ub)
//esttab r(coefs, transpose)

//net install sxpose, from(http://fmwww.bc.edu/RePEc/bocode/s)
preserve
clear
insheet using `tmp't1.txt, tab nonames
sxpose, clear
l 
//outsheet using "test_transposed.xls", replace nonames
restore


estout b* ,  cells(b(star fmt(%9.2f))) replace  collabels(, none) stats(N, labels("N")fmt(%9.0f))varlabels(_cons constant) label starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) // keep(1.white#* 1.black#* 1.hisp#*)

estout b*  using `tmp'regC.tex ,  cells(b(star fmt(%9.2f))) replace style(tex) collabels(, none) stats(N, labels("N")fmt(%9.0f))varlabels(_cons constant) label starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) // keep(1.white#* 1.black#* 1.hisp#*)


  
*** paper estimates

est restore wvsA2 //this is the main specification
count if e(sample)==1
emd, s(%9.0f `r(N)' )t(wvsN)ra(append)

ta yr if e(sample)==1
sum yr  if e(sample)==1
loc mm  " `r(min)'-`r(max)' "
di "`mm'"
emd, s( "`mm'" )t(wvsYr)ra(append) //sometimes need dble quotes

ta c if e(sample)==1
emd, s( `r(r)' )t(wvsK)ra(append)


**  regressions


* 1 descripton of what's up here in this table

* 2 another table etc

* aloways have table wuith some robistness checks--fixed effects etc etc, perhaps in the appendix 


file close f
! cat `d'notes.txt

