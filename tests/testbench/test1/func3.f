      function func3 (v)
          include 'incl1.inc'
          integer v, func3

          integer i
          state = state+v
          func3=state / v
          print *, func3
          return
      end
