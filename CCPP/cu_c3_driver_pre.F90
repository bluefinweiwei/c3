!> \file cu_c3_driver_pre.F90
!!  Contains code related to the C3 convective schemes to be used within the GFS physics suite.

module cu_c3_driver_pre

   implicit none

   private

   public :: cu_c3_driver_pre_run

   contains

!>\ingroup cu_c3_group
!> \section arg_table_cu_c3_driver_pre_run Argument Table
!! \htmlinclude cu_c3_driver_pre_run.html
!!
   subroutine cu_c3_driver_pre_run (cactiv, cactiv_m, conv_act, conv_act_m,         &
                                    errmsg, errflg)

      use machine, only: kind_phys

      implicit none

      integer,          intent(out) :: cactiv(:)
      integer,          intent(out) :: cactiv_m(:)
!$acc declare copyout(forcet,forceq,cactiv,cactiv_m)
      real(kind_phys),  intent(in)  :: conv_act(:)
      real(kind_phys),  intent(in)  :: conv_act_m(:)
!$acc declare copyin(conv_act,conv_act_m)
      character(len=*), intent(out) :: errmsg
      integer,          intent(out) :: errflg

      ! Initialize CCPP error handling variables
      errmsg = ''
      errflg = 0


!$acc kernels
      cactiv(:)=nint(conv_act(:))
      cactiv_m(:)=nint(conv_act_m(:))
!$acc end kernels

   end subroutine cu_c3_driver_pre_run

end module cu_c3_driver_pre
