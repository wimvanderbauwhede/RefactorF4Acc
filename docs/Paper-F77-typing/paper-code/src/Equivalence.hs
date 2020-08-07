
equate_overlapping_ranges index1 dim1 index2 dim2 = let
	(offset1,end_index1)    = dim1
	(offset2,end_index2)    = dim2
    in
	    | index1 - offset1 < index2 - offset2 =
            let
		        trange1 = index1 - offset1
		        start_index2 = ( index2 - offset2 + 1 ) - trange1
		        range2 = end_index2 - start_index2
	            range1 = end_index1 - offset1
		    in
		        | end_index2 - start_index2 < end_index1 - offset1 =
			    ((offset1,offset1+range2),(start_index2,end_index2))
		        | otherwise = 		
			    ((offset1,end_index1),(start_index2,start_index2+range1))		
	    | otherwise =  --reverse the whole thing
	        let
		        trange2 = index2 - offset2
		        start_index1 = (index1-offset1+1)-trange2
		        range1 = end_index1 - start_index1
		        range2 = end_index2 - offset2
		    in
		        | end_index1 - start_index1 < end_index2 - offset2  =
			     (( start_index1,end_index1), ( offset2,offset2+range1))
		        | otherwise = 			    
			    (( offset2, end_index2), (start_index1,start_index1+range2))		
	
