# We assume for simplification that all includes have common blocks

def find_root_for_includes (stref, f)
# 1. Create the "include chains"
    stref = create_include_chains( stref, 0 )
# 2. loop over all includes with common blocks	
    for inc in stref['IncludeFiles'].keys 
		stref = find_root_for_include( stref, inc, f )
    end
    return stref
end   # END of find_root_for_includes()

# -----------------------------------------------------------------------------
=begin

`find_root_for_include()` is called for every include file in IncludeFiles, after `create_include_chains()` has created all the chains
by 'chain' we mean a path in the call tree where every node contains the include for its child nodes.
The purpose of this routine is to prune the paths, i.e. remove includes from nodes that don't need them.
The algorithm is as follows: 
- compare Includes with CommonIncludes.
    - if an inc is only in CommonIncludes, it is inherited
    - the node needs to keep it if either
        - it has more than one child node
        - it contains a call to a refactored subroutine which contains the include  
    - any other case, just remove the include
=end

def find_root_for_include ( stref, inc, sub) 
    s_sub = stref['Subroutines'][sub]
    if s_sub['Includes'].has?(inc) 
        # Not inherited
        stref['IncludeFiles'][inc]['Root'] = sub
        # Inherited 
        # sub is (currently) not 'Root' for inc
        nchildren   = 0
        singlechild = ''
        for calledsub ( s_sub['CalledSubs'].keys )
            if stref['Subroutines'][calledsub]['CommonIncludes'].has?(inc)
                nchildren++
                singlechild = calledsub
            end
        end

		if ( nchildren == 1 and s_sub['RefactorGlobals']==0)
            s_sub['CommonIncludes'][inc].delete
            find_root_for_include( stref, inc, singlechild )
            
            # head node is root
            stref['IncludeFiles'][inc]['Root'] = sub
        end
    end
    return stref
end   # END of find_root_for_include()

# -----------------------------------------------------------------------------
# What we do is simply a recursive descent until we hit the include and we log that path
# Then we prune the paths until they differ, that's the root
# We also need to add the include to all nodes in the divergent paths
def create_include_chains ( stref, nid ) 
    if ( stref['Nodes'][nid].has?('Children')
        # Find all children of nid
        children = stref['Nodes'][nid]['Children']
# Now for each of these children, find their children until the leaf nodes are reached
        for child in children
            stref = create_include_chains( stref, child )
        end
    
# We reached a leaf node
# Now we work our way back up via the parent using a separate recursive function
        stref = merge_includes( stref, nid, nid, '' )
    end
    return stref
}    # END of create_include_chains()

# -----------------------------------------------------------------------------
# From each leaf node we follow the path back to the root of the tree
# We combine all includes of all child nodes of a node, and the node's own includes, into CommonIncludes

def merge_includes ( stref, nid, cnid, chain ) 

    # If there are includes with common blocks, merge them into CommonIncludes
    pnid = stref['Nodes'][nid]['Parent']
    sub = stref['Nodes'][nid]['Subroutine']
    
    s_sub = stref['Subroutines'][sub]
    if ( s_sub.has?('Includes') and not s_sub.has?('CommonIncludes'))
        for inc in s_sub['Includes'].keys 
            if not exists s_sub['CommonIncludes'].has?(inc)
                s_sub['CommonIncludes'][inc]= 1
            end
        end
    end
    if ( nid != cnid )
        csub  = stref['Nodes'][cnid]['Subroutine']
        s_csub = stref['Subroutines'][csub]
        if s_csub.has?('CommonIncludes')
            for inc in s_csub['CommonIncludes'].keys  
                if not s_sub['CommonIncludes'].has?(inc)
                    s_sub['CommonIncludes'][inc]= 1
                end
            end
        end
    end
    stref['Subroutines'][sub]=s_sub 
    if ( nid != 0 )
        stref = merge_includes( stref, pnid, nid,chain )
    end
    return stref
end    # END of merge_includes