      integer function func2 (v)
          include 'incl1.inc'
          integer v

          integer i
          state = state+ ( v / 2 )
          func2=v-state
          return
      end
