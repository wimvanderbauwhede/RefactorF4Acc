module sub
     use singleton_module_init
     use singleton_module_dyn
     use singleton_module_shapiro
     interface init
       module procedure init
     end interface init
     interface dyn
       module procedure dyn
     end interface dyn
     interface shapiro
       module procedure shapiro
     end interface shapiro
end module sub
