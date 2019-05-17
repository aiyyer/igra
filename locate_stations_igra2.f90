program locate_stations
!------------------------------------------------------------------------
! output list of stations within specified geographic lat-lon bounds
!
! Version 1.0
! NCSU Tropical Dynamics Group
! Aiyyer
! To compile:   gfortran -o locate_stations locate_stations_igra2.f90 
!------------------------------------------------------------------------
  implicit none
  
  character (len = 11 ) :: id
  character (len = 2 )  :: state
  
  character (len = 30 ) :: name
  real :: lat,lon,elev,latBottom,lonWest,latTop,lonEast
  integer:: i,year1,year2,nobs,j,yearA,yearB
  character (len=80) :: argv
!!external :: iargc     !!$ comment this for gfortran


  print *, "Usage:"
  print *, "locate_stations latBottom lonWest latTop lonEast year1 year2"
  
  j = iargc()
  if ( j< 6 )  then
     print *, "STOP! Not enough input data"
     stop
  endif
!!$  
  call getarg ( 1, argv) ; read(argv,*) latBottom
  call getarg ( 2, argv) ; read(argv,*) lonWest
  call getarg ( 3, argv) ; read(argv,*) latTop
  call getarg ( 4, argv) ; read(argv,*) lonEast
  call getarg ( 5, argv) ; read(argv,*) yearA
  call getarg ( 6, argv) ; read(argv,*) yearB


!!$
!!$
  open ( unit = 20, file = "igra2-station-list.txt", form = "formatted" )
!!  open ( unit = 40, file = "wget.sc", form = "formatted")
  
  do i = 1,100000
     read  (20,100,end=30) id,lat,lon,elev,state,name,year1,year2,nobs
     
     if ( lat >= latBottom .and. lat <= latTop) then
        if ( lon >=lonWest .and. lon <= lonEast) then

           if ( year1 <= yearA .and. year2 >= yearB ) then


              
           write(100,100) id,lat,lon,elev,state,name,year1,year2,nobs
           write(30,120) id
           write(31,130) lat,lon
           !!            write(40,110) id

            end if
           
        end if
     end if
     
  enddo
  
30 continue

110 format ("wget https://www1.ncdc.noaa.gov/pub/data/igra/data/data-por/",a11,"-data.txt.zip") 
120 format (a11)
130 format (f8.4,1x,f9.4)
100 format (a11,1x,f8.4,1x,f9.4,1x,a6,1x,a2,1x,a30,1x,i4,1x,i4,1x,i6)





end program locate_stations
