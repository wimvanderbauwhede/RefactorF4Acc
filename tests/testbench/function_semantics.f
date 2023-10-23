      program tsp
      
      integer ia1,ia2
      integer rif
      ia1=10          
      ! So the semantics is that first rif(ia1) is called
      ! then the expression is calculated
      ia2 = ia1 + rif(ia1) + ia1
      print *,ia1,ia2 ! 
      end 

      integer function rif(ia1)
         integer ia1
         rif = ia1*ia1
         ia1 = rif
      end
     
