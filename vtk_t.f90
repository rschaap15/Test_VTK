PROGRAM set3d
!*************************************************************************************!
! Call Modules and Libraries
!*************************************************************************************!

USE Lib_VTK_IO

IMPLICIT NONE


!*************************************************************************************!
!
! Parallel Min/Max Flow Level Set Solver
!
! Version: 3.0  
!
! Date: 20/4/2016
!
! Type: H-J WENO 5 Serial Explicit TVD R-K Level Set Solver
!
!*************************************************************************************!
INTEGER :: E_IO

INTEGER,DIMENSION(6) :: x_loc, y_loc, z_loc
INTEGER,DIMENSION(6) :: conn
INTEGER,DIMENSION(1) :: offS
INTEGER*1,DIMENSION(1) :: cellT

x_loc   = (/0,1,0,0,1,0/)
y_loc   = (/0,0,1,0,0,1/)
z_loc   = (/0,0,0,1,1,1/)

conn    = (/1,2,3,4,5,6/)
offS    = (/0/)
cellT(1)= 13    

    !*************************************************************************************!
    ! Output to VTS file using the following subroutine
    !*************************************************************************************!
        WRITE(*,*) 'Writing file test.vtu'
        E_IO = VTK_INI_XML_write(fformat='ascii', filename='test.vtu',mesh_topology='UnstructuredGrid')
        E_IO = VTK_FLD_XML(fld_action='open')
        E_IO = VTK_FLD_XML(fld=0.e1,fname='TIME')
        E_IO = VTK_FLD_XML(fld=1,fname='CYCLE')
        E_IO = VTK_FLD_XML(fld_action='close')
        E_IO = VTK_GEO_XML_WRITE(6,1,x_loc,y_loc,z_loc)
!       E_IO = VTK_GEO_XML_WRITE(&
!        E_IO = VTK_GEO_XML(&
!           NN = 6          ,&
!           NC = 1          ,&
!           X  = x_loc      ,&
!           Y  = y_loc      ,&
!           Z  = z_loc      )
        E_IO = VTK_CON_XML(&
            NC       = 1         ,&
            connect  = conn      ,&
            offset   = offS      ,&
            cell_type = cellT     )
        E_IO = VTK_GEO_XML_WRITE()
        !E_IO = VTK_GEO_XML()
        E_IO = VTK_END_XML()


!*************************************************************************************!
! Program End
!*************************************************************************************!

END PROGRAM set3d
