      integer function func2 (v)
          include 'incl1.inc'
          integer v

          integer i
          state = state+ ( v / 2 )
          print *, v, state
          func2=v-state
          return
      end
