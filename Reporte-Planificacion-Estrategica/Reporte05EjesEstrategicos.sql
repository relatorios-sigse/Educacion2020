select
/**

Modificaciones
14-01-2022. Andrés Del Río. Cambio de año actual por año anterior, por solicitud de Claudio Pérez. <!%YEAR%> fue reemplazado por <!%YEAR%> - 1
**/
round(suma_trimestres / cantidad_trimestres, 2) acumulado,
ejes.*
from
(select
trim.id_eje_estrategico,
trim.eje_estrategico,
trim.Subtotal_T1,
trim.Subtotal_T2,
trim.Subtotal_T3,
trim.Subtotal_T4,
COALESCE( trim.Subtotal_T1, 0)  + COALESCE( trim.Subtotal_T2, 0)  + COALESCE( trim.Subtotal_T3, 0) + COALESCE(  trim.Subtotal_T4, 0) suma_trimestres,
CASE WHEN  trim.Subtotal_T1 IS NOT NULL
	THEN 1
	ELSE 0
END  + CASE WHEN  trim.Subtotal_T2 IS NOT NULL
	THEN 1
	ELSE 0
END  + CASE WHEN  trim.Subtotal_T3 IS NOT NULL
	THEN 1
	ELSE 0
END  + CASE WHEN  trim.Subtotal_T4 IS NOT NULL
	THEN 1
	ELSE 0
END  cantidad_trimestres,
1 as Cantidad
from
(select 

COALESCE((
						SELECT AB.IDSCSTRUCTITEM
						FROM STSCORECARDTREE OWNER
						INNER JOIN STSCORECARDTREE OWNER2 ON (
								OWNER.CDSCORECARD = OWNER2.CDSCORECARD
								AND OWNER.CDREVISION = OWNER2.CDREVISION
								AND OWNER.CDSCORECARDTREEOWNER = OWNER2.CDSCORECARDTREE
								)
						INNER JOIN STSCORECARDTREE OWNER3 ON (
								OWNER2.CDSCORECARD = OWNER3.CDSCORECARD
								AND OWNER2.CDREVISION = OWNER3.CDREVISION
								AND OWNER2.CDSCORECARDTREEOWNER = OWNER3.CDSCORECARDTREE
								)
						INNER JOIN STSCORECARDTREE OWNER4 ON (
								OWNER3.CDSCORECARD = OWNER4.CDSCORECARD
								AND OWNER3.CDREVISION = OWNER4.CDREVISION
								AND OWNER3.CDSCORECARDTREEOWNER = OWNER4.CDSCORECARDTREE
								)
						INNER JOIN STSCORECARDTREE OWNER5 ON (
								OWNER4.CDSCORECARD = OWNER5.CDSCORECARD
								AND OWNER4.CDREVISION = OWNER5.CDREVISION
								AND OWNER4.CDSCORECARDTREEOWNER = OWNER5.CDSCORECARDTREE
								)
						INNER JOIN STSCSTRUCTITEM AB ON (
								AB.CDSCSTRUCTITEM = OWNER5.CDSCSTRUCTITEM
								AND AB.CDSCORECARD = OWNER5.CDSCORECARD
								AND AB.CDREVISION = OWNER5.CDREVISION
								)
						INNER JOIN STSCOREITEM AC ON (AC.CDSCOREITEM = AB.CDSCOREITEM)
						WHERE OWNER.CDSCORECARDTREE = TREE.CDSCORECARDTREEOWNER
							AND OWNER.CDREVISION = TREE.CDREVISION
							AND OWNER.CDSCORECARD = TREE.CDSCORECARD
						), (
						SELECT AC.NMSCORECARD
						FROM STSCORECARDTREE OWNER
							,STSCORECARD AC
						WHERE OWNER.CDSCORECARDTREE = TREE.CDSCORECARDTREEOWNER
							AND AC.CDSCORECARD = OWNER.CDSCORECARD
							AND AC.CDREVISION = OWNER.CDREVISION
							AND OWNER.CDREVISION = TREE.CDREVISION
						)) AS id_eje_estrategico,					

COALESCE((
						SELECT AC.NMSCOREITEM
						FROM STSCORECARDTREE OWNER
						INNER JOIN STSCORECARDTREE OWNER2 ON (
								OWNER.CDSCORECARD = OWNER2.CDSCORECARD
								AND OWNER.CDREVISION = OWNER2.CDREVISION
								AND OWNER.CDSCORECARDTREEOWNER = OWNER2.CDSCORECARDTREE
								)
						INNER JOIN STSCORECARDTREE OWNER3 ON (
								OWNER2.CDSCORECARD = OWNER3.CDSCORECARD
								AND OWNER2.CDREVISION = OWNER3.CDREVISION
								AND OWNER2.CDSCORECARDTREEOWNER = OWNER3.CDSCORECARDTREE
								)
						INNER JOIN STSCORECARDTREE OWNER4 ON (
								OWNER3.CDSCORECARD = OWNER4.CDSCORECARD
								AND OWNER3.CDREVISION = OWNER4.CDREVISION
								AND OWNER3.CDSCORECARDTREEOWNER = OWNER4.CDSCORECARDTREE
								)
						INNER JOIN STSCORECARDTREE OWNER5 ON (
								OWNER4.CDSCORECARD = OWNER5.CDSCORECARD
								AND OWNER4.CDREVISION = OWNER5.CDREVISION
								AND OWNER4.CDSCORECARDTREEOWNER = OWNER5.CDSCORECARDTREE
								)
						INNER JOIN STSCSTRUCTITEM AB ON (
								AB.CDSCSTRUCTITEM = OWNER5.CDSCSTRUCTITEM
								AND AB.CDSCORECARD = OWNER5.CDSCORECARD
								AND AB.CDREVISION = OWNER5.CDREVISION
								)
						INNER JOIN STSCOREITEM AC ON (AC.CDSCOREITEM = AB.CDSCOREITEM)
						WHERE OWNER.CDSCORECARDTREE = TREE.CDSCORECARDTREEOWNER
							AND OWNER.CDREVISION = TREE.CDREVISION
							AND OWNER.CDSCORECARD = TREE.CDSCORECARD
						), (
						SELECT AC.NMSCORECARD
						FROM STSCORECARDTREE OWNER
							,STSCORECARD AC
						WHERE OWNER.CDSCORECARDTREE = TREE.CDSCORECARDTREEOWNER
							AND AC.CDSCORECARD = OWNER.CDSCORECARD
							AND AC.CDREVISION = OWNER.CDREVISION
							AND OWNER.CDREVISION = TREE.CDREVISION
						)) AS eje_estrategico,
						
	AVG(rep1.Subtotal_T1) Subtotal_T1,					
	AVG(rep1.Subtotal_T2) Subtotal_T2,		
	AVG(rep1.Subtotal_T3) Subtotal_T3,		
	AVG(rep1.Subtotal_T4) Subtotal_T4	
from
(select 
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
 ) rep1
left join stscmetric sc2 on sc2.cdscmetric = rep1.cdindicador
JOIN STSCORECARDTREE TREE ON (
					TREE.CDSCMETRIC = sc2.CDSCMETRIC
					AND TREE.CDSCORECARD = sc2.CDSCORECARD
					AND TREE.CDREVISION = sc2.CDREVISION
					)
GROUP BY id_eje_estrategico, eje_estrategico
order by 1) trim ) ejes