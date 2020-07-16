      function func1 (v)
      include 'incl1.inc'
      integer func1, v, vv ! vv is unused

      state = state+v ! state is common
      func1 = v+1
      print *, func1
      return ! returns func1, so v+1
      end
