select 
/**

Modificaciones
14-01-2022. Andrés Del Río. Cambio de año actual por año anterior, por solicitud de Claudio Pérez. <!%YEAR%> fue reemplazado por <!%YEAR%> - 1
**/

tra.cdindicador,
tra.Meta,
tra.Indicador,
tra."1",
tra."2",
tra."3",
/**(COALESCE(tra."1",0)+COALESCE(tra."2",0)+COALESCE(tra."3",0))*1.0 / 3 Subtotal_T1,**/

(
select 
  distinct
    case       
when stran2.FGRANGECONFIG = 1  then val2.VLPERUPACCUM      
when stran2.FGRANGECONFIG = 2  then val2.VLPERDOWNACCUM      
when stran2.FGRANGECONFIG = 3  then val2.VLPERESTACCUM      
 end
from stscmetrictarget val2 
  join stscmetric sc2 on sc2.cdscmetric = val2.cdscmetric
  join strange stran2 on sc2.cdrange = stran2.cdrange
where sc2.cdscmetric = tra.cdindicador
  and val2.nrperiod in
  (
    select max(val3.nrperiod) 
    from stscmetrictarget val3 
    where val3.cdscmetric = sc2.cdscmetric
    and val3.nrperiod <= 3
    and val3.nryear = <!%YEAR%> - 1
    and val3.fgnotapply = 2
    and not (val3.VLPERUPACCUM is null and val3.VLPERDOWNACCUM is null and val3.VLPERESTACCUM is null )
  )
  and val2.nryear = <!%YEAR%> - 1
) Subtotal_T1,

tra."4",
tra."5",
tra."6",
/**(COALESCE(tra."4",0)+COALESCE(tra."5",0)+COALESCE(tra."6",0))*1.0 / 3 Subtotal_T2,**/
(
select 
  distinct
    case       
when stran2.FGRANGECONFIG = 1  then val2.VLPERUPACCUM      
when stran2.FGRANGECONFIG = 2  then val2.VLPERDOWNACCUM      
when stran2.FGRANGECONFIG = 3  then val2.VLPERESTACCUM      
 end
from stscmetrictarget val2 
  join stscmetric sc2 on sc2.cdscmetric = val2.cdscmetric
  join strange stran2 on sc2.cdrange = stran2.cdrange
where sc2.cdscmetric = tra.cdindicador
  and val2.nrperiod in
  (
    select max(val3.nrperiod) 
    from stscmetrictarget val3 
    where val3.cdscmetric = sc2.cdscmetric
    and val3.nrperiod > 3 and val3.nrperiod <= 6
    and val3.nryear = <!%YEAR%> - 1 
    and val3.fgnotapply = 2
    and not (val3.VLPERUPACCUM is null and val3.VLPERDOWNACCUM is null and val3.VLPERESTACCUM is null )
  )
  and val2.nryear = <!%YEAR%> - 1
) Subtotal_T2,
tra."7",
tra."8",
tra."9",
/**(COALESCE(tra."7",0)+COALESCE(tra."8",0)+COALESCE(tra."9",0))*1.0 / 3 Subtotal_T3,**/
(
select 
  distinct
    case       
when stran2.FGRANGECONFIG = 1  then val2.VLPERUPACCUM      
when stran2.FGRANGECONFIG = 2  then val2.VLPERDOWNACCUM      
when stran2.FGRANGECONFIG = 3  then val2.VLPERESTACCUM      
 end
from stscmetrictarget val2 
  join stscmetric sc2 on sc2.cdscmetric = val2.cdscmetric
  join strange stran2 on sc2.cdrange = stran2.cdrange
where sc2.cdscmetric = tra.cdindicador
  and val2.nrperiod in
  (
    select max(val3.nrperiod) 
    from stscmetrictarget val3 
    where val3.cdscmetric = sc2.cdscmetric
    and val3.nrperiod > 6 and val3.nrperiod <= 9
    and val3.nryear = <!%YEAR%> - 1 
    and val3.fgnotapply = 2
    and not (val3.VLPERUPACCUM is null and val3.VLPERDOWNACCUM is null and val3.VLPERESTACCUM is null )
  )
  and val2.nryear = <!%YEAR%> - 1
) Subtotal_T3,

tra."10",
tra."11",
tra."12",
/**(COALESCE(tra."10",0)+COALESCE(tra."11",0)+COALESCE(tra."12",0))*1.0 / 3 Subtotal_T4,**/
(
select 
  distinct
    case       
when stran2.FGRANGECONFIG = 1  then val2.VLPERUPACCUM      
when stran2.FGRANGECONFIG = 2  then val2.VLPERDOWNACCUM      
when stran2.FGRANGECONFIG = 3  then val2.VLPERESTACCUM      
 end
from stscmetrictarget val2 
  join stscmetric sc2 on sc2.cdscmetric = val2.cdscmetric
  join strange stran2 on sc2.cdrange = stran2.cdrange
where sc2.cdscmetric = tra.cdindicador
  and val2.nrperiod in
  (
    select max(val3.nrperiod) 
    from stscmetrictarget val3 
    where val3.cdscmetric = sc2.cdscmetric
    and val3.nrperiod > 9 and val3.nrperiod <= 12
    and val3.nryear = <!%YEAR%> - 1 
    and val3.fgnotapply = 2
    and not (val3.VLPERUPACCUM is null and val3.VLPERDOWNACCUM is null and val3.VLPERESTACCUM is null )
  )
  and val2.nryear = <!%YEAR%> - 1
) Subtotal_T4,

(
select 
  distinct
    case       
when stran2.FGRANGECONFIG = 1  then val2.VLPERUPACCUM2      
when stran2.FGRANGECONFIG = 2  then val2.VLPERDOWNACCUM2      
when stran2.FGRANGECONFIG = 3  then val2.VLPERESTACCUM2      
 end
from stscmetrictarget val2 
  join stscmetric sc2 on sc2.cdscmetric = val2.cdscmetric
  join strange stran2 on sc2.cdrange = stran2.cdrange
where sc2.cdscmetric = tra.cdindicador
  and val2.nrperiod in
  (
    select max(val3.nrperiod) 
    from stscmetrictarget val3 
    where val3.cdscmetric = sc2.cdscmetric
    and val3.nrperiod <= 12
    and val3.nryear = <!%YEAR%> - 1 
    and val3.fgnotapply = 2
    and not (val3.VLPERUPACCUM2 is null and val3.VLPERDOWNACCUM2 is null and val3.VLPERESTACCUM2 is null )
  )
  and val2.nryear = <!%YEAR%> - 1
) Subtotal_Anio,


1 as cantidad
from (select  * from crosstab (

$$ select 
  sc.cdscmetric,
  COALESCE((
						SELECT AC.NMSCOREITEM
						FROM STSCORECARDTREE OWNER
							,STSCSTRUCTITEM AB
							,STSCOREITEM AC
						WHERE OWNER.CDSCORECARDTREE = TREE.CDSCORECARDTREEOWNER
							AND AB.CDSCSTRUCTITEM = OWNER.CDSCSTRUCTITEM
							AND AB.CDSCORECARD = OWNER.CDSCORECARD
							AND AB.CDREVISION = OWNER.CDREVISION
							AND OWNER.CDREVISION = TREE.CDREVISION
							AND AC.CDSCOREITEM = AB.CDSCOREITEM
						), (
						SELECT AC.NMSCORECARD
						FROM STSCORECARDTREE OWNER
							,STSCORECARD AC
						WHERE OWNER.CDSCORECARDTREE = TREE.CDSCORECARDTREEOWNER
							AND AC.CDSCORECARD = OWNER.CDSCORECARD
							AND AC.CDREVISION = OWNER.CDREVISION
							AND OWNER.CDREVISION = TREE.CDREVISION
						)) AS NMSCOREITEMOWNER,  
  
  m.nmmetric,
  vl.nrperiod, 
  case       
when STRAN.FGRANGECONFIG = 1  then vl.VLPERUP      
when STRAN.FGRANGECONFIG = 2  then vl.VLPERDOWN      
when STRAN.FGRANGECONFIG = 3  then vl.VLPEREST      
 end as vlpercent
 
  from stscmetrictarget vl 
  join stscmetric sc on sc.cdscmetric = vl.cdscmetric 
  JOIN STMETRIC M ON M.CDMETRIC = SC.CDMETRIC
  left join strange stran on sc.cdrange = stran.cdrange
  JOIN STSCORECARDTREE TREE ON (
					TREE.CDSCMETRIC = SC.CDSCMETRIC
					AND TREE.CDSCORECARD = SC.CDSCORECARD
					AND TREE.CDREVISION = SC.CDREVISION
					)
where sc.cdscorecard in (select cdscorecard from stscorecard where idscorecard = 'PLAN-0001') and vl.nryear = <!%YEAR%> - 1 
order by 1 $$,
  
$$ select distinct nrperiod from stscmetrictarget vl join stscmetric sc on sc.cdscmetric = vl.cdscmetric 
where sc.cdscorecard in (select cdscorecard from stscorecard where idscorecard = 'PLAN-0001') and nryear = <!%YEAR%> - 1 order by 1  $$) 
as ct(cdindicador integer, Meta text, Indicador text, "1" numeric, "2" numeric, "3" numeric, "4" numeric, "5" numeric, "6" numeric, "7" numeric, "8" numeric, "9" numeric, "10" numeric, "11" numeric, "12" numeric)) tra
